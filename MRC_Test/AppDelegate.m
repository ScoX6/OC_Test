//
//  AppDelegate.m
//  MRC_Test
//
//  Created by Sco.X on 2018/8/30.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "AppDelegate.h"
#import "TestObject.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
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
//    [self testNoneRepeatTimer];
//    [self testRepeatTimer];
    
    TestObject *tObj = [[TestObject alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:tObj selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [tObj release];
    NSLog(@"Simulate Busy!");
    [self performSelector:@selector(simulateBusy) withObject:nil afterDelay:3];
}

- (void)testNoneRepeatTimer {
 
    TestObject *tObj = [[TestObject alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:5 target:tObj selector:@selector(timerAction:) userInfo:nil repeats:NO];
    
    [tObj release];
    
    NSLog(@"Invoke release to testObject!");
}

- (void)testRepeatTimer {
    
    NSLog(@"Test retain target for repeat timer");
    
    TestObject *tObj = [[TestObject alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:5 target:tObj selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [tObj release];
    
    NSLog(@"Invoke release to tObj");
}

- (void)simulateBusy {
    
    NSLog(@"start simulate busy!");
    
    NSUInteger caculateCount = 0x0FFFFFFF;
    CGFloat uselessValue = 0;
    for (NSUInteger i = 0; i < caculateCount; ++i) {
        uselessValue = i / 0.3333;
    }
    
    NSLog(@"finish simulate busy!");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
