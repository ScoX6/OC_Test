
//
//  Semaphore_Test.m
//  gcd_test
//
//  Created by 熊智凡 on 2018/12/23.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "Semaphore_Test.h"

@implementation Semaphore_Test

- (void)main {
//    [self testOne];
    [self testTow];
}

- (void)testOne {
    
    dispatch_semaphore_t semaphore_t = dispatch_semaphore_create(2);
    dispatch_queue_t queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue_t, ^{
        dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(2.f);
        NSLog(@"task 1 complete");
        dispatch_semaphore_signal(semaphore_t);
    });
    
    dispatch_async(queue_t, ^{
        dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(2.f);
        NSLog(@"task 2 complete");
        dispatch_semaphore_signal(semaphore_t);
    });
    
    dispatch_async(queue_t, ^{
        dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(2.f);
        NSLog(@"task 3 complete");
        dispatch_semaphore_signal(semaphore_t);
    });
    
    dispatch_async(queue_t, ^{
        dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 4");
        sleep(2.f);
        NSLog(@"task 4 complete");
        dispatch_semaphore_signal(semaphore_t);
    });
    
    dispatch_async(queue_t, ^{
        dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 5");
        sleep(2.f);
        NSLog(@"task 5 complete");
        dispatch_semaphore_signal(semaphore_t);
    });
    
    dispatch_async(queue_t, ^{
        dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 6");
        sleep(2.f);
        NSLog(@"task 6 complete");
        dispatch_semaphore_signal(semaphore_t);
    });
    
}

- (void)testTow {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_t semaphore_t = dispatch_semaphore_create(0);
        dispatch_queue_t queue_t = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
        NSLock *lock = [[NSLock alloc] init];
        
        NSUInteger totalCount = 5;
        __block NSUInteger count = 0;
        
        dispatch_async(queue_t, ^{
            NSLog(@"run task 1");
            sleep(2.f);
            NSLog(@"task 1 complete");
            [lock lock];
            ++count;
            [lock unlock];
            NSLog(@"current count = %lu", count);
            if (count == totalCount) {
                dispatch_semaphore_signal(semaphore_t);
            }
        });
        
        dispatch_async(queue_t, ^{
            NSLog(@"run task 2");
            sleep(2.f);
            NSLog(@"task 2 complete");
            [lock lock];
            ++count;
            [lock unlock];
            NSLog(@"current count = %lu", count);
            if (count == totalCount) {
                dispatch_semaphore_signal(semaphore_t);
            }
        });
        
        dispatch_async(queue_t, ^{
            NSLog(@"run task 3");
            sleep(2.f);
            NSLog(@"task 3 complete");
            [lock lock];
            ++count;
            [lock unlock];
            NSLog(@"current count = %lu", count);
            if (count == totalCount) {
                dispatch_semaphore_signal(semaphore_t);
            }
        });
        
        dispatch_async(queue_t, ^{
            NSLog(@"run task 4");
            sleep(2.f);
            NSLog(@"task 4 complete");
            [lock lock];
            ++count;
            [lock unlock];
            NSLog(@"current count = %lu", count);
            if (count == totalCount) {
                dispatch_semaphore_signal(semaphore_t);
            }
        });
        
        dispatch_async(queue_t, ^{
            NSLog(@"run task 5");
            sleep(2.f);
            NSLog(@"task 5 complete");
            [lock lock];
            ++count;
            [lock unlock];
            NSLog(@"current count = %lu", count);
            if (count == totalCount) {
                dispatch_semaphore_signal(semaphore_t);
            }
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);
            NSLog(@"回到主线程");
        });
    });
}

@end
