//
//  SXWeakTimer.h
//  Timer
//
//  Created by 熊智凡 on 2018/10/15.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXWeakTimer : NSObject

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)interval target:(nonnull id)target selector:(nonnull SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)repeats;

- (void)pause;

- (void)resume;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
