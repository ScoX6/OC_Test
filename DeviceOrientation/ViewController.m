//
//  ViewController.m
//  DeviceOrientation
//
//  Created by 熊智凡 on 2019/5/8.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface TargetView : UIView

@end

@implementation TargetView

- (void)removeFromSuperview {
    [super removeFromSuperview];
}

@end

@interface ViewController ()

@property (nonatomic, strong) UIView *aView;
@property (nonatomic, strong) UIView *bView;
@property (nonatomic, strong) UIView *cView;
@property (nonatomic, strong) TargetView *targetView;

@end

@implementation ViewController

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.aView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 60)];
    self.aView.backgroundColor = UIColor.greenColor;
    [self.view addSubview:self.aView];
    
    self.bView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, self.view.bounds.size.width, 60)];
    self.bView.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:self.bView];
    
    self.cView = [[UIView alloc] initWithFrame:CGRectMake(0, 220, self.view.bounds.size.width, 60)];
    self.cView.backgroundColor = UIColor.purpleColor;
    [self.view addSubview:self.cView];
    
    self.targetView = [[TargetView alloc] initWithFrame:CGRectMake(100, 400, 50, 50)];
    self.targetView.backgroundColor = UIColor.brownColor;
    [self.view addSubview:self.targetView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    SecondViewController *secondVC = [[SecondViewController alloc] init];
////    [self.navigationController pushViewController:secondVC animated:YES];
//    [self presentViewController:secondVC animated:YES completion:nil];
    uint32_t random = arc4random() % 3;
    if (random % 4 == 0) {
        [self.aView addSubview:self.targetView];
        self.targetView.frame = CGRectMake(0, 0, 40, 40);
    }else if (random % 4 == 1) {
        [self.bView addSubview:self.targetView];
        self.targetView.frame = CGRectMake(0, 0, 40, 40);
    }else if (random % 4 == 2) {
        [self.cView addSubview:self.targetView];
        self.targetView.frame = CGRectMake(0, 0, 40, 40);
    }
}

@end
