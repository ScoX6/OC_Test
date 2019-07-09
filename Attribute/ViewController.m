//
//  ViewController.m
//  Attribute
//
//  Created by 熊智凡 on 2019/4/15.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (id)testReturn __attribute__((unused));

- (id)testReturn2 __attribute__((warn_unused_result()));

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testReturn];
    
    [self testReturn2];
}

- (NSString *)testReturn {
    NSLog(@"");
    return @"Ha Ha";
}

- (id)testReturn2 {
    return @"Hi Hi";
}

@end
