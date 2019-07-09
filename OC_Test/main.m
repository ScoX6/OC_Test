//
//  main.m
//  OC_Test
//
//  Created by Sco.X on 2018/8/24.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/runtime.h>


struct Student_IMPL {
    Class isa;
    int _no;
    int _age;
};

@interface Student : NSObject {
    @public
    int _no;
    int _age;
}
@end
@implementation Student
@end

@interface ClassRoom : NSObject {
    @public
    Student *_student;
    int _count;
}
@end
@implementation ClassRoom
@end

@interface ExtensionClass: NSObject {
    int _extensionCode;
}
@end
@implementation ExtensionClass
@end

@interface SuperClass: NSObject {
    int _superCode;
}
@end
@implementation SuperClass
@end

@interface SubClass: SuperClass {
    int _subCode;
    ExtensionClass *_extension;
}

@property (nonatomic, copy) NSString *name;

@end
@implementation SubClass
@end

@interface NSObject (Test)

+ (void)todoSomething;

@end

@implementation NSObject (Test)

- (void)todoSomething {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
//        Student *stu = [[Student alloc] init];
//        stu->_no = 10;
//        stu->_age = 10;

//        struct Student_IMPL *stuImpl = (__bridge struct Student_IMPL *)stu;
//        NSLog(@"\n%p\n%p\n%p\n%p", stuImpl, stuImpl->isa, stuImpl->_no, stuImpl->_age);
//        NSLog(@"_no = %d, _age = %d", stuImpl->_no, stuImpl->_age); // 打印出 _no = 4, _age = 5
//
//
//        NSObject *obj1 = [[NSObject alloc] init];           // 0x604000001d20
//        NSObject *obj2 = [[NSObject alloc] init];           // 0x604000001d20
//
//        Class cls1 = [obj1 class];          // 0x104158ea8
//        Class cls2 = [obj2 class];          // 0x104158ea8
//        Class cls3 = [NSObject class];          // 0x104158ea8
//
//        Class cls4 = [[NSObject class] class];      // 0x104158ea8
//        Class cls5 = object_getClass(obj1);     // 0x104158ea8
//        Class cls6 = object_getClass(obj2);     // 0x104158ea8
//        Class cls7 = object_getClass(cls1);     // 0x104158e58      元类
//        Class cls8 = object_getClass(cls2);     // 0x104158e58      元类
//
//        NSLog(@"\n%p\n%p\n%p\n%p\n%p\n%p\n%p\n%p\n%p\n%p", obj1, obj2, cls1, cls2, cls3, cls4, cls5, cls6, cls7, cls8);

        [NSObject todoSomething];
        [[NSObject new] todoSomething];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
