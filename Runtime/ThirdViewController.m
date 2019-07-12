//
//  ThirdViewController.m
//  Runtime
//
//  Created by 熊智凡 on 2019/7/9.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "ThirdViewController.h"
#import <objc/runtime.h>

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    const char *className;
    className = [@"Student" UTF8String];
    Class kclass = objc_getClass(className);
    if (!kclass) {
        Class superClass = [NSObject class];
        kclass = objc_allocateClassPair(superClass, className, 0);
    }
    class_addIvar(kclass, "_stuName", sizeof(NSString *), 0, "@");
    class_addMethod([kclass class], @selector(say:), (IMP)say, "v@:");
    
    NSString *propertyName = @"stuSex";
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = {"C", "copy"};
    objc_property_attribute_t backingivar = {"V", [propertyName UTF8String]};
    objc_property_attribute_t attrs[] = {type, ownership, backingivar};
    BOOL isOK = class_addProperty(kclass, [propertyName UTF8String], attrs, 3);
    
    class_addMethod(kclass, @selector(stuSex), (IMP)Getter, "@@:");
    class_addMethod(kclass, @selector(setStuSex:), (IMP)Setter, "v@:@");

    
    objc_registerClassPair(kclass);
}

- (void)say:(NSString *)string {
}

void say(id self, SEL _cmd, NSString *string) {
    NSLog(@"你好%@", string);
}

- (void)setStuSex:(NSString *)stuSex {
    
}

- (NSString *)stuSex {
    return nil;
}

void Setter(id self1, SEL _cmd1, NSString *newObject) {
    NSString * var=[NSStringFromSelector(_cmd1) stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@""];
    NSString * head=[var substringWithRange:NSMakeRange(0, 1)];
    head=[head lowercaseString];
    var=[var stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:head];
    var=[var stringByReplacingCharactersInRange:NSMakeRange([var length]-1, 1) withString:@""];
    Ivar ivar=class_getInstanceVariable([self1 class], [var cStringUsingEncoding:NSUTF8StringEncoding]);
    id oldName=object_getIvar(self1, ivar);
    if (oldName!=newObject) {
        object_setIvar(self1, ivar, [newObject copy]);
    }
}

NSString * Getter(id self1, SEL _cmd1) {
    NSString *var = NSStringFromSelector(_cmd1);
    Ivar ivar = class_getInstanceVariable([self1 class], [var cStringUsingEncoding:NSUTF8StringEncoding]);
    return object_getIvar(self1, ivar);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    id p = [[NSClassFromString(@"Student") alloc] init];
    [p setValue:@"张三" forKey:@"stuName"];
    [p setValue:@"男" forKey:@"stuSex"];
    NSLog(@"%@", [p valueForKey:@"stuSex"]);
    NSLog(@"%@", [p valueForKey:@"stuName"]);
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
