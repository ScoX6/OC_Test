//
//  Season.h
//  类簇
//
//  Created by 熊智凡 on 2019/5/6.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SeasonType) {
    Season_Spring,
    Season_Summer,
    Season_Autumn,
    Season_Winter,
};

NS_ASSUME_NONNULL_BEGIN

@interface Season : NSObject

+ (instancetype)SeasonWithType:(SeasonType)type;

- (void)say;

@end

NS_ASSUME_NONNULL_END
