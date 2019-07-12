//
//  FifthViewController.m
//  Runtime
//
//  Created by 熊智凡 on 2019/7/10.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "FifthViewController.h"
#import <objc/runtime.h>

@interface FifthViewController ()

@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    char *className = "Student";
    Class kCls = objc_getClass(className);
    if (kCls == nil) {
        Class superClass = [NSObject class];
        kCls = objc_allocateClassPair(superClass, className, 0);
    }
    
    char *ivar_name_0 = "_name";
    class_addIvar(kCls, ivar_name_0, sizeof(NSString *), 0, "@");
    char *p_name_0 = "name";
    objc_property_attribute_t attribute_0 = {"N"};
    objc_property_attribute_t attribute_1 = {"T","@\"NSString\""};
    objc_property_attribute_t attribute_2 = {"V",p_name_0};
    objc_property_attribute_t attribute_3 = {"C"};
    objc_property_attribute_t attributes[] = {attribute_0, attribute_1, attribute_2, attribute_3};
    class_addProperty(kCls, p_name_0, attributes, 3);
    
    char *ivar_name_1 = "_age";
    class_addIvar(kCls, ivar_name_1, sizeof(NSInteger), 0, "@");
    class_addMethod(kCls, @selector(setAge:), (IMP)setAge, "v@:@");
    class_addMethod(kCls, @selector(age), (IMP)age, "@@:");
    
    objc_registerClassPair(kCls);
    id obj = [[kCls alloc] init];
    [obj setValue:@"Jack" forKey:@"name"];
    NSString *value = [obj valueForKey:@"name"];
    [obj setValue:@(12) forKey:@"age"];
    NSInteger value2 = [[obj valueForKey:@"age"] integerValue];
    NSLog(@"%@ - %ld", value, value2);
    
}

- (void)setAge:(NSInteger)age {}
- (NSInteger)age {
    return 0;
}

void setAge(id self_t, SEL _cmd_t, NSNumber *age) {
    NSMutableString *selName = [NSMutableString stringWithString:NSStringFromSelector(_cmd_t)];
    [selName deleteCharactersInRange:NSMakeRange(0, 3)];
    [selName replaceCharactersInRange:NSMakeRange(0, 1) withString: [[selName substringToIndex:1] lowercaseString]];
    [selName insertString:@"_" atIndex:0];
    [selName deleteCharactersInRange:NSMakeRange(selName.length - 1, 1)];
    Ivar ivar = class_getInstanceVariable([self_t class], [[selName copy] UTF8String]);
    object_setIvar(self_t, ivar, age);
}

id age(id self_t, SEL _cmd_t) {
    NSMutableString *selName = [NSMutableString stringWithString:NSStringFromSelector(_cmd_t)];
    [selName insertString:@"_" atIndex:0];
    Ivar ivar = class_getInstanceVariable([self_t class], [[selName copy] UTF8String]);
    id value = object_getIvar(self_t, ivar);
    return value;
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
