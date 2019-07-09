//
//  ViewController.m
//  Define
//
//  Created by 熊智凡 on 2019/7/2.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "ViewController.h"

#define SWAP_INT(a,b) do \
{\
int tmp = a;\
a = b;\
b = tmp;\
}while(0)\

#define TEST_1(a) @#a

#define PropertyPrefix(x) sx_##x

#define myprintf(tempit, ...) fprintf(stder,templt,__VA_ARGS__)

#define debug(...) printf(__VA_ARGS__)

#define MY_DEBUG(format,...) printf(format,##__VA_ARGS__)

#define MY_MALLOC(type,n) (type *)malloc(n * sizeof(type))

#define NEW_TEST(p1,format,...) printf(format,p1,##__VA_ARGS__)

//#define SWAP(a,b) do \
//{\
//decltype(a) tmp = a;\
//a = b;\
//b = tmp;\
//}while(0)

#define MY_MIN(a,b) ((a) < (b) ? (a) : (b))

#define SKIP_SPACES(p, limit)  \
{ char *lim = (limit);         \
while (p < lim) {            \
if (*p++ != ' ') {         \
p--; break; }}}

#define SKIP_SPACES_2(p,limit) \
do {\
char *lim = (limit);\
while (p < lim) {\
if(*p++ != ' ') {\
p--; break; }}\
}while(0)

#define SX_MIN_1(a,b) ((a) < (b) ? (a) : (b))

#define SX_MIN_2(A,B) ({ __typeof__(A) __a =  (A); __typeof__(B) __b = (B); __a < __b ? __a : __b; })

#define __SX_PASTE__(A,B) A##B
#define SX_MIN_3(A,B) __SXMIN_IMPL__(A,B,__COUNTER__)
#define __SXMIN_IMPL__(A,B,L) ({ __typeof__(A) __SX_PASTE__(__a,L) = (A); \
__typeof__(B) __NSX_PASTE__(__b,L) = (B); \
(__SX_PASTE__(__a,L) < __SX_PASTE__(__b,L)) ? __SX_PASTE__(__a,L) : __SX_PASTE__(__b,L); \
})

@interface ViewController ()

@end

@implementation ViewController

void simple_va_fun(int i, ...) {
    va_list arg_ptr;
    int j=0;
    va_start(arg_ptr, i);
    j=va_arg(arg_ptr, int);
    va_end(arg_ptr);
    printf("%d %d\n", i, j);
    return;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"sdlfkjslkfjsdlkf %@", @"sdfsdjflskdjfsdlkf");
    
    int a = 1, b = 2;
    SX_MIN_3(a++, b++);
    
    NSLog(@"");
    
//    int min = SX_MIN(a++, b++);
//    NSLog(@"min is: %d, a: %d, b: %d", min, a, b);
//    int min = SX_MIN_2(a++, b++);
    int min = MIN(a++, b++);
    NSLog(@"min is: %d, a: %d, b: %d", min, a, b);

//    char *p_0;
//    if (*p_0 != 0)
//        SKIP_SPACES_2(p_0, p_0);
//    else {
//
//    }
    
    NSInteger result = MY_MIN(100+200, 300*2);
    NSLog(@"result: %ld", (long)result);
    
    int x = 3, y = 4;
    SWAP_INT(x, y);
    NSLog(@"%d - %d", x , y);
    
    NSLog(@"%@", TEST_1(123));
    
    NSString *PropertyPrefix(name) = @"name";
    NSLog(@"%@", sx_name);
    
    debug("牛逼了%s", "---------- 喝O(∩_∩)O哈！");
    
    MY_DEBUG("sdfsfds");
    
    int *p = MY_MALLOC(int, 5);
    int i = 0;
    for (i=0;i<5;i++) {
        p[i] = i+1;
        printf("%d\n", p[i]);
    }
    free(p);
    
    NEW_TEST("Tom", "%s - %s", "Suffix");
}


@end
