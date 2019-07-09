//
//  SXNetworkHelper.m
//  Animation
//
//  Created by Sco.X on 2018/9/4.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "SXNetworkHelper.h"
#include <ifaddrs.h>
#import <sys/socket.h>
#include <net/if_var.h>

#define kIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation SXNetworkHelper

static SXNetworkHelper *_instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

+ (NSString *)currentDeviceNetwork {
    UIApplication *app = [UIApplication sharedApplication];
    id statusBar = [app valueForKeyPath:@"statusBar"];
    NSString *network = @"";
    
    if (kIsiPhoneX) {
        //        iPhone X
        id statusBarView = [statusBar valueForKeyPath:@"statusBar"];
        UIView *foregroundView = [statusBarView valueForKeyPath:@"foregroundView"];
        
        NSArray *subviews = [[foregroundView subviews][2] subviews];
        
        for (id subview in subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                network = @"WIFI";
            }else if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]) {
                network = [subview valueForKeyPath:@"originalText"];
            }
        }
    }else {
        //        非 iPhone X
        UIView *foregroundView = [statusBar valueForKeyPath:@"foregroundView"];
        NSArray *subviews = [foregroundView subviews];
        
        for (id subview in subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                int networkType = [[subview valueForKeyPath:@"dataNetworkType"] intValue];
                switch (networkType) {
                    case 0:
                        network = @"NONE";
                        break;
                    case 1:
                        network = @"2G";
                        break;
                    case 2:
                        network = @"3G";
                        break;
                    case 3:
                        network = @"4G";
                        break;
                    case 5:
                        network = @"WIFI";
                        break;
                    default:
                        break;
                }
            }
        }
    }
    if ([network isEqualToString:@""]) {
        network = @"NO DISPLAY";
    }
    return network;
}

+ (SXNetworkType)networkType {
    SXNetworkType networkType;
    NSString *networkStr = [self currentDeviceNetwork];
    if ([networkStr isEqualToString:@"WIFI"]) {
        networkType = SXNetworkWiFi;
    }else if ([networkStr isEqualToString:@"2G"]) {
        networkType = SXNetwork2G;
    }else if ([networkStr isEqualToString:@"3G"]) {
        networkType = SXNetwork3G;
    }else if ([networkStr isEqualToString:@"4G"]) {
        networkType = SXNetwork4G;
    }else if ([networkStr isEqualToString:@"NONE"]) {
        networkType = SXNetworkNone;
    }else {
        networkType = SXNetworkUnknown;
    }
    return networkType;
}

- (SXNetworkType)networkType {
    return [[self class] networkType];
}

- (NSArray *)getDataCounters
{
    BOOL success;
    struct ifaddrs *addrs;
    struct ifaddrs *cursor;
    struct if_data *networkStatisc;
    long WiFiSent = 0;
    long WiFiReceived = 0;
    long WWANSent = 0;
    long WWANReceived = 0;
    NSString *name=[[NSString alloc]init];
    success = getifaddrs(&addrs) == 0;
    if (success)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
            if (cursor->ifa_addr->sa_family == AF_LINK)
            {
                if ([name hasPrefix:@"en"])
                {
                    networkStatisc = (struct if_data *) cursor->ifa_data;
                    WiFiSent += networkStatisc->ifi_obytes;
                    WiFiReceived += networkStatisc->ifi_ibytes;
                }
                if ([name hasPrefix:@"pdp_ip"])
                {
                    networkStatisc = (struct if_data *) cursor->ifa_data;
                    WWANSent+=networkStatisc->ifi_obytes;
                    WWANReceived+=networkStatisc->ifi_ibytes;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return [NSArray arrayWithObjects:[NSNumber numberWithInt:WiFiSent/1024.0], [NSNumber numberWithInt:WiFiReceived/1024.0],[NSNumber numberWithInt:WWANSent/1024.0],[NSNumber numberWithInt:WWANReceived/1024.0], nil];
}

static float preWifi_S = 0,preWifi_R = 0,preWWAN_S = 0,preWWAN_R = 0;
- (float)wifiS_PerSencond {
    if (self.networkType != SXNetworkWiFi) return 0;
    float wifiS_preSecond = [[self getDataCounters][0] floatValue] - preWifi_S;
    preWifi_S = [[self getDataCounters][0] floatValue];
    return wifiS_preSecond;
}
- (float)wifiR_PerSencond {
    if (self.networkType != SXNetworkWiFi) return 0;
    float wifiR_preSecond = [[self getDataCounters][1] floatValue] - preWifi_R;
    preWifi_R = [[self getDataCounters][1] floatValue];
    return wifiR_preSecond;
}
- (float)wwanS_PerSencond {
    if (self.networkType == SXNetworkWiFi || self.networkType == SXNetworkNone || self.networkType == SXNetworkUnknown) return 0;
    float wwanS_preSecond = [[self getDataCounters][2] floatValue] - preWWAN_S;
    preWWAN_S = [[self getDataCounters][2] floatValue];
    return wwanS_preSecond;
}
- (float)wwanR_PerSencond {
    if (self.networkType == SXNetworkWiFi || self.networkType == SXNetworkNone || self.networkType == SXNetworkUnknown) return 0;
    float wwanR_preSecond = [[self getDataCounters][3] floatValue] - preWWAN_R;
    preWWAN_R = [[self getDataCounters][3] floatValue];
    return wwanR_preSecond;
}

@end
