//
//  EighthViewController.m
//  Runtime
//
//  Created by xiongzhifan on 2019/7/13.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "EighthViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface EighthViewController ()

@property (nonatomic, strong) NSNumber *num;

@property (nonatomic, strong) NSValue *value;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, assign) float height;

@property (nonatomic, weak) id delegate;

@property (nonatomic, copy) dispatch_block_t block;

@end

@implementation EighthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    
}

- (void)test1 {
    
    Class cls = [self class];
    unsigned int count = 0;
    objc_property_t *propertys = class_copyPropertyList(cls, &count);
    for (unsigned int i = 0; i < count; ++i) {
        objc_property_t p = propertys[i];
        const char *name = property_getName(p);
        unsigned int c = 0;
        objc_property_attribute_t *attributes = property_copyAttributeList(p, &c);
        const char *c_a = property_getAttributes(p);
        NSLog(@"🤬 %s - %s", name, c_a);
        for (unsigned int j = 0; j < c; ++j) {
            objc_property_attribute_t p_a = attributes[j];
            NSLog(@"🤬 %s: attribute name - %s, attribute value - %s", name, p_a.name, p_a.value);
        }
        NSLog(@"🤬 --------------------------------------");
    }
    free(propertys);
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
