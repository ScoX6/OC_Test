//
//  ThirdViewController.m
//  Layer
//
//  Created by Sco.X on 2018/9/10.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CATextLayer *textLayer;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self replicatorLayer_pro3];
    
    NSString *pattern = @"^((([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,7}:)|(([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){5}(:[0-9A-Fa-f]{1,4}){1,2})|(([0-9A-Fa-f]{1,4}:){4}(:[0-9A-Fa-f]{1,4}){1,3})|(([0-9A-Fa-f]{1,4}:){3}(:[0-9A-Fa-f]{1,4}){1,4})|(([0-9A-Fa-f]{1,4}:){2}(:[0-9A-Fa-f]{1,4}){1,5})|([0-9A-Fa-f]{1,4}:(:[0-9A-Fa-f]{1,4}){1,6})|(:(:[0-9A-Fa-f]{1,4}){1,7})|(([0-9A-Fa-f]{1,4}:){6}(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3})|(([0-9A-Fa-f]{1,4}:){5}:(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3})|(([0-9A-Fa-f]{1,4}:){4}(:[0-9A-Fa-f]{1,4}){0,1}:(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3})|(([0-9A-Fa-f]{1,4}:){3}(:[0-9A-Fa-f]{1,4}){0,2}:(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3})|(([0-9A-Fa-f]{1,4}:){2}(:[0-9A-Fa-f]{1,4}){0,3}:(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3})|([0-9A-Fa-f]{1,4}:(:[0-9A-Fa-f]{1,4}){0,4}:(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3})|(:(:[0-9A-Fa-f]{1,4}){0,5}:(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])(\\.(\\d|[1-9]\\d|1\\d{2}|2[0-4]\\d|25[0-5])){3}))$";
    
    NSRegularExpression *expiression = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSString *matching = @"fe80:0000:0000:0000:0204:61ff:254.157.241.86";
    NSTextCheckingResult *result = [expiression firstMatchInString:matching options:0 range:NSMakeRange(0, matching.length)];
    if (result.range.location != NSNotFound && result.range.length > 0) {
        NSLog(@"");
    }

}

- (void)replicatorLayer_pro3 {
    
    UIView *animationView = [[UIView alloc] init];
    animationView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 300);
    animationView.center = self.view.center;
    animationView.backgroundColor = UIColor.cyanColor;
    animationView.clipsToBounds = YES;
    [self.view addSubview:animationView];
    
    CAShapeLayer *animationLayer = [[CAShapeLayer alloc] init];
    animationLayer.bounds = CGRectMake(0, 0, 20, 20);
    animationLayer.position = CGPointMake(animationView.bounds.size.width / 2.f, 50);
    animationLayer.backgroundColor = UIColor.orangeColor.CGColor;
    animationLayer.borderColor = UIColor.whiteColor.CGColor;
    animationLayer.cornerRadius = 2.f;
    animationLayer.masksToBounds = YES;
    animationLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 2.f;
    animation.repeatCount = HUGE;
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)];
    
    [animationLayer addAnimation:animation forKey:nil];
    
    CAReplicatorLayer *replicatorLayer = [[CAReplicatorLayer alloc] init];
    replicatorLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 300);
    [replicatorLayer addSublayer:animationLayer];
    replicatorLayer.instanceCount = 20;
    replicatorLayer.instanceDelay = 0.1;
    CGFloat angle = (2*M_PI) / 20.f;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    
    [animationView.layer addSublayer:replicatorLayer];
}

- (void)replicatorLayer_pro2 {
    
    UIView *animationView = [[UIView alloc] init];
    animationView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 300);
    animationView.center = self.view.center;
    animationView.backgroundColor = UIColor.cyanColor;
    animationView.clipsToBounds = YES;
    [self.view addSubview:animationView];
    
    CAShapeLayer *animationLayer = [[CAShapeLayer alloc] init];
    animationLayer.backgroundColor = UIColor.orangeColor.CGColor;
    animationLayer.bounds = CGRectMake(0, 0, 20, 20);
    animationLayer.anchorPoint = CGPointMake(0.5, 0.5);
    animationLayer.position = CGPointMake(0, animationView.center.y);
    animationLayer.cornerRadius = 10;

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, CGRectMake((animationView.bounds.size.width-160)/2, (animationView.bounds.size.height-160)/2, 160, 160));
    
    CAKeyframeAnimation *transformAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    transformAnim.duration = 4;
    transformAnim.repeatCount = HUGE;
    transformAnim.path = path;
    
    [animationLayer addAnimation:transformAnim forKey:nil];
    
    CAReplicatorLayer *replicatorLayer = [[CAReplicatorLayer alloc] init];
    [replicatorLayer addSublayer:animationLayer];
    replicatorLayer.instanceCount = 20;
    replicatorLayer.instanceDelay = 0.2;
    replicatorLayer.instanceAlphaOffset = -0.05;
    [animationView.layer addSublayer:replicatorLayer];
}

- (void)replicatorLayer_pro1 {
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
    containerView.center = self.view.center;
    containerView.backgroundColor = UIColor.magentaColor;
    containerView.clipsToBounds = YES;
    [self.view addSubview:containerView];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.backgroundColor = UIColor.redColor.CGColor;
    shapeLayer.bounds = CGRectMake(0, 0, 20, 20);
    shapeLayer.cornerRadius = 10.f;
    shapeLayer.position = CGPointMake(self.view.bounds.size.width / 2, 100);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(10, 10, 1)];
    animation.duration = 2.f;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.toValue = @(0.f);
    animation2.duration = 2.f;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[animation, animation2];
    group.duration = 2.f;
    group.repeatCount = HUGE;
    [shapeLayer addAnimation:group forKey:nil];
    
    CAReplicatorLayer *replicatorLayer = [[CAReplicatorLayer alloc] init];
    [replicatorLayer addSublayer:shapeLayer];
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceDelay = 0.6f;
    [containerView.layer addSublayer:replicatorLayer];
    
}

- (void)testReplicatorLayer {
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(30, 100, 300, 300);
    [self.view.layer addSublayer:replicatorLayer];
    
    replicatorLayer.instanceCount = 10;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 50, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.f, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -50, 0);
    replicatorLayer.instanceTransform = transform;
    
    replicatorLayer.instanceBlueOffset = -0.1;
    replicatorLayer.instanceGreenOffset = -0.1;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(50.f, 50.f, 50.f, 50.f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:layer];
    
}

- (CALayer *)faceWithTransform:(CATransform3D)transform {
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.f].CGColor;
    face.transform = transform;
    return face;
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform {
    CATransformLayer *cube = [CATransformLayer layer];
    
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    CGSize containerSize = self.view.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2.f, containerSize.height / 2.f);
    cube.transform = transform;
    
    return cube;
}

- (void)testTransformLayer {
    
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1 / 500.f;
    self.view.layer.sublayerTransform = pt;
    
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    CALayer *cube1 = [self cubeWithTransform:c1t];
    [self.view.layer addSublayer:cube1];
    
    
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t];
    [self.view.layer addSublayer:cube2];
    
}

- (void)testTextLayer {
    
    self.textLayer = [[CATextLayer alloc] init];
    self.textLayer.frame = CGRectMake(100, 100, 200, 400);
    self.textLayer.contentsScale = UIScreen.mainScreen.scale;
    [self.view.layer addSublayer:self.textLayer];
    
    self.textLayer.foregroundColor = UIColor.blackColor.CGColor;
    self.textLayer.alignmentMode = kCAAlignmentJustified;
    self.textLayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:17];
    
    CFStringRef cfStr = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(cfStr);
    self.textLayer.font = fontRef;
    self.textLayer.fontSize = font.pointSize;
    
    NSString *text = @"他和她相爱，再不会犹豫的时代，因为，你明白，一双手紧紧放不开，心中的执着与未来，嗯嗯，忘不了，你的爱，我期待的，未来，幼稚的男孩，哦哦哦哦哦，想你，就现在，想你，每当我又徘徊";
    self.textLayer.string = text;
    
    CGFontRelease(fontRef);
    
}

- (void)testShapeLayer {
    
    self.shapeLayer = [[CAShapeLayer alloc] initWithLayer:self.view.layer];
    [self.view.layer addSublayer:self.shapeLayer];
    
    //    UIBezierPath *path = [[UIBezierPath alloc] init];
    //    [path moveToPoint:CGPointMake(175, 100)];
    //
    //    [path moveToPoint:CGPointMake(150, 75)];
    //    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    //    [path moveToPoint:CGPointMake(150, 125)];
    ////    [path addLineToPoint:CGPointMake(150, 125)];
    //    [path addLineToPoint:CGPointMake(150, 175)];
    //    [path addLineToPoint:CGPointMake(125, 225)];
    //    [path moveToPoint:CGPointMake(150, 175)];
    //    [path addLineToPoint:CGPointMake(175, 225)];
    //    [path moveToPoint:CGPointMake(100, 150)];
    //    [path addLineToPoint:CGPointMake(200, 150)];
    
    UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 200, 200) byRoundingCorners:corner cornerRadii:CGSizeMake(10, 5)];
    
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.lineWidth = 5;
    self.shapeLayer.lineJoin = kCALineJoinRound;
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.path = path.CGPath;
    
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
