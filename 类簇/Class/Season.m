//
//  Season.m
//  类簇
//
//  Created by 熊智凡 on 2019/5/6.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "Season.h"
#import "Spring.h"
#import "Summer.h"
#import "Autumn.h"
#import "Winter.h"

@implementation Season

+ (instancetype)SeasonWithType:(SeasonType)type {
    Season *season;
    switch (type) {
        case Season_Spring: {
            season = [Spring new];
        }break;
        case Season_Summer: {
            season = [Summer new];
        }break;
        case Season_Autumn: {
            season = [Autumn new];
        }break;
        case Season_Winter: {
            season = [Winter new];
        }break;
        default: {}break;
    }
    return season;
}

@end
