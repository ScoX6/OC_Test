//
//  NSObject+SXInvokeAllMethod.h
//  OC_Test
//
//  Created by 熊智凡 on 2019/2/26.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SXInvokeBlock)(id params, ...);

@interface NSObject (SXInvokeAllMethod)


/**
通过selector调用所有实例的方法，包括被category覆盖的方法
 
@param selector 要调用方法的selector
 */
- (void)invokeAllInstanceMethodWithSelector:(SEL)selector;


/**
通过selector调用所有实例的方法，包括被category覆盖的方法

@param selector 要调用方法的selector
@param object 入参对象
 */
- (void)invokeAllInstanceMethodWithSelector:(SEL)selector withObject:(nullable id)object;


/**
通过selector调用所有实例的方法，包括被category覆盖的方法

@param selector 要调用方法的selector
@param params 入参对象
 */
- (void)invokeAllInstanceMethodWithSelector:(SEL)selector withParams:(nullable id)params, ... NS_REQUIRES_NIL_TERMINATION;


/**
 通过selector调用所有类的方法，包括被category覆盖的方法

 @param selector 方法的selector
 */
+ (void)invokeAllClassMethodWithSelector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
