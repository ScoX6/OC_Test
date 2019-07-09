//
//  ViewController.m
//  RAC_Test
//
//  Created by Sco.X on 2018/9/19.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UITextField *tf;

@property (nonatomic, strong) UITextField *tf2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  testFour];
    
}

- (void)testOne {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"今晚打老虎"];
        [subscriber sendCompleted];
        RACDisposable *disposable = [RACDisposable disposableWithBlock:^{
            
        }];
        NSLog(@"%p", disposable);
        return disposable;
    }];
    
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    NSLog(@"%p", disposable);
}

- (void)testTwo {
    
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 35)];
    _tf.placeholder = @"RAC测试";
    [self.view addSubview:_tf];
    
    [[[_tf.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length);
    }] filter:^BOOL(NSNumber *value) {
        return value.integerValue > 5;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"文本框输入了大于5个字文本");
    }];
 
    RACSignal *signal = [_tf.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return value.length > 10 ? UIColor.redColor : UIColor.blueColor;
    }];
    RAC(self.tf, backgroundColor) = signal;
    
}

- (void)testThree {
    
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    _tf.placeholder = @"tf1";
    [self.view addSubview:_tf];
    
    _tf2 = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 100, 30)];
    _tf2.placeholder = @"tf2";
    [self.view addSubview:_tf2];
    
    [[[RACSignal combineLatest:@[_tf.rac_textSignal, _tf2.rac_textSignal] reduce:^id(NSString *t1, NSString *t2) {
        return @(t1.length > 5 && t2.length  > 5);
    }] filter:^BOOL(NSNumber *value) {
        return value.boolValue;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"两文本框长度都满足");
    }];

}

- (void)testFour {
    
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    _tf.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:_tf];

    
    [[[_tf.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 10;
    }] flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
        RACSignal *single = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext: [NSString stringWithFormat:@"字符串个数：%ld", value.length]];
            [subscriber sendCompleted];
            return nil;
        }];
        return single;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    

}


@end
