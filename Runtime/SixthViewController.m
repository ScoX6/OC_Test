//
//  SixthViewController.m
//  Runtime
//
//  Created by 熊智凡 on 2019/7/10.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "SixthViewController.h"
#import <objc/runtime.h>

@interface A : NSString

+ (void)classA;
- (void)instanceA;

@end

@implementation A

+ (void)classA {
    NSLog(@"🥺 - 类方法 classA");
}

- (void)instanceA {
    NSLog(@"🥺 - 实例方法 classA");
}

@end

@interface B : A

+ (void)classB;
- (void)instanceB;

@end

@implementation B

+ (void)classB {
    NSLog(@"🥺 - 类方法 classB");
}

- (void)instanceB {
    NSLog(@"🥺 - 实例方法 classB");
}

@end


@interface C : B

+ (void)classC;
- (void)instanceC;

@end

@implementation C

+ (void)classC {
    NSLog(@"🥺 - 类方法 classC");
}

- (void)instanceC {
    NSLog(@"🥺 - 实例方法 classC");
}

@end

@interface D : C

+ (void)classD;
- (void)instanceD;

@end

@implementation D

+ (void)classD {
    NSLog(@"🥺 - 类方法 classD");
}

- (void)instanceD {
    NSLog(@"🥺 - 实例方法 classD");
}

@end

@interface SixthViewController ()

@property (nonatomic, copy) NSString *message;

@end

@implementation SixthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    D *d = [[D alloc] init];

    Class normalClass = object_getClass(d);
    Class metaClass = object_getClass(normalClass);
    
    unsigned int outCount = 0;
    Method *methodList = class_copyMethodList(normalClass, &outCount);
    for (unsigned int i = 0; i < outCount; ++i) {
        Method m = methodList[i];
        SEL sel = method_getName(m);
        NSString *selName = NSStringFromSelector(sel);
        NSLog(@"👽 - %@", selName);
    }
    free(methodList);
    Method *methodList2 = class_copyMethodList(metaClass, &outCount);
    for (unsigned int i = 0; i < outCount; ++i) {
        Method m = methodList2[i];
        SEL sel = method_getName(m);
        NSString *selName = NSStringFromSelector(sel);
        NSLog(@"🙄 - %@", selName);
    }
    free(methodList2);

    NSLog(@"");
    
    
    [self setValue:@"Test Me" forUndefinedKey:@"message"];
    id value = [self valueForUndefinedKey:@"message"];
    NSLog(@"undefined key: %@", value);
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
