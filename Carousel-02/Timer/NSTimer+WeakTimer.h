//
//  NSTimer+WeakTimer.h
//  Timer
//
//  Created by 熊智凡 on 2018/10/15.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (WeakTimer)

+ (instancetype)sx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                        repeats:(BOOL)repeats
                                          block:(void(^)(NSTimer *timer))block;



@end

NS_ASSUME_NONNULL_END
