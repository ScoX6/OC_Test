//
//  NinthViewController.m
//  Runtime
//
//  Created by xiongzhifan on 2019/7/14.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "NinthViewController.h"
#import <objc/runtime.h>

void swizzleMethod(id target, SEL old, SEL new) {
    Method oldMethod = class_getInstanceMethod(target, old);
    Method newMethod = class_getInstanceMethod(target, new);
    BOOL didAddMethod = class_addMethod(target, old, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
    BOOL didAddMethod2 = class_addMethod(target, new, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
//    if (didAddMethod) {
//        class_replaceMethod(target, new, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
//    }else {
        method_exchangeImplementations(oldMethod, newMethod);
//    }
}

@interface Ninth_Person: NSObject

- (void)sayHello;
+ (BOOL)jr_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_;

@end

@implementation Ninth_Person

- (void)sayHello {
    NSLog(@"Person say hello");
}

+ (BOOL)jr_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_ {
    
    Method origMethod = class_getInstanceMethod(self, origSel_);
    if (!origMethod) {
//        SetNSError(error_, @"original method %@ not found for class %@", NSStringFromSelector(origSel_), [self class]);
        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(self, altSel_);
    if (!altMethod) {
//        SetNSError(error_, @"alternate method %@ not found for class %@", NSStringFromSelector(altSel_), [self class]);
        return NO;
    }
    
    class_addMethod(self,
                    origSel_,
                    class_getMethodImplementation(self, origSel_),
                    method_getTypeEncoding(origMethod));
    
    class_addMethod(self,
                    altSel_,
                    class_getMethodImplementation(self, altSel_),
                    method_getTypeEncoding(altMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));
    return YES;
}

@end

@interface Ninth_Student : Ninth_Person

@end

@implementation Ninth_Student

+ (void)load {
//    swizzleMethod(self, @selector(sayHello), @selector(new_sayHello));
    [self jr_swizzleMethod:@selector(sayHello) withMethod:@selector(new_sayHello) error:nil];
}

- (void)new_sayHello {
    [self new_sayHello];
    NSLog(@"Student + swizzle say hello");
}

@end

@interface NinthViewController ()

@property (nonatomic, strong) Ninth_Student *stu;

@end

@implementation NinthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    
}

- (void)test1 {
    
    self.stu = [[Ninth_Student alloc] init];
    [self.stu sayHello];
    
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
