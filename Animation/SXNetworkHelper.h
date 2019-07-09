//
//  SXNetworkHelper.h
//  Animation
//
//  Created by Sco.X on 2018/9/4.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SXNetworkType) {
    SXNetworkUnknown,  // 未知
    SXNetworkNone,  // 无网络
    SXNetwork2G,    // 2g网络
    SXNetwork3G,    // 3g网络
    SXNetwork4G,    // 4g网络
    SXNetworkWiFi,  // wifi网络
};

@interface SXNetworkHelper : NSObject

+ (instancetype)sharedInstance;

+ (SXNetworkType)networkType;
- (SXNetworkType)networkType;

- (float)wifiS_PerSencond;
- (float)wifiR_PerSencond;
- (float)wwanS_PerSencond;
- (float)wwanR_PerSencond;

@end
