//
//  Group_Test.m
//  gcd_test
//
//  Created by 熊智凡 on 2018/12/23.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "Group_Test.h"

@implementation Group_Test

- (void)main {
//    [self testOne];
//    [self testTow];
    [self testThree];
}

- (void)testOne {
    
    dispatch_queue_t global_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t serial_queue_t = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_group_t group_t = dispatch_group_create();
    
    dispatch_group_async(group_t, global_queue_t, ^{
        NSLog(@"run task 1");
    });
    
    dispatch_group_async(group_t, serial_queue_t, ^{
        NSLog(@"run task 2");
    });
    
    dispatch_group_async(group_t, serial_queue_t, ^{
        NSLog(@"run task 3");
    });
    
    dispatch_group_async(group_t, dispatch_get_main_queue(), ^{
        NSLog(@"run task 4");
    });
}

- (void)testTow {
    
    dispatch_group_t group_t = dispatch_group_create();
    dispatch_queue_t global_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group_t);
    dispatch_async(global_queue_t, ^{
        sleep(2.f);
        NSLog(@"Task 1");
        dispatch_group_leave(group_t);
    });
    
    dispatch_group_enter(group_t);
    dispatch_async(global_queue_t, ^{
        sleep(1.f);
        NSLog(@"Task 2");
        dispatch_group_leave(group_t);
    });
    
    dispatch_group_enter(group_t);
    dispatch_async(global_queue_t, ^{
        NSLog(@"Task 3");
        dispatch_group_leave(group_t);
    });
    
    dispatch_group_wait(group_t, DISPATCH_TIME_FOREVER);
    
    dispatch_group_notify(group_t, global_queue_t, ^{
        NSLog(@"Task 4");
    });
    
}

- (void)testThree {
    
    dispatch_queue_t serial_queue_t = dispatch_queue_create("serial queue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrent_queue_t = dispatch_queue_create("concurrent queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t main_queue_t = dispatch_get_main_queue();
    
    dispatch_group_t group_t = dispatch_group_create();
    
    dispatch_group_async(group_t, concurrent_queue_t, ^{
        NSLog(@"task1");
    });
    
    dispatch_group_async(group_t, concurrent_queue_t, ^{
        NSLog(@"task2");
    });
    
    dispatch_group_async(group_t, concurrent_queue_t, ^{
        NSLog(@"task3");
    });
    
    dispatch_group_async(group_t, main_queue_t, ^{
        NSLog(@"回到主线程");
    });
    
    dispatch_group_async(group_t, serial_queue_t, ^{
        NSLog(@"task 4");
    });
    
    dispatch_group_async(group_t, serial_queue_t, ^{
        NSLog(@"task5");
    });
    
    dispatch_group_async(group_t, serial_queue_t, ^{
        NSLog(@"task6");
    });
    
    dispatch_group_async(group_t, concurrent_queue_t, ^{
        NSLog(@"task 7");
    });
    
    dispatch_group_async(group_t, concurrent_queue_t, ^{
        NSLog(@"task 8");
    });
    
    dispatch_group_async(group_t, concurrent_queue_t, ^{
        NSLog(@"task 9");
    });
    
}

@end
