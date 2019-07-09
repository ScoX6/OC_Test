//
//  NSObject+SX_KVO.m
//  OC_Test
//
//  Created by Sco.X on 2018/8/26.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "NSObject+SX_KVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

NSString *const kSXKVOClassPrefix = @"SXKVOClassPrefix_";
NSString *const kSXKVOAssociatedObservers = @"SXKVOAssociatedObservers";

#pragma mark - PGObservationInfo
@interface SXObservationInfo : NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) SXObservingBlock block;

@end

@implementation SXObservationInfo

- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key block:(SXObservingBlock)block
{
    self = [super init];
    if (self) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    return self;
}

@end


#pragma mark - Helpers
static NSString * getterForSetter(NSString *setter)
{
    if (setter.length <=0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) {
        return nil;
    }
    
    // remove 'set' at the begining and ':' at the end
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    
    // lower case the first letter
    NSString *firstLetter = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                       withString:firstLetter];
    
    return key;
}


static NSString * setterForGetter(NSString *getter)
{
    if (getter.length <= 0) {
        return nil;
    }
    
    // upper case the first letter
    NSString *firstLetter = [[getter substringToIndex:1] uppercaseString];
    NSString *remainingLetters = [getter substringFromIndex:1];
    
    // add 'set' at the begining and ':' at the end
    NSString *setter = [NSString stringWithFormat:@"set%@%@:", firstLetter, remainingLetters];
    
    return setter;
}

static NSArray *ClassMethodNames(Class c) {
    NSMutableArray *array = [NSMutableArray array];
    unsigned int outCount = 0;
    Method *methodList = class_copyMethodList(c, &outCount);
    unsigned int i = 0;
    for (i = 0; i < outCount; ++i) {
        NSString *methodName = NSStringFromSelector(method_getName(methodList[i]));
        [array addObject:methodName];
    }
    free(methodList);
    return array;
}

static void PrintDescription(NSString *name, id obj)
{
    NSString *str = [NSString stringWithFormat:
                     @"%@: %@\n\tNSObject class %s\n\tRuntime class %s\n\timplements methods <%@>\n\n",
                     name,
                     obj,
                     class_getName([obj class]),
                     class_getName(object_getClass(obj)),
                     [ClassMethodNames(object_getClass(obj)) componentsJoinedByString:@", "]];
    printf("%s\n", [str UTF8String]);
}

static void kvo_setter(id self, SEL _cmd, id newValue) {
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = getterForSetter(setterName);
    
    if (!getterName) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have setter %@", self, setterName];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        return;
    }
    
    id oldValue = [self valueForKey:getterName];
    
    struct objc_super superClazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    void (*objc_msgSendSuperCasted)(void *, SEL, id) = (void *)objc_msgSendSuper;
    objc_msgSendSuperCasted(&superClazz, _cmd, newValue);
    
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)kSXKVOAssociatedObservers);
    for (SXObservationInfo *each in observers) {
        if ([each.key isEqualToString:getterName]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                each.block(self, getterName, oldValue, newValue);
            });
            break;
        }
    }
}

static Class kvo_class(id self, SEL _cmd)
{
    return class_getSuperclass(object_getClass(self));
}

@implementation NSObject (SX_KVO)

- (void)SX_addObserver:(NSObject *)observer forKey:(NSString *)key withBlock:(SXObservingBlock)block {
    
    // 1. 检查该类是否含有 key 属性对应的setter方法
    SEL setterSelector = NSSelectorFromString(setterForGetter(key));
    Method setterMethod = class_getInstanceMethod([self class], setterSelector);
    if (!setterMethod) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have a setter for key %@", self, key];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        return;
    }
    
    // 2. 判断是否已经设置过动态KVO子类
    Class clazz = object_getClass(self);
    NSString *className = NSStringFromClass(clazz);
    
    // 2.1 如果没有设置过，则设置
    if (![className hasPrefix:kSXKVOClassPrefix]) {
        clazz = [self makeKvoClassWithOriginalClassName:className];
        object_setClass(self, clazz);
    }
    
    // 3. 替换原有的setter方法
    if (![self hasSelector:setterSelector]) {
        const char *types = method_getTypeEncoding(setterMethod);
        class_addMethod(clazz, setterSelector, (IMP)kvo_setter, types);
    }
    
    // 4. 保存kvo状态
    SXObservationInfo *info = [[SXObservationInfo alloc] initWithObserver:observer Key:key block:block];
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(kSXKVOAssociatedObservers));
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge const void *)(kSXKVOAssociatedObservers), observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject:info];
}

- (void)SX_removeObserver:(NSObject *)observer forKey:(NSString *)key {
    NSMutableArray* observers = objc_getAssociatedObject(self, (__bridge const void *)(kSXKVOAssociatedObservers));
    SXObservationInfo *infoToRemove;
    for (SXObservationInfo* info in observers) {
        if (info.observer == observer && [info.key isEqual:key]) {
            infoToRemove = info;
            break;
        }
    }
    [observers removeObject:infoToRemove];
}

- (Class)makeKvoClassWithOriginalClassName:(NSString *)originalClazzName {
    NSString *kvoClazzName = [kSXKVOClassPrefix stringByAppendingString:originalClazzName];
    Class clazz = NSClassFromString(kvoClazzName);
    if (clazz) {
        return clazz;
    }
    
    Class originalClazz = object_getClass(self);
    Class kvoClazz = objc_allocateClassPair(originalClazz, kvoClazzName.UTF8String, 0);
    
    Method clazzMethod = class_getInstanceMethod(kvoClazz, @selector(class));
    const char *types = method_getTypeEncoding(clazzMethod);
    class_addMethod(kvoClazz, @selector(class), (IMP)kvo_class, types);
    
    objc_registerClassPair(kvoClazz);
    
    return kvoClazz;
}

- (BOOL)hasSelector:(SEL)selector {
    Class clazz = object_getClass(self);
    unsigned int outCount = 0;
    Method *methodList = class_copyMethodList(clazz, &outCount);
    unsigned int i = 0;
    for (i = 0; i < outCount; ++i) {
        SEL thisSelector = method_getName(methodList[i]);
        if (thisSelector == selector) {
            free(methodList);
            return YES;
        }
    }
    free(methodList);
    return NO;
}

@end


