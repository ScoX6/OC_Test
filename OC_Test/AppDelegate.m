//
//  AppDelegate.m
//  OC_Test
//
//  Created by Sco.X on 2018/8/24.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "AppDelegate.h"
#import <objc/runtime.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)load {
    SEL originSel = @selector(application:didFinishLaunchingWithOptions:);
    SEL overrideSel = @selector(sx_application:didFinishLaunchingWithOptions:);
    Method originMethod = class_getInstanceMethod([self class], @selector(application:didFinishLaunchingWithOptions:));
    Method overrideMethod = class_getInstanceMethod([self class], @selector(sx_application:didFinishLaunchingWithOptions:));
    
    if (class_addMethod([self class], originSel, class_getMethodImplementation([self class], overrideSel), method_getTypeEncoding(originMethod))) {
        class_replaceMethod([self class], overrideSel, class_getMethodImplementation([self class], originSel), method_getTypeEncoding(overrideMethod));
    }else {
        method_exchangeImplementations(originMethod, overrideMethod);
    }
}


- (BOOL)sx_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"");

    return [self sx_application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSLog(@"");

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
