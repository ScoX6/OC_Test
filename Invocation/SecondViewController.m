//
//  SecondViewController.m
//  Invocation
//
//  Created by 熊智凡 on 2018/10/16.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "SecondViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <CTBlockDescription.h>

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    void(^excuteBlock)(NSString *) = ^(NSString *a){
        NSLog(@"excute block: %@", a);
    };
    CTBlockDescription *blockDesc = [[CTBlockDescription alloc] initWithBlock:excuteBlock];
    NSMethodSignature *signature = blockDesc.blockSignature;
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = [excuteBlock copy];
    id a = @"Jack";
    [invocation setArgument:&a atIndex:1];
    [invocation invoke];
    
}

- (void)doSomething:(void(^)(void))sender {
    sender();
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
