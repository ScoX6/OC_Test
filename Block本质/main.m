//
//  main.m
//  Block本质
//
//  Created by 熊智凡 on 2018/10/13.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface Person : NSObject

@property (nonatomic, assign) NSInteger age;

@end

@implementation Person

- (void)dealloc {
    NSLog(@"Person has destroy");
}

@end

struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
};

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

// 模仿系统的__main_block_impl_0结构体
struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0 *Desc;
    int age;
};

int c = 10;
static int d = 11;


int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        int age = 10;
        void(^block)(int, int) = ^(int a, int b) {
            NSLog(@"this is block a = %d, b = %d", a, b);
            NSLog(@"this is block age = %d", age);
        };
        
        NSLog(@"%@", [block class]);
        NSLog(@"%@", [[block class] superclass]);
        NSLog(@"%@", [[[block class] superclass] superclass]);
        NSLog(@"%@", [[[[block class] superclass] superclass] superclass]);
        
        struct __main_block_impl_0 *blockStruct = (__bridge struct __main_block_impl_0 *)block;
        
        block(3,5);
        
        int a = 10;
        static int b = 20;
        void(^block2)(void) = ^{
            NSLog(@"hello, a = %d, b = %d", a,b);
        };
        a = 1;
        b = 2;
        block2();
        
        void(^block3)(void) = ^{
            NSLog(@"hello, c = %d, d = %d", c,d);
        };
        c = 1;
        d = 2;
        block3();
        
        
        Person *person = [Person new];
        person.age = 10;
        __weak Person *weakPerson = person;
        void(^catchWeakObjectBlock)(void) = ^{
            NSLog(@"catch weak person，age = %ld", weakPerson.age);
        };
        catchWeakObjectBlock();
        
        void(^catchStrongObjectBlock)(void) = ^{
            NSLog(@"catch strong person, age = %ld", person.age);
        };
        catchStrongObjectBlock();
        
        
        __block int catchAge = 10;
        void(^catchAutoBlock)(void) = ^{
            catchAge = 20;
        };
        catchAutoBlock();
        NSLog(@"after catch age = %d", catchAge);
        
        __block Person *catchPerson = [Person new];
        catchPerson.age = 20;
        void(^catchAutoObjectBlock)(void) = ^{
            catchPerson.age = 30;
            NSLog(@"catch auto Person, age = %ld", (long)catchPerson.age);
        };
        catchAutoObjectBlock();
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
