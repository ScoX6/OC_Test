//
//  SeventhViewController.m
//  Runtime
//
//  Created by 熊智凡 on 2019/7/12.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "SeventhViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@protocol SeventhViewController <NSObject>

@property (nonatomic, assign) BOOL kind;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) NSNumber *num;

- (void)Heiha;

@optional
- (void)sayMessage;

+ (void)todo;

@end

@interface SeventhViewController () <SeventhViewController>

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UITableView *tb;

@end

@implementation SeventhViewController
@synthesize kind = _kind;
@synthesize message = _message;
@synthesize num = _num;

- (void)Heiha {
    NSLog(@"Heiha");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Ivar ivar = class_getInstanceVariable([self class], "_tb");
    const char *typeEncoding = ivar_getTypeEncoding(ivar);
    NSLog(@"👹 - %s - %s", typeEncoding, @encode(UITableView *));
    
    [self test4];

}

- (void)test1 {
    Class superClass = class_getSuperclass([self class]);
    NSLog(@"[self class] superClass: %@", NSStringFromClass(superClass));
    
    size_t size = class_getInstanceSize([self class]);
    NSLog(@"[self class] size: %zu", size);
    
    Method m = class_getInstanceMethod([self class], @selector(say:));
    NSLog(@"[self class] method name: %@", NSStringFromSelector(method_getName(m)));
    
    Ivar ivar = class_getInstanceVariable([self class], "_name");
    NSLog(@"[self class] ivar name: %@", [NSString stringWithUTF8String:ivar_getName(ivar)]);
    
    Method m2 = class_getClassMethod([self class], @selector(load));
    NSLog(@"[self class] class method name: %@", NSStringFromSelector(method_getName(m2)));
    
    objc_property_t property = class_getProperty([self class], "name");
    const char *p_name = property_getName(property);
    NSLog(@"[self class] property: %s", p_name);
    
    IMP imp = class_getMethodImplementation([self class], @selector(say:));
    ((id(*)(id,SEL,NSString*))imp)(self,@selector(say:),@"Hello objc_msgSend");
    
    objc_msgSend(self, @selector(say:), @"Hello objc_msgSend");
    
    Method m3 = class_getInstanceMethod([self class], @selector(say:));
    IMP imp2 = method_getImplementation(m3);
    ((id(*)(id,SEL,NSString*))imp2)(self,@selector(say:),@"Hello objc_msgSend");
    
    IMP imp3 = [self methodForSelector:@selector(say:)];
    ((id(*)(id,SEL,NSString*))imp3)(self,@selector(say:),@"Hello objc_msgSend");
    
}

- (void)test2 {
    Class cls = [self class];
    unsigned int count_0 = 0;
    Ivar *ivars = class_copyIvarList(cls, &count_0);
    for (unsigned int i = 0; i < count_0; ++i) {
        Ivar ivar = ivars[i];
        const char *c_ivar_name = ivar_getName(ivar);
        ptrdiff_t offset = ivar_getOffset(ivar);
        const char *typeEncoding = ivar_getTypeEncoding(ivar);
        NSLog(@"name: %s    offset: %td    typeEncoding: %s", c_ivar_name, offset, typeEncoding);
    }
    free(ivars);
    
    unsigned int count_1 = 0;
    Method *methods = class_copyMethodList(cls, &count_1);
    for (unsigned int i = 0; i < count_1; ++i) {
        Method method = methods[i];
        SEL name = method_getName(method);
        const char *typeEncoding = method_getTypeEncoding(method);
        const char *returnType = method_copyReturnType(method);
        const char *argumentType = method_copyArgumentType(method, 0);
        struct objc_method_description *desc = method_getDescription(method);
        char *types = desc->types;
        unsigned int argCount = method_getNumberOfArguments(method);
        NSLog(@"name: %@    typeEncoding: %s    returnType: %s    argumentType: %s    types: %s    argCount: %ud", NSStringFromSelector(name), typeEncoding, returnType, argumentType, types, argCount);
    }
    free(methods);
    
    unsigned int count_2 = 0;
    objc_property_t *propertys = class_copyPropertyList(cls, &count_2);
    for (unsigned int i = 0; i < count_2; ++i) {
        objc_property_t pt = propertys[i];
        const char *p_name = property_getName(pt);
        const char *attributes = property_getAttributes(pt);
        unsigned int count = 0;
        objc_property_attribute_t *pas = property_copyAttributeList(pt, &count);
        for (unsigned int j = 0; j < count; ++j) {
            objc_property_attribute_t pa = pas[j];
            char *attributeValue = property_copyAttributeValue(pt, pa.name);
            NSLog(@"attributeName: %s    attributeValue: %s    attributeValue: %s", pa.name, pa.value, attributeValue);
        }
        NSLog(@"p_name: %s    attributes: %s", p_name, attributes);
        free(pas);
    }
    
    
    unsigned int count_3 = 0;
    Protocol * __unsafe_unretained *protocols = class_copyProtocolList(cls, &count_3);
    for (unsigned int i = 0; i < count_3; ++i) {
        Protocol *protocol = protocols[i];
        const char *p_name = protocol_getName(protocol);
        NSLog(@"protocolName: %s", p_name);
        unsigned int c0 = 0;
        objc_property_t *propertys = protocol_copyPropertyList(protocol, &c0);
        for (unsigned int j = 0; j < c0; ++j) {
            objc_property_t p = propertys[j];
            NSLog(@"protocol property name: %s", property_getName(p));
        }
        free(propertys);
        unsigned int c1 = 0;
        struct objc_method_description *m_descs = protocol_copyMethodDescriptionList(protocol, YES, YES, &c1);
        for (unsigned int k = 0; k < c1; ++k) {
            struct objc_method_description desc = m_descs[k];
            NSLog(@"protocol method name: %@    type: %s", NSStringFromSelector(desc.name), desc.types);
        }
        free(m_descs);
    }
    free(protocols);
}

- (void)test3 {
    char *clsName = "SubViewController";
    Class kCls = objc_getClass(clsName);
    if (kCls == nil) {
        Class superClass = [self class];
        kCls = objc_allocateClassPair(superClass, clsName, 0);
    }
    
    char *number_c = "_number";
    class_addIvar(kCls, number_c, sizeof(NSNumber *), 0, "@");
    class_addMethod(kCls, @selector(number), (IMP)getNumber, "@@:");
    class_addMethod(kCls, @selector(setNumber:), (IMP)setNumber, "v@:@");
    
    char *ivar_number_c2 = "_age";
    BOOL res = class_addIvar(kCls, ivar_number_c2, sizeof(NSNumber *), 0, "@");
    NSAssert(res, @"添加失败");
    char *number_c2 = "age";
    objc_property_attribute_t a1 = {"T","@\"NSString\""};
    objc_property_attribute_t a2 = {"C"};
    objc_property_attribute_t a3 = {"N"};
    objc_property_attribute_t a4 = {"V","age"};
    objc_property_attribute_t as[] = {a1,a2,a3,a4};
    BOOL result = class_addProperty(kCls, number_c2, as, 3);
    if (result) {
        NSLog(@"添加成功");
    }
    
    objc_registerClassPair(kCls);
    
    id obj = [[kCls alloc] init];
    [obj Heiha];
    [obj setValue:@(10001) forKey:@"number"];
    NSLog(@"%@", [obj valueForKey:@"number"]);
    [obj setValue:@"12" forKey:@"_age"];
    NSLog(@"%@", [obj valueForKey:@"_age"]);
    NSLog(@"%@    superClassName: %@", obj, NSStringFromClass([obj superclass]));
}

- (void)setNumber:(NSNumber *)number {}
- (NSNumber *)number {
    return nil;
}

void setNumber(id self_p, SEL _cmd_p, NSNumber *num) {
    NSMutableString *str = [NSMutableString stringWithString:NSStringFromSelector(_cmd_p)];
    [str deleteCharactersInRange:NSMakeRange(0, 3)];
    [str replaceCharactersInRange:NSMakeRange(0, 1) withString:[[str substringToIndex:1] lowercaseString]];
    [str insertString:@"_" atIndex:0];
    [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
    Ivar ivar = class_getInstanceVariable([self_p class], [str UTF8String]);
    object_setIvar(self_p, ivar, num);
}

NSNumber* getNumber(id self_p, SEL _cmd_p) {
    NSMutableString *str = [NSMutableString stringWithString:NSStringFromSelector(_cmd_p)];
    [str insertString:@"_" atIndex:0];
    Ivar ivar = class_getInstanceVariable([self_p class], [str UTF8String]);
    return object_getIvar(self_p, ivar);
}

- (void)say:(NSString *)message {
    NSLog(@"%@", message);
}

- (void)test4 {
    const char *cls_name = "NewViewController";
    Class cls = objc_getClass(cls_name);
    if (cls == nil) {
        Class superClass = [UIViewController class];
        cls = objc_allocateClassPair(superClass, cls_name, 0);
        NSAssert(cls != nil, @"创建失败");
    }
    
    char *ivar_name_0 = "_tableView";
    BOOL res_0 = class_addIvar(cls, ivar_name_0, sizeof(UITableView *), 0, @encode(UITableView *));
    NSAssert(res_0, @"创建失败");
    char *p_name_0 = "tableView";
    objc_property_attribute_t p_a_0 = {"N"};
    objc_property_attribute_t p_a_1 = {"&"};
    objc_property_attribute_t p_a_2 = {"T", "@\"UITableView\""};
    objc_property_attribute_t p_a_3 = {"V",p_name_0};
    objc_property_attribute_t attributes_0[] = {p_a_0, p_a_1, p_a_2, p_a_3};
    BOOL res_1 = class_addProperty(cls, p_name_0, attributes_0, 3);
    NSAssert(res_1, @"创建失败");
    
    objc_registerClassPair(cls);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    Class cls = NSClassFromString(@"NewViewController");
//    UIViewController *vc = [[cls alloc] init];
//    vc.view.backgroundColor = UIColor.magentaColor;
//    UITableView *tbv = [[UITableView alloc] init];
//    tbv.delegate = self;
//    tbv.dataSource = self;
//    [tbv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    tbv.backgroundColor = UIColor.orangeColor;
//    tbv.tableFooterView = [[UIView alloc] init];
//    tbv.frame = CGRectMake(0, 100, self.view.bounds.size.width, 300);
//    [vc.view addSubview:tbv];
//    [vc setValue:tbv forKey:@"tableView"];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)test5 {
    
    
}

#pragma mark- UITableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35.f;
}

#pragma mark- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tbCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    tbCell.textLabel.text = @"Hello World";
    return tbCell;
}

@end
