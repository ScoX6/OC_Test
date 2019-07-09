//
//  ViewController.m
//  LLDB
//
//  Created by 熊智凡 on 2019/2/22.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSInteger _m_integer;
}

@property (nonatomic, strong) UIView *m_view;

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self->_m_integer = 10;
    
    NSInteger i1 = 100;

    self.m_view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.m_view.backgroundColor = UIColor.redColor;

    [self.view addSubview:self.m_view];

    self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
    self.imgView.center = CGPointMake(300, 300);
    
    [self.view addSubview:self.imgView];
    
    NSLog(@"i1 = %ld", i1);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"");
    
    UIImage *img = [UIImage imageNamed:@"image"];
    [self test:arc4random() % 2];
    
    self->_m_integer = arc4random() % 100;
    
//    NSArray *ary = @[@(1), @(2)];
//    [ary objectAtIndex:12];
    
    if ([self testBOOL]) {
        self.view.backgroundColor = UIColor.purpleColor;
    }else {
        self.view.backgroundColor = UIColor.magentaColor;
    }
    
}

- (BOOL)testBOOL {
    self.view.backgroundColor = UIColor.whiteColor;
    return NO;
}

- (void)test:(NSInteger)param {
    NSLog(@"");
}

@end
