//
//  ViewController.m
//  Layer
//
//  Created by Sco.X on 2018/9/5.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "ViewController.h"

@interface SXView: UIView
@end
@implementation SXView
- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    return nil;
}
@end

@interface SXLayer: CALayer
@end
@implementation SXLayer
- (id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@"backgroundColor"]) {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        anim.fromValue = (__bridge id)self.backgroundColor;
        anim.toValue = ((CABasicAnimation *)[super actionForKey:event]).toValue;
        anim.duration = 3.f;
        return anim;
    }
    return [super actionForKey:event];
}

- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key {
    [super addAnimation:anim forKey:key];
    NSLog(@"");
}
@end

@interface ViewController () <CALayerDelegate>

@property (nonatomic, strong) SXLayer *layer;
@property (nonatomic, strong) SXLayer *subLayer;

@property (nonatomic, strong) SXView *sxV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.layer = [[SXLayer alloc] initWithLayer:self.view.layer];
    self.layer.frame = CGRectMake(100, 100, 200, 200);
    self.layer.backgroundColor = UIColor.orangeColor.CGColor;
    [self.view.layer addSublayer:self.layer];
    
    self.subLayer = [[SXLayer alloc] initWithLayer:self.layer];
    self.subLayer.frame = CGRectMake(50, 50, 150, 150);
    self.subLayer.backgroundColor = UIColor.cyanColor.CGColor;
    self.subLayer.contents = (__bridge id)[UIImage imageNamed:@"mouse"].CGImage;
    self.subLayer.contentsRect = CGRectMake(0.5f, 0.5f, 0.5f, 0.5f);
    self.subLayer.contentsCenter = CGRectMake(0.25, 0.25, 0.5, 0.5);
    [self.layer addSublayer:self.subLayer];
    
//
//    self.sxV = [[SXView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    self.sxV.backgroundColor = [self randomColor];
//    [self.view addSubview:self.sxV];
    
    NSLog(@"");
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:4.f];
//    CAMediaTimingFunction *timingFuction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [CATransaction setAnimationTimingFunction:timingFuction];
////    [CATransaction setDisableActions:YES];
//    self.sxV.backgroundColor = [self randomColor];
//    self.sxV.center = [self randomPosition];
//    [CATransaction commit];
//
//    self.layer.backgroundColor = [self randomColor].CGColor;
//    self.layer.position = [self randomPosition];
    
//    self.layer.transform = CATransform3DRotate(CATransform3DIdentity, M_PI_2 / 2, 0.f, 0.f, 1.f);
    
//    self.layer.bounds = CGRectMake(self.layer.bounds.origin.x - 10, self.layer.bounds.origin.y - 10, self.layer.bounds.size.width, self.layer.bounds.size.height);
    
//    self.layer.anchorPoint = CGPointZero;
}

- (UIColor *)randomColor {
    CGFloat random_r = arc4random_uniform(256) / 255.f;
    CGFloat random_g = arc4random_uniform(256) / 255.f;
    CGFloat random_b = arc4random_uniform(256) / 255.f;
    return [UIColor colorWithRed:random_r green:random_g blue:random_b alpha:1.0];
}

- (CGPoint)randomPosition {
    UIScreen *screen = UIScreen.mainScreen;
    CGFloat width = screen.bounds.size.width;
    CGFloat height = screen.bounds.size.height;
    NSInteger x = arc4random_uniform((uint32_t)width + 1);
    NSInteger y = arc4random_uniform((uint32_t)height + 1);
    return CGPointMake(x, y);
}

//- (void)displayLayer:(CALayer *)layer {
//    NSLog(@"");
//}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"");
    //1.绘制图形
    //画一个圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, 20, 20));
    //设置属性（颜色）
    //    [[UIColor yellowColor]set];
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    CGContextSetFillColorWithColor(ctx, UIColor.redColor.CGColor);
    //2.渲染
    CGContextFillPath(ctx);
}

- (void)layerWillDraw:(CALayer *)layer {
    NSLog(@"");
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    NSLog(@"");
}

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
