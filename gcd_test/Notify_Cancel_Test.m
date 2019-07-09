//
//  Notify_Cancel_Test.m
//  gcd_test
//
//  Created by 熊智凡 on 2018/12/23.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "Notify_Cancel_Test.h"

@implementation Notify_Cancel_Test

- (void)main {
//    [self testOne];
//    [self testTow];
//    [self testThree];
    [self testFour];
}

- (void)testOne {
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSLog(@"normal do some thing...");
    });
    dispatch_async(concurrentQueue, block);
    dispatch_block_t qosBlock = dispatch_block_create_with_qos_class(0, QOS_CLASS_DEFAULT, 0, ^{
        NSLog(@"qos do some thing...");
    });
    dispatch_async(concurrentQueue, qosBlock);
    
}

- (void)testTow {
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
       dispatch_queue_t allTaskQueue = dispatch_queue_create("allTasksQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_block_t block = dispatch_block_create(0, ^{
            NSLog(@"开始执行");
            [NSThread sleepForTimeInterval:3]; NSLog(@"结束执行");
        });
        dispatch_async(allTaskQueue, block);
        
        dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC);
        long result = dispatch_block_wait(block, timeout);
        if (result == 0) {
            NSLog(@"执行成功");
        }else {
            NSLog(@"执行超时");
        }
    });
    
}

- (void)testThree {
    
    NSLog(@"---------- 开始设置任务 -------------");
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_block_t taskBlock = dispatch_block_create(0, ^{
        NSLog(@"开始耗时任务");
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"完成耗时任务");
    });
    dispatch_async(serialQueue, taskBlock);
    // 更新 UI
    dispatch_block_t refreshUI = dispatch_block_create(0, ^{
        NSLog(@"更新 UI");
    });
    // 设置监听
    dispatch_block_notify(taskBlock, dispatch_get_main_queue(), refreshUI);
    NSLog(@"---- 完成设置任务 ----");
}

- (void)testFour {
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.fyf.serialqueue", DISPATCH_QUEUE_SERIAL);
    // 耗时任务
    dispatch_block_t firstTaskBlock = dispatch_block_create(0, ^{
        NSLog(@"开始第一个任务");
        [NSThread sleepForTimeInterval:1.5f];
        NSLog(@"结束第一个任务");
    });
    
    // 耗时任务
    dispatch_block_t secTaskBlock = dispatch_block_create(0, ^{
        NSLog(@"开始第二个任务");
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"结束第二个任务");
    });
    
    dispatch_async(serialQueue, firstTaskBlock);
    dispatch_async(serialQueue, secTaskBlock);
    
    // 等待 1s，让第一个任务开始运行
    [NSThread sleepForTimeInterval:1];
    dispatch_block_cancel(firstTaskBlock);
    NSLog(@"尝试过取消第一个任务");
    dispatch_block_cancel(secTaskBlock);
    NSLog(@"尝试过取消第二个任务");

}

@end
