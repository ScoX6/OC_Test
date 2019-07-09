//
//  SXWeakTimer.m
//  Timer
//
//  Created by 熊智凡 on 2018/10/15.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "SXWeakTimer.h"

@interface SXWeakTimer ()

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL aSelector;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SXWeakTimer

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeats {
    
    SXWeakTimer *weakTimer = [SXWeakTimer new];
    
    NSParameterAssert(target);
    
    weakTimer.target = target;
    weakTimer.aSelector = aSelector;
    weakTimer.timer = [NSTimer timerWithTimeInterval:interval target:weakTimer selector:@selector(timerExcute:) userInfo:userInfo repeats:repeats];
    [[NSRunLoop currentRunLoop] addTimer:weakTimer.timer forMode:NSRunLoopCommonModes];
    [weakTimer.timer fire];
    
    return weakTimer;
}

- (void)timerExcute:(id)userInfo {
    [self.target performSelectorOnMainThread:self.aSelector withObject:userInfo waitUntilDone:YES];
}

- (void)pause {
    self.timer.fireDate = NSDate.distantFuture;
}

- (void)resume {
    self.timer.fireDate = NSDate.distantPast;
}

- (void)stop {
    [self.timer invalidate];
    self.timer = nil;
}

@end
