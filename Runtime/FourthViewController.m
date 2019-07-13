//
//  FourthViewController.m
//  Runtime
//
//  Created by 熊智凡 on 2019/7/10.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "FourthViewController.h"
#import <objc/runtime.h>

@interface FourthViewController ()

@property (nonatomic, assign) BOOL kind;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) dispatch_block_t block;

@property (nonatomic, strong) NSArray *ary;

@property (nonatomic, weak) UIViewController *vc;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    char *buf1 = @encode(int **);
    char *buf2 = @encode(char);
    char *buf3 = @encode(NSString *);
    char *buf4 = @encode(char[]);
    char *buf5 = @encode(NSArray *);
    char *buf6 = @encode(int[]);
    char *buf7 = @encode(char *);
    char *buf8 = @encode(void);
    char *buf9 = @encode(void *);
    NSLog(@"@encode(int **) <-> %s", buf1);
    NSLog(@"@encode(char) <-> %s", buf2);
    NSLog(@"@encode(NSString) <-> %s", buf3);
    NSLog(@"@encode(char[]) <-> %s", buf4);
    NSLog(@"@encode(NSArray *) <-> %s", buf5);
    NSLog(@"@encode(int[]) <-> %s", buf6);
    NSLog(@"@encode(char *) <-> %s", buf7);
    NSLog(@"@encode(void) <-> %s", buf8);
    NSLog(@"@encode(void *) <-> %s", buf9);
    
    Method m = class_getInstanceMethod(object_getClass(self), @selector(stuSex));
    Method m2 = class_getInstanceMethod(object_getClass(self), @selector(setStuSex:));
    const char *cName = method_getTypeEncoding(m);
    const char *cName2 = method_getTypeEncoding(m2);
    NSLog(@"cName: %s", cName);
    NSLog(@"cName2: %s", cName2);
    
    unsigned int outCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(object_getClass(self), &outCount);
    for (unsigned int i = 0; i < outCount; ++i) {
        objc_property_t p_t = propertyList[i];
        const char *cName = property_getName(p_t);
        NSLog(@"cName: %s", cName);
        const char *attributes = property_getAttributes(p_t);
        NSLog(@"attributes: %s", attributes);
    }
}

- (void)setStuSex:(NSString *)stuSex {
    
}

- (NSString *)stuSex {
    return nil;
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
