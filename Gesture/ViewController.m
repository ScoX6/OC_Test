//
//  ViewController.m
//  Gesture
//
//  Created by 熊智凡 on 2019/7/5.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *myView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureA;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureA;

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGestureA;

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGestureB;

@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGestureA;

@property (nonatomic, strong) UIRotationGestureRecognizer *rotationGestureA;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureA;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myView = [[UIView alloc] init];
    self.myView.backgroundColor = UIColor.cyanColor;
    self.myView.frame = CGRectMake(50, 200, 300, 300);
    [self.view addSubview:self.myView];
    
//    self.tapGestureA = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHandle:)];
//    self.tapGestureA.delegate = self;
//    [self.myView addGestureRecognizer:self.tapGestureA];
    
    self.panGestureA = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandle:)];
    self.panGestureA.delegate = self;
    [self.myView addGestureRecognizer:self.panGestureA];
    
    self.swipeGestureA = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureHandle:)];
    self.swipeGestureA.delegate = self;
    self.swipeGestureA.numberOfTouchesRequired = 1;
    self.swipeGestureA.direction = UISwipeGestureRecognizerDirectionDown;
    [self.myView addGestureRecognizer:self.swipeGestureA];
    
//    self.swipeGestureB = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureHandle:)];
//    self.swipeGestureB.delegate = self;
//    self.swipeGestureB.numberOfTouchesRequired = 1;
//    self.swipeGestureB.direction = UISwipeGestureRecognizerDirectionUp;
//    [self.myView addGestureRecognizer:self.swipeGestureB];
    
//    self.pinchGestureA = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureHandle:)];
//    self.pinchGestureA.delegate = self;
//    [self.myView addGestureRecognizer:self.pinchGestureA];
    
//    self.rotationGestureA = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureHandle:)];
//    self.rotationGestureA.delegate = self;
//    [self.myView addGestureRecognizer:self.rotationGestureA];
    
    self.longPressGestureA = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureHandle:)];
    self.longPressGestureA.delegate = self;
    [self.myView addGestureRecognizer:self.longPressGestureA];
}

#pragma mark - Gesture Handle
- (void)tapGestureHandle:(UITapGestureRecognizer *)gesture {
    NSLog(@"🧐🧐🧐🧐 - Tap");
}

- (void)panGestureHandle:(UIPanGestureRecognizer *)gesture {
    NSLog(@"🧐🧐🧐🧐 - Pan");
}

- (void)swipeGestureHandle:(UISwipeGestureRecognizer *)gesture {
    if (gesture == self.swipeGestureA) {
        NSLog(@"🧐🧐🧐🧐 - Swipe A");
    }else if (gesture == self.swipeGestureB) {
        NSLog(@"🧐🧐🧐🧐 - Swipe B");
    }
}

- (void)pinchGestureHandle:(UIPinchGestureRecognizer *)gesture {
    NSLog(@"🧐🧐🧐🧐 - Pinch");
}

- (void)rotationGestureHandle:(UIRotationGestureRecognizer *)gesture {
    NSLog(@"🧐🧐🧐🧐 - Rotation");
}

- (void)longPressGestureHandle:(UILongPressGestureRecognizer *)gesture {
    NSLog(@"🧐🧐🧐🧐 - LongPress");
}

#pragma mark - Gesture Delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"🦷🦷🦷🦷 - %@", NSStringFromClass(gestureRecognizer.class));
    return YES;
}

// gestureRecognizer是否能和otherGestureRecognizer同时识别
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSLog(@"🥶🥶🥶🥶 - %@ - %@", NSStringFromClass(gestureRecognizer.class), NSStringFromClass(otherGestureRecognizer.class));
    return YES;
}

// gestureRecognizer是否会被otherGestureRecognizer中断
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSLog(@"😡😡😡😡 - %@ - %@", NSStringFromClass(gestureRecognizer.class), NSStringFromClass(otherGestureRecognizer.class));
    return NO;
}

// gestureRecognizer是否会中断otherGestureRecognizer
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSLog(@"🤬🤬🤬🤬 - %@ - %@", NSStringFromClass(gestureRecognizer.class), NSStringFromClass(otherGestureRecognizer.class));
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    NSLog(@"🤢🤢🤢🤢 - %@", NSStringFromClass(gestureRecognizer.class));
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(nonnull UIPress *)press {
    NSLog(@"👽👽👽👽 - %@", NSStringFromClass(gestureRecognizer.class));
    return NO;
}

@end
