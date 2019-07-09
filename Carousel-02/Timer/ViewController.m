//
//  ViewController.m
//  Timer
//
//  Created by 熊智凡 on 2018/10/13.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "ViewController.h"
#import "SXWeakTimer.h"

@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer01;

@property (nonatomic, strong) SXWeakTimer *weakTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.orangeColor;
    
//    [self timer01_test_06];
    

}

- (void)timer01_test_01 {
    
    self.timer01 = [NSTimer timerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"Timer01 - Test");
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer01 forMode:NSRunLoopCommonModes];
    [self.timer01 fire];

}

- (void)timer01_test_02 {
    
    self.timer01 = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timer01_test_excute:) userInfo:@"timer01_test_02" repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer01 forMode:NSRunLoopCommonModes];
    [self.timer01 fire];
    
}

- (void)timer01_test_03 {
    
    self.timer01 = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"timer01_test_03");
    }];
    
}

- (void)timer01_test_04 {
    
    self.timer01 = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timer01_test_excute:) userInfo:@"timer01_test_04" repeats:YES];
    
}

- (void)timer01_test_05 {

    self.timer01 = [NSTimer timerWithTimeInterval:0.1 invocation:[self getInvocationWithSelector:@selector(timer01_test_excute:) param:@"timer01_test_05"] repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer01 forMode:NSRunLoopCommonModes];
    [self.timer01 fire];
    
}

- (void)timer01_test_06 {
    self.timer01 = [NSTimer scheduledTimerWithTimeInterval:0.1 invocation:[self getInvocationWithSelector:@selector(timer01_test_excute:) param:@"timer01_test_06"] repeats:YES];
}

- (NSInvocation *)getInvocationWithSelector:(SEL)selector param:(NSString *)param {
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    if (signature == nil) {
        NSString *info = [NSString stringWithFormat:@"%@方法找不到", NSStringFromSelector(selector)];
        [NSException raise:@"方法调用出现异常" format:info, nil];
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    [invocation setArgument:&param atIndex:2];
    return invocation;
}

- (void)timer01_test_excute:(NSString *)param {
    NSLog(@"%@", param);
}

- (void)dealloc {
    NSLog(@"View Controller Destroy");
}

@end
