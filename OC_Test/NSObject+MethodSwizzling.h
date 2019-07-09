//
//  NSObject+MethodSwizzling.h
//  OC_Test
//
//  Created by 熊智凡 on 2019/2/28.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MethodSwizzling)

void methodSwizzling(Class class, SEL originSel, SEL overrideSel);

@end

NS_ASSUME_NONNULL_END
