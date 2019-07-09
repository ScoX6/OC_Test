//
//  NSObject+MethodSwizzling.m
//  OC_Test
//
//  Created by 熊智凡 on 2019/2/28.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "NSObject+MethodSwizzling.h"
#import <objc/runtime.h>

@implementation NSObject (MethodSwizzling)

void methodSwizzling(Class class, SEL originSel, SEL overrideSel) {
    Method originMethod = class_getClassMethod(class, originSel);
    Method overrideMethod = class_getClassMethod(class, overrideSel);
    if (class_addMethod(class, originSel, method_getImplementation(overrideMethod), method_getTypeEncoding(originMethod))) {
        class_replaceMethod(class, overrideSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else {
        method_exchangeImplementations(originMethod, overrideMethod);
    }
}

@end
