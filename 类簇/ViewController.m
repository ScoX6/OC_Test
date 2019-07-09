//
//  ViewController.m
//  类簇
//
//  Created by 熊智凡 on 2019/5/6.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "ViewController.h"
#import "Season.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Season *s1 = [Season SeasonWithType:Season_Spring];
    Season *s2 = [Season SeasonWithType:Season_Summer];
    Season *s3 = [Season SeasonWithType:Season_Autumn];
    Season *s4 = [Season SeasonWithType:Season_Winter];
    
    [s1 say];
    [s2 say];
    [s3 say];
    [s4 say];

}


@end
