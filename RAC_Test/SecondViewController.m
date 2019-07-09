//
//  SecondViewController.m
//  RAC_Test
//
//  Created by 熊智凡 on 2018/11/15.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "SecondViewController.h"
#import <ReactiveObjC.h>

@interface SecondViewController ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];

    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [self.btn setTitle:@"Show" forState:UIControlStateNormal];
    [self.view addSubview:self.btn];
    
    @weakify(self);
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSLog(@"%@", self.btn);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"");
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
