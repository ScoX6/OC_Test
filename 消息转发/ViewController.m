//
//  ViewController.m
//  消息转发
//
//  Created by Sco.X on 2018/8/31.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "ViewController.h"

static id invokeBlock(id block, NSArray *arguments) {
    if (block == nil) return nil;
    id target = [block  copy];
    
    const char *_Block_signature(void *);
    const char *signature = _Block_signature((__bridge void *)target);
    
    NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:signature];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.target = target;
    
    // invocation 有1个隐藏参数，所以 argument 从1开始
    if ([arguments isKindOfClass:[NSArray class]]) {
        NSInteger count = MIN(arguments.count, methodSignature.numberOfArguments - 1);
        for (int i = 0; i < count; ++i) {
            const char *type = [methodSignature getArgumentTypeAtIndex:1 + i];
            NSString *typeStr = [NSString stringWithUTF8String:type];
            if ([typeStr containsString:@"\""]) {
                type = [typeStr substringToIndex:1].UTF8String;
            }
            
            // 需要做参数类型判断然后解析成对应类型，这里默认所有参数均为OC对象
            if (strcmp(type, "@") == 0) {
                id argument = arguments[i];
                [invocation setArgument:&argument atIndex:1 + i];
            }
        }
    }
    
    [invocation invoke];
    
    id returnVal;
    const char *type = methodSignature.methodReturnType;
    NSString *returnType = [NSString stringWithUTF8String:type];
    if ([returnType containsString:@"\""]) {
        type = [returnType substringToIndex:1].UTF8String;
    }
    if (strcmp(type, "@") == 0) {
        [invocation getReturnValue:&returnVal];
    }
    // 需要做返回类型判断。比如返回值为常量需要包装成对象，这里仅以最简单的`@`为例
    return returnVal;
}

@interface Receiver: NSObject

+ (void)sendClassMethod;

- (void)sendInstanceMethod;

@end

@implementation Receiver

+ (void)sendClassMethod {
    NSLog(@"转发者接收方法: %s", __func__);
}

- (void)sendInstanceMethod {
    NSLog(@"转发者接收方法: %s", __func__);
}

@end

@interface ViewController ()

@property (nonatomic, strong) Receiver *receiver;

- (void)implementationMethod;

+ (void)sendClassMethod;

- (void)sendInstanceMethod;

@end

@implementation ViewController

- (void)implementationMethod {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.receiver = [[Receiver alloc] init];

    [self implementationMethod];
    
//    [[self class] sendClassMethod];
    
    [self sendInstanceMethod];
    
    NSString *str = [self performSelector:@selector(connectString:string:string:) withArguments:@[@"a-", @"b-", @"c"]];
    NSLog(@"");
    
    id block = (id)^(NSString *a, NSString *b, NSString *c) {
        return [NSString stringWithFormat:@"%@%@%@", a, b, c];
    };
    NSString *result = invokeBlock(block, @[@"a-", @"b-", @"c"]);
    NSLog(@"");
}

- (NSString *)connectString:(NSString *)a string:(NSString *)b string:(NSString *)c {
    return [NSString stringWithFormat:@"%@%@%@", a, b, c];
}


- (id)performSelector:(SEL)aSelector withArguments:(NSArray *)arguments {
    
    if (aSelector == nil) return nil;
    
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    if ([arguments isKindOfClass:[NSArray class]]) {
        
        NSInteger count = MIN(arguments.count, signature.numberOfArguments - 2);
        for (int i = 0; i < count; ++i) {
            const char *type = [signature getArgumentTypeAtIndex:i + 2];
            if (strcmp(type, "@") == 0) {
                id argument = arguments[i];
                [invocation setArgument:&argument atIndex:i+2];
            }
        }
        
    }

    [invocation invoke];
    
    id returnVal;
    if (strcmp(signature.methodReturnType, "@") == 0) {
        [invocation getReturnValue:&returnVal];
    }
    return returnVal;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(sendClassMethod)) {
        return NO;
    }
    return YES;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(sendInstanceMethod)) {
        return NO;
    }
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
    return self.receiver;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [Receiver instanceMethodSignatureForSelector:aSelector];
    }
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"");
}

@end
