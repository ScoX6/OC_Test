//
//  VVStack.m
//  VVStack
//
//  Created by 熊智凡 on 2019/5/6.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "VVStack.h"

@interface VVStack ()

@property (nonatomic, strong) NSMutableArray *numbers;

@end

@implementation VVStack

- (instancetype)init {
    if (self = [super init]) {
        _numbers = [NSMutableArray new];
    }
    return self;
}

- (void)push:(double)num {
    [self.numbers addObject:@(num)];
}

- (double)top {
    return [[self.numbers lastObject] doubleValue];
}

@end
