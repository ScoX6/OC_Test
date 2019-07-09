//
//  ViewController.m
//  Runtime
//
//  Created by Sco.X on 2018/9/4.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface Pet: NSObject

@property (nonatomic, copy) NSString *nickName;

@end

@implementation Pet
@end

@interface Person: NSObject <NSCoding> {
    @public
    NSInteger _age;
    CGFloat _height;
    CGFloat _weight;
    Pet *_pet;
    @protected
    NSString *_name;
    NSString *_gender;
    @private
    NSString *_no;
}

@property (nonatomic, copy) NSString *name;

+ (void)PersonStaticMethod;

@end


@implementation Person
@synthesize name = _name;

+ (void)PersonStaticMethod {
    
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {

}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    return nil;
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self rumtime_class_prefix];

}

- (void)rumtime_class_prefix {
    
    {
        unsigned int outCount;
        Ivar *ivars = class_copyIvarList([Person class], &outCount);
        for (unsigned int i = 0; i < outCount; ++i) {
            const char *cName = ivar_getName(ivars[i]);
            NSString *name = [NSString stringWithUTF8String:cName];
            NSLog(@"%@", name);
        }
    }
    
    NSLog(@"\n\n🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲\n");
    
    {
        unsigned int outCount;
        objc_property_t *propertys = class_copyPropertyList([Person class], &outCount);
        for (unsigned int i = 0; i < outCount; ++i) {
            const char *cName = property_getName(propertys[i]);
            NSString *name = [NSString stringWithUTF8String:cName];
            NSLog(@"%@", name);
        }
    }
    
    NSLog(@"\n\n🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲\n");

    {
        unsigned int outCount;
        Method *methods = class_copyMethodList([Person class], &outCount);
        for (unsigned int i = 0; i < outCount; ++i) {
            SEL selector = method_getName(methods[i]);
            NSString *name = NSStringFromSelector(selector);
            NSLog(@"%@", name);
        }
    }
    
    NSLog(@"\n\n🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲\n");
    
    {
        id clazz = object_getClass([Person class]);
        if (class_isMetaClass(clazz)) {
            unsigned int outCount;
            Method *methods = class_copyMethodList(clazz, &outCount);
            for (unsigned int i = 0; i < outCount; ++i) {
                SEL selector = method_getName(methods[i]);
                NSString *name = NSStringFromSelector(selector);
                NSLog(@"%@", name);
            }
        }
    }
    
    NSLog(@"\n\n🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲\n");

    {
        unsigned int outCount;
        Protocol * __unsafe_unretained _Nonnull *protocols = class_copyProtocolList([Person class], &outCount);
        for (unsigned int i = 0; i < outCount; ++i) {
            const char *cName = protocol_getName(protocols[i]);
            NSString *name = [NSString stringWithUTF8String:cName];
            NSLog(@"%@", name);
        }
    }
    
    NSLog(@"\n\n🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲\n");
    
    {
        const char *cName = class_getImageName([Person class]);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSLog(@"%@", name);
    }
    
    NSLog(@"\n\n🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲\n");
    
    {
        const char *cName = class_getName([Person class]);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSLog(@"%@", name);
    }
    
    NSLog(@"\n\n🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲🎲\n");
    
    {
        int version = class_getVersion([Person class]);
        NSLog(@"%d", version);
        
        size_t instanceSize = class_getInstanceSize([Person class]);
        NSLog(@"%zu", instanceSize);
    }
    
    @try {
        Ivar ivar = class_getInstanceVariable([Person class], "name");
        NSLog(@"%@", [NSString stringWithUTF8String:ivar_getName(ivar)]);
    }@catch (NSException *e) {
        NSLog(@"%@", e);
    }
    
    Person *p = [Person new];
    p->_pet = [Pet new];
    [p setValue:@"哈士奇" forKeyPath:@"_pet._nickName"];
    
    NSLog(@"%@", p->_pet.nickName);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
