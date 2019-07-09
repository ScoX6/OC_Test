//
//  ViewController.m
//  gcd_test
//
//  Created by 熊智凡 on 2018/12/23.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "ViewController.h"
#import "Group_Test.h"
#import "Barrier_Test.h"
#import "Semaphore_Test.h"
#import "Notify_Cancel_Test.h"
#import "Source_Test.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (nonatomic, strong) Group_Test *group;

@property (nonatomic, strong) Barrier_Test *barrier;

@property (nonatomic, strong) Semaphore_Test *semaphore;

@property (nonatomic, strong) Notify_Cancel_Test *notifyCancel;

@property (nonatomic, strong) Source_Test *source;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];

//    self.group = [[Group_Test alloc] init];
//    [self.group main];
    
//    self.barrier = [[Barrier_Test alloc] init];
//    [self.barrier main];

//    self.semaphore = [[Semaphore_Test alloc] init];
//    [self.semaphore main];
    
//    self.notifyCancel = [[Notify_Cancel_Test alloc] init];
//    [self.notifyCancel main];

    self.source = [[Source_Test alloc] init];
    [self.source main];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.source cancel];
    SecondViewController *secondVC = [[SecondViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:secondVC animated:YES completion:nil];
}


@end
