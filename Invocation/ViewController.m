//
//  ViewController.m
//  Invocation
//
//  Created by 熊智凡 on 2018/10/13.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import <ReactiveObjC.h>
#import <MGMediaFramework/MGMediaFactory.h>

//static id invokeBlock(id block, NSArray *args) {
//
//    id __unsafe_unretained result = nil;
//
//    while (YES) {
//
//        if (block == nil) break;
//
//        id target = [block copy];
//
//        const char* _Block_Signature(void *);
//        const char *signature = _Block_Signature((__bridge void *)(target));
//
//        NSMethodSignature *methodSignature = [NSMethodSignature signatureWithObjCTypes:signature];
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
//        invocation.target = target;
//
//
//
//        break;
//    }
//    return result;
//}

@interface ViewController ()

@property (nonatomic, strong) id<MGMediaPlayer> player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.yellowColor;
    
    UIViewController *vc = [[UITableViewController  alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:vc];
    [self didMoveToParentViewController:vc];
    [self.view insertSubview:vc.view atIndex:1];

    vc.view.frame = CGRectMake(0, 100, self.view.bounds.size.width, 200);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.player setCurrentPlaybackTime:600];
}

- (void)test {
    //    [self method_invocation_02];
    
    NSString *result = [self method_invocation_01];
    NSLog(@"%@", result);
    
    NSString *result2 = [self performSelector:@selector(convertString:) withArguments:@[@"Jack"]];
    NSLog(@"%@", result2);
    
    //    [self performSelector:@selector(excute:) withArguments:@[@"Jack"]];
    
    id excute = ^{
        NSLog(@"test block signature");
    };
    
    NSLog(@"");
}

- (NSString *)method_invocation_01 {
    
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(convertString:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = @selector(convertString:);
    
    NSString *param = @"name";
    [invocation setArgument:&param atIndex:2];
    
    [invocation invoke];
    
    id __unsafe_unretained returnResult = nil;
    if (strcmp(signature.methodReturnType, "@") == 0) {
        [invocation getReturnValue:&returnResult];
    }
    
    return returnResult;
}

- (void)method_invocation_02 {
    
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(excute:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = @selector(excute:);
    invocation.target = self;
    NSString *arg1 = @"Tom";
    [invocation setArgument:&arg1 atIndex:2];
    
    [invocation invoke];
    
}

- (id)performSelector:(SEL)aSelector withArguments:(NSArray *)args {

    id __unsafe_unretained result = nil;
    
    while (YES) {
        if (aSelector == nil) break;
        
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
        
        if (signature == nil) break;
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = self;
        invocation.selector = aSelector;
        
        NSInteger count = MIN(args.count, signature.numberOfArguments - 2);
        for (NSInteger i = 0; i < count; ++i) {
            const char *argCType = [signature getArgumentTypeAtIndex:i+2];
            if (strcmp(argCType, "@") == 0) {
                id arg = args[i];
                [invocation setArgument:&arg atIndex:i+2];
            }
        }
        
        [invocation invoke];
        
        if (strcmp(signature.methodReturnType, "@") == 0) {
            [invocation getReturnValue:&result];
        }
        
        break;
    }
    
    return result;
}

- (void)excute:(NSString *)firstArg, ... NS_REQUIRES_NIL_TERMINATION {
    // requires, nil, termination
    if (firstArg) {
        NSLog(@"%@", firstArg);
        
        va_list args;
        
        NSString *arg;
        
        va_start(args, firstArg);
        
        while ((arg = va_arg(args, NSString *))) {
            NSLog(@"%@", arg);
        }
        
        va_end(args);
    }
}

- (NSString *)convertString:(NSString *)content {
    return [NSString stringWithFormat:@"%@ - appending", content];
}


@end
