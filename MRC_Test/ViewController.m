//
//  ViewController.m
//  MRC_Test
//
//  Created by Sco.X on 2018/8/30.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "ViewController.h"

@interface Room: NSObject
@property int no;
@end

@implementation Room
@end

@interface Person: NSObject {
    Room *_room;
}
- (void)setRoom:(Room *)room;
- (Room *)room;
@end
@implementation Person
@end

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    @autoreleasepool {
//        Person *p = [[Person alloc] init];
//        Room *r = [[Room alloc] init];
//        r.no = 888;
//        
//        NSLog(@"%p, %p", p, r);
//        
//        [r release];
//        [p release];
//
//    }
//    
//    NSLog(@"");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
