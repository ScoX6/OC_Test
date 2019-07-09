//
//  ViewController.m
//  Block本质
//
//  Created by 熊智凡 on 2018/10/13.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "ViewController.h"

int globalA = 10;
static int globalB = 20;

typedef void(^Block)(void);

struct __block_impl {
    void *isa;
    int Flags;
    int Reseved;
    void *FuncPtr;
};

struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(void);
    void (*dispose)(void);
};

struct __Block_byref_age_0 {
    void *__isa;
    struct __Block_byref_age_0 *__forwarding;
    int __flags;
    int __size;
    int age;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    struct __Block_byref_age_0 *age; // by ref
};

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block int age = 10;
    Block testBlock = ^{
        age = 20;
        NSLog(@"age is %d",age);
    };
    testBlock();
    struct __main_block_impl_0 *blockImpl = (__bridge struct __main_block_impl_0 *)testBlock;
    NSLog(@"%p",&age);

    void(^block)(void) = ^{
        NSLog(@"%p", self);
    };
    
    block();

    NSLog(@"%@", [block class]);
    
    void(^block2)(void) = ^{
        NSLog(@"block 2");
    };
    
    block2();
    
    NSLog(@"%@", [block2 class]);
    
    int a = 10;
    void(^block3)(void) = ^{
        NSLog(@"block3 a = %d", a);
    };
    
    block3();
    
    NSLog(@"%@", [block3 class]);
    
    
    int b = 10;
    NSLog(@"%@", [^{
        NSLog(@"temp block b = %d", b);
    } class]);
    

    NSLog(@"catch global %@", [^{
        NSLog(@"global A = %d, global B = %d", globalA, globalB);
    } class]);

}


@end
