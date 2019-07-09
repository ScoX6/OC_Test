//
//  MyObject.m
//  OC_Test
//
//  Created by Sco.X on 2018/8/26.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "MyObject.h"

@implementation MyObject

- (void)todoSomething {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
