//
//  SXWeakProxy.h
//  Timer
//
//  Created by 熊智凡 on 2018/10/16.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXWeakProxy : NSProxy

@property (nonatomic, weak, readonly, nullable) id target;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
