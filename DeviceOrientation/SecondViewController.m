//
//  SecondViewController.m
//  DeviceOrientation
//
//  Created by 熊智凡 on 2019/5/8.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (nonatomic, assign) BOOL shouldAutoratate;
@property (nonatomic, assign) UIInterfaceOrientationMask mask;

@end

@implementation SecondViewController

- (BOOL)shouldAutorotate {
    return self.shouldAutoratate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.mask;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.mask = UIInterfaceOrientationMaskAll;
        self.shouldAutoratate = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(t1) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(t2) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)t1 {
    self.mask = UIInterfaceOrientationLandscapeLeft;
    self.shouldAutoratate = NO;
}

- (void)t2 {
    self.shouldAutoratate = YES;
    self.mask = UIInterfaceOrientationMaskAll;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
