//
//  NSObject+SXDynamicProperty.m
//  OC_Test
//
//  Created by 熊智凡 on 2019/2/26.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "NSObject+SXDynamicProperty.h"
#import <UIKit/UIKit.h>

static NSString *SXAddPropertyException = @"SXAddPropertyException";

static inline NSString *__sx_setter_selector_name_of_property(NSString *property)
{
    NSString *headCharacter = [[property substringToIndex:1] uppercaseString];
    NSString *OtherString = [property substringFromIndex:1];
    return [NSString stringWithFormat:@"set%@%@:",headCharacter,OtherString];
}

@implementation NSObject (SXDynamicProperty)

+ (void)addObjectProperty:(NSString *)pname {
    [self addObjectProperty:pname associationPolicy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

+ (void)addObjectProperty:(NSString *)pname associationPolicy:(objc_AssociationPolicy)policy {
    
    if (pname.length <= 0) {
        [NSException exceptionWithName:SXAddPropertyException reason:@"property must not be empty in +addObjectProperty:associationPolicy:" userInfo:@{@"name":pname,@"policy":@(policy)}];
    }
    
    // 1、通过class的指针和property的name，创建一个唯一的key
    NSString *key = [NSString stringWithFormat:@"%p_%@",self,pname];
    
    // 2、用block实现set方法
    id setBlock = ^(id self, id value) {
        objc_setAssociatedObject(self, (__bridge void *)key, value, policy);
    };
    
    // 3、将block转换为IMP
    IMP setImp = imp_implementationWithBlock(setBlock);
    
    // 4、用name拼接出setter方法
    NSString *selString = __sx_setter_selector_name_of_property(pname);
    
    // 5、将setter方法添加到class中
    BOOL result = class_addMethod([self class], NSSelectorFromString(selString), setImp, "v@:@");
    assert(result);
    
    // 6、用block实现getter方法
    id getBlock = ^id(id self) {
        return objc_getAssociatedObject(self, (__bridge void *)key);
    };
    
    // 7、将getter的block转换成IMP
    IMP getImp = imp_implementationWithBlock(getBlock);
    
    // 8、添加getter方法
    result = class_addMethod([self class], NSSelectorFromString(pname), getImp, "@@:");
    assert(result);
}

+ (void)addBasicProperty:(NSString *)pname encodingType:(char *)type {
    if (pname.length <= 0) {
        [[NSException exceptionWithName:SXAddPropertyException
                                 reason:@"property must not be empty in +addBasicProperty:encodingType:"
                               userInfo:@{@"name":pname,@"type":@(type)}] raise];
    }
    
    if (strcmp(type, @encode(id)) == 0) {
        [self addObjectProperty:pname];
        return;
    }
    
    // 1、通过class指针和property的name生成唯一key
    NSString *key = [NSString stringWithFormat:@"%p_%@",self,pname];
    id setBlock;
    id getBlock;
#define blockWithCaseType(C_TYPE) \
    if (strcmp(type, @encode(C_TYPE)) == 0) { \
        setBlock = ^(id self, C_TYPE var) { \
            NSValue *value = [NSValue value:&var withObjCType:type]; \
            objc_setAssociatedObject(self,(__bridge void*)key,value,OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
        }; \
        getBlock = ^C_TYPE(id self) { \
            NSValue *value = objc_getAssociatedObject(self,(__bridge void*)key);\
            C_TYPE var; \
            [value getValue:&var];  \
            return var; \
        };\
    }
    
    blockWithCaseType(char);
    blockWithCaseType(unsigned char);
    blockWithCaseType(short);
    blockWithCaseType(unsigned int);
    blockWithCaseType(long);
    blockWithCaseType(unsigned long);
    blockWithCaseType(long long);
    blockWithCaseType(float);
    blockWithCaseType(double);
    blockWithCaseType(BOOL);
    
    blockWithCaseType(CGPoint);
    blockWithCaseType(CGSize);
    blockWithCaseType(CGVector);
    blockWithCaseType(CGRect);
    blockWithCaseType(NSRange);
    blockWithCaseType(CGAffineTransform);
    blockWithCaseType(CATransform3D);
    blockWithCaseType(UIOffset);
    blockWithCaseType(UIEdgeInsets);
#undef blockWithCaseType
    
    if (!setBlock || !getBlock) {
        [[NSException exceptionWithName:SXAddPropertyException reason:@"type is an unknown type in +addBasicProperty:encodingType:" userInfo:@{@"name":pname,@"type":@(type)}] raise];
    }
    
    IMP setImp = imp_implementationWithBlock(setBlock);
    NSString *selString = __sx_setter_selector_name_of_property(pname);
    NSString *setType = [NSString stringWithFormat:@"v@:%@",@(type)];
    BOOL result = class_addMethod([self class], NSSelectorFromString(selString), setImp, [setType UTF8String]);
    assert(result);
    
    IMP getImp = imp_implementationWithBlock(getBlock);
    NSString *getType = [NSString stringWithFormat:@"%@@:",@(type)];
    result = class_addMethod([self class], NSSelectorFromString(pname), getImp, [getType UTF8String]);
    assert(result);
    
    
}

@end
