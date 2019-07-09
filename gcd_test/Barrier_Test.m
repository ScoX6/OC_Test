//
//  Barrier_Test.m
//  gcd_test
//
//  Created by 熊智凡 on 2018/12/23.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "Barrier_Test.h"

@implementation Barrier_Test

- (void)main {
    [self testTow];
}

- (void)testOne {
    
    dispatch_queue_t queue_t = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue_t, ^{
        NSLog(@"Task 1");
    });
    
    dispatch_async(queue_t, ^{
        NSLog(@"Task 2");
    });
    
    dispatch_async(queue_t, ^{
        NSLog(@"Task 3");
    });
    
    dispatch_barrier_async(queue_t, ^{
        NSLog(@"barrier");
        sleep(2);
    });
    
    dispatch_async(queue_t, ^{
        NSLog(@"Task 4");
    });
    
    dispatch_async(queue_t, ^{
        NSLog(@"Task 5");
    });
    
    dispatch_async(queue_t, ^{
        NSLog(@"Task 6");
    });
    
    NSLog(@"------------------------------");
}

- (void)testTow {
    dispatch_queue_t queue_t = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue_t, ^{
        NSLog(@"Task 1");
    });
    
    dispatch_async(queue_t, ^{
        NSLog(@"Task 2");
    });
    
    dispatch_async(queue_t, ^{
        NSLog(@"Task 3");
    });
    
    dispatch_barrier_sync(queue_t, ^{
        NSLog(@"barrier");
        sleep(2);
    });
    
    NSLog(@"----------------- 华丽的分割线 -----------------");
    
    dispatch_async(queue_t, ^{
        NSLog(@"Task 4");
    });
    
    dispatch_async(queue_t, ^{
        NSLog(@"Task 5");
    });
    
    dispatch_async(queue_t, ^{
        NSLog(@"Task 6");
    });
    
}

@end
