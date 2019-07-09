//
//  TestObject.m
//  MRC_Test
//
//  Created by 熊智凡 on 2019/3/5.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"instance %@ has been created!", self);
    }
    return self;
}

- (void)dealloc {
    NSLog(@"instance %@ has been dealloced!", self);
    [super dealloc];
}

- (void)timerAction:(NSTimer *)timer {
    NSLog(@"Hi, Timer action for instance %@", self);
}

@end
