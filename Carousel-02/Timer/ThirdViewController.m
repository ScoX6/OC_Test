//
//  ThirdViewController.m
//  Timer
//
//  Created by 熊智凡 on 2018/10/16.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "ThirdViewController.h"
#import "SXWeakProxy.h"
#import <YYWeakProxy.h>

@interface ThirdViewController ()

@property (nonatomic, strong) CADisplayLink *displayTimer;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.displayTimer = [CADisplayLink displayLinkWithTarget:[SXWeakProxy proxyWithTarget:self] selector:@selector(displayTimerExcute:)];
    [self.displayTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

}

- (void)displayTimerExcute:(id)sender {
    NSLog(@"%s", __func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [self.displayTimer invalidate];
    NSLog(@"Third View Controller Destroy");
}


@end
