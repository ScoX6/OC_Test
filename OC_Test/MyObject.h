//
//  MyObject.h
//  OC_Test
//
//  Created by Sco.X on 2018/8/26.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyObject : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger version;

+ (void)todoSomething;

@end
