//
//  NSObject+SX_KVO.h
//  OC_Test
//
//  Created by Sco.X on 2018/8/26.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SXObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (SX_KVO)

- (void)SX_addObserver:(NSObject *)observer forKey:(NSString *)key withBlock:(SXObservingBlock)block;

- (void)SX_removeObserver:(NSObject *)observer forKey:(NSString *)key;

@end
