//
//  NSObject+SXInvokeAllMethod.m
//  OC_Test
//
//  Created by 熊智凡 on 2019/2/26.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "NSObject+SXInvokeAllMethod.h"

@implementation NSObject (SXInvokeAllMethod)

- (void)invokeAllInstanceMethodWithSelector:(SEL)selector {
    [self invokeAllInstanceMethodWithSelector:selector withObject:nil];
}

- (void)invokeAllInstanceMethodWithSelector:(SEL)selector withObject:(nullable id)object {
    [self invokeAllInstanceMethodWithSelector:selector withParams:nil];
}

- (void)invokeAllInstanceMethodWithSelector:(SEL)selector withParams:(nullable id)params, ... {
    
}

+ (void)invokeAllClassMethodWithSelector:(SEL)selector {
    
}

@end
