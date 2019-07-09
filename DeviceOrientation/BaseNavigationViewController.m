//
//  BaseNavigationViewController.m
//  DeviceOrientation
//
//  Created by 熊智凡 on 2019/5/8.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "BaseNavigationViewController.h"

@implementation BaseNavigationViewController

- (BOOL)shouldAutorotate {
    return self.topViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

@end
