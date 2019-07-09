//
//  SecondViewController.m
//  Timer
//
//  Created by 熊智凡 on 2018/10/15.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "SecondViewController.h"
#import "SXWeakTimer.h"
#import "NSTimer+WeakTimer.h"

@interface SecondViewController ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) SXWeakTimer *weakTimer;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self timer3];
    
//    self.weakTimer = [SXWeakTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerExcute) userInfo:nil repeats:YES];
    
    self.timer = [NSTimer sx_scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"category weak timer");
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}

- (void)timer1 {
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"SecondViewController: timer block");
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
    
    self.timer = timer;
}

- (void)timer2 {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"SecondViewController: scheduled timer block");
    }];
    self.timer = timer;
}

- (void)timer3 {
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerExcute) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
    self.timer = timer;
}

- (void)timerExcute {
    NSLog(@"timer Excute");
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
    [self.weakTimer stop];
    NSLog(@"SecondViewController destroy");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
