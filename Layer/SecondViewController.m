//
//  SecondViewController.m
//  Layer
//
//  Created by Sco.X on 2018/9/9.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (nonatomic, strong) CALayer *containerLayer;
@property (nonatomic, strong) CALayer *layer1;
@property (nonatomic, strong) CALayer *layer2;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.containerLayer = [[CALayer alloc] initWithLayer:self.view.layer];
    self.containerLayer.frame = self.view.bounds;
    self.containerLayer.backgroundColor = UIColor.magentaColor.CGColor;
    [self.view.layer addSublayer:self.containerLayer];
    
    self.layer2 = [[CALayer alloc] initWithLayer:self.containerLayer];
    self.layer2.frame = CGRectMake(100, 150, 200, 200);
    self.layer2.backgroundColor = UIColor.cyanColor.CGColor;
    self.layer2.contents = (__bridge id)[UIImage imageNamed:@"mouse"].CGImage;
    self.layer2.minificationFilter = kCAFilterNearest;
    self.layer2.magnificationFilter = kCAFilterNearest;
//        self.layer2.zPosition = 1.f;
    [self.containerLayer addSublayer:self.layer2];

    self.layer1 = [[CALayer alloc] initWithLayer:self.containerLayer];
    self.layer1.frame = CGRectMake(100, 100, 100, 100);
    self.layer1.backgroundColor = UIColor.orangeColor.CGColor;
    self.layer1.zPosition = -2.f;
    [self.containerLayer addSublayer:self.layer1];
    
    CATransform3D transform = CATransform3DMakeRotation(M_PI_2 / 2, 0, 1.f, 0);
    self.containerLayer.transform = transform;

    //create opaque button
//    UIButton *button1 = [self customButton];
//    button1.center = CGPointMake(150, 150);
//    [self.view addSubview:button1];
//    //create translucent button
//    UIButton *button2 = [self customButton];
//    button2.center = CGPointMake(150, 250);
//    button2.alpha = 0.5;
//    [self.view addSubview:button2];
//
//    button2.layer.shouldRasterize = YES;
//    button2.layer.rasterizationScale = UIScreen.mainScreen.scale;
}

- (UIButton *)customButton {
    
    //create button
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = UIColor.orangeColor;
    [button addSubview:label];
    return button;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [touches.anyObject locationInView:self.view];
//    point = [self.layer2 convertPoint:point fromLayer:self.view.layer];
////    CGPoint point = CGPointMake(10, 10);
//    if ([self.layer1 containsPoint:point]) {
//        NSLog(@"👻👻👻👻👻👻👻👻 layer1 touch");
//    }
//
//    if ([self.layer2 containsPoint:point]) {
//        NSLog(@"👻👻👻👻👻👻👻👻 layer2 touch");
//    }
    
//    CALayer *layer = [self.view.layer hitTest:point];
//    if (layer == self.layer1) {
//        NSLog(@"👻👻👻👻👻👻👻👻 layer1 response");
//    }
//
//    if (layer == self.layer2) {
//        NSLog(@"👻👻👻👻👻👻👻👻 layer2 response");
//    }
    
//    CATransform3D transform = CATransform3DMakeScale(0.5, 0.5, 0.5);
//    transform = CATransform3DRotate(transform, M_PI_2 / 2.f, 0.f, 1.f, 1.f);
//    transform.m34 = -1.f / 500.f;
//    self.layer2.transform = transform;

//    CATransform3D transform = CATransform3DMakeScale(0.5, 0.5, 0.5);
//    transform.m34 = -1.f / 500.f;
//    self.view.layer.sublayerTransform = transform;

    CATransform3D transform = CATransform3DMakeRotation(-M_PI_2 / 2, 0, 1.f, 0);
    self.layer2.transform = transform;
    self.layer2.doubleSided = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
