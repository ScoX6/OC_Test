//
//  NSObject+SXDynamicProperty.h
//  OC_Test
//
//  Created by 熊智凡 on 2019/2/26.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SXDynamicProperty)

+ (void)addObjectProperty:(NSString *)pname;

+ (void)addObjectProperty:(NSString *)pname associationPolicy:(objc_AssociationPolicy)policy;

+ (void)addBasicProperty:(NSString *)pname encodingType:(char *)type;

@end

NS_ASSUME_NONNULL_END
