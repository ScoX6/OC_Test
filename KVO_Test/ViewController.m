//
//  ViewController.m
//  KVO_Test
//
//  Created by 熊智凡 on 2019/7/9.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSUInteger, PersonGender) {
    PersonMan,
    PersonWomen,
};

@interface Finger : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger length;

@end

@implementation Finger

@end

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) PersonGender gender;

@property (nonatomic, strong) NSMutableArray<Finger *> *fingers;

@end

@implementation Person

- (instancetype)init {
    if (self = [super init]) {
        self.fingers = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)alloc {
    return [super alloc];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [super allocWithZone:zone];
}

- (void)setName:(NSString *)name {
    _name = name;
}

@end

@interface ViewController ()

@property (nonatomic, strong) Person *personA;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.cyanColor;
    
    self.personA = [[Person alloc] init];
    
    NSLog(@"🤭 - %s", object_getClassName(self.personA));
    [self.personA addObserver:self forKeyPath:@"name" options: NSKeyValueObservingOptionPrior context:@"D"];
    NSLog(@"🤭 - %s", object_getClassName(self.personA));

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"🙄 - keyPath: %@", keyPath);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    uint32_t num = arc4random() % 4;
    self.personA.name = [NSString stringWithFormat:@"name - %d", num];
}

@end
