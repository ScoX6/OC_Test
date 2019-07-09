//
//  ViewController.m
//  Animation
//
//  Created by Sco.X on 2018/9/4.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "ViewController.h"
#import "SXNetworkHelper.h"

@interface ViewController () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *animationView;

@property (nonatomic, assign) NSNumber *animationFinished;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.animationView = [[UIView alloc] init];
    self.animationView.frame = CGRectMake(100, 100, 100, 100);
    self.animationView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.animationView];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.duration = 2.f;
    animation.beginTime = CACurrentMediaTime() + 1.f;
    animation.fromValue = @(0.f);
    animation.toValue = @(M_PI);
    animation.repeatCount = HUGE_VALF;
    animation.delegate = self;
    [self.animationView.layer addAnimation:animation forKey:@"animation"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumeAnimation) name:UIApplicationWillEnterForegroundNotification object:nil];
    
//    [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        float wwanR = [SXNetworkHelper sharedInstance].wwanR_PerSencond;
//        float wifiR = [SXNetworkHelper sharedInstance].wifiR_PerSencond;
//        NSLog(@"数据：%.2f\t\tWiFi：%.02f", wwanR, wifiR);
//    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.animationFinished && !self.animationFinished.boolValue) {
        [self resumeAnimation];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self pauseAnimation];
}

- (void)resumeAnimation {
    CFTimeInterval pauseTime = self.animationView.layer.timeOffset;
    self.animationView.layer.speed = 1.f;
    self.animationView.layer.timeOffset = 0.f;
    self.animationView.layer.beginTime = 0.f;
    self.animationView.layer.beginTime = [self.animationView.layer convertTime:CACurrentMediaTime() toLayer:nil] - pauseTime;
}

- (void)pauseAnimation {
    CFTimeInterval pausedTime = [self.animationView.layer convertTime:CACurrentMediaTime() toLayer:nil];
    self.animationView.layer.speed = 0.f;
    self.animationView.layer.timeOffset = pausedTime;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.animationView.hidden = !self.animationView.hidden;
//    if (self.animationView.superview) {
//        [self.animationView removeFromSuperview];
//    }else {
//        [self.view addSubview:self.animationView];
//    }
    if (self.animationView.alpha <= 0.01) {
//        self.animationView.alpha = 1.f;
    }else {
//        self.animationView.alpha = 0.01;
    }
    
}

- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.animationFinished = @(flag);
    [self pauseAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
