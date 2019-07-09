//
//  ViewController.m
//  runloop_test
//
//  Created by 熊智凡 on 2018/11/14.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopAddCommonMode(runloop, kCFRunLoopDefaultMode);
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 2.f, YES);
    
//    CFRunLoopAddSource(runloop, <#CFRunLoopSourceRef source#>, <#CFRunLoopMode mode#>)
    
}


@end
