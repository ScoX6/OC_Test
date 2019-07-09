//
//  ViewController.m
//  OC_Test
//
//  Created by Sco.X on 2018/8/24.
//  Copyright © 2018年 Scorpio.X. All rights reserved.
//

#import "ViewController.h"
#import "MyObject.h"
#import "NSObject+SX_KVO.h"
#import "ViewController+Test.h"

#import <objc/runtime.h>
#import <objc/message.h>

void IntegerVarArgFunc(int i, ...) {
    va_list pArgs;
    va_start(pArgs, i);
    int j = va_arg(pArgs, int);
    va_end(pArgs);
    printf("i = %d, j = %d\n", i, j);
}

void ParseVarArgByNum(int dwArgNum, ...) {
    va_list pArgs;
    va_start(pArgs, dwArgNum);
    int dwArgIdx;
    int dwArgVal = 0;
    for (dwArgIdx = 1; dwArgIdx <= dwArgNum; dwArgIdx++) {
        dwArgVal = va_arg(pArgs, int);
        printf("The %dth Argument: %d\n", dwArgIdx, dwArgVal);
    }
    va_end(pArgs);
}

void ParseVarArgByEnd(int dwStart, ...) {
    va_list pArgs;
    va_start(pArgs, dwStart);
    int dwArgIdx = 0;
    int dwArgVal = dwStart;
    while (dwArgVal != -1) {
        ++dwArgIdx;
        printf("The %dth Argument: %d\n", dwArgIdx, dwArgVal);
        dwArgVal = va_arg(pArgs, int);
    }
    va_end(pArgs);
}

typedef enum {
    CHAR_TYPE = 1,
    INT_TYPE,
    LONG_TYPE,
    FLOAT_TYPE,
    DOUBLE_TYPE,
    STR_TYPE
}E_VAR_TYPE;

void ParseVarArgType(int dwArgNum, ...) {
    va_list pArgs;
    va_start(pArgs, dwArgNum);
    
    int i = 0;
    for (i = 0; i < dwArgNum; i ++) {
        E_VAR_TYPE eArgType = va_arg(pArgs, int);
        switch (eArgType) {
            case INT_TYPE:
                printf("The %dth Argument: %d\n", i+1, va_arg(pArgs, int));
                break;
            case STR_TYPE:
                printf("The %dth Argument: %s\n", i+1, va_arg(pArgs, char *));
                break;
            default:
                break;
        }
    }
    va_end(pArgs);
}

char *MyItoa(int iValue, char *pszResBuf, unsigned int uiRadix) {
    if (NULL == pszResBuf) {
        return "Nil";
    }
    if ((uiRadix < 2) || (uiRadix > 36)) {
        *pszResBuf = '\0';
        return pszResBuf;
    }
    
    char *pStr = pszResBuf;
    char *pFirstDig = pszResBuf;
    if ((10 == uiRadix) && (iValue < 0)) {
        iValue = (unsigned int)-iValue;
        *pStr++ = '-';
        pFirstDig++;
    }
    
    int iTmpValue = 0;
    do {
        iTmpValue = iValue;
        iValue /= uiRadix;
        *pStr++ = "0123456789abcdefghijklmnopqrstuvwxyz"[iTmpValue - iValue * uiRadix];
    }while (iValue);
    
    *pStr-- = '\0';
    
    while (pFirstDig < pStr) {
        char cTmpChar = *pStr;
        *pStr-- = *pFirstDig;
        *pFirstDig++ = cTmpChar;
    }
    
    return pszResBuf;
}

void MyPrintf(const char *pszFmt, ...) {
    va_list pArgs;
    va_start(pArgs, pszFmt);
    for (; *pszFmt != '\0'; ++pszFmt) {
        
        // 若不是控制字符则原样输出字符
        if (*pszFmt != '%') {
            putchar(*pszFmt);
            continue;
        }
        
        switch (*++pszFmt) {
            case '%': // 连续两个'%'输出单个'%'
                putchar('%');
                break;
            case 'd': // 按整型输出
                printf("%d",va_arg(pArgs, int));
                break;
            case 'c': // 按字符输出
                printf("%c",va_arg(pArgs, int));
                break;
            case 'b': // 按二进制输出
            {
                char aucStr[sizeof(int)*8+1] = {0};
                fputs(MyItoa(va_arg(pArgs, int), aucStr, 2), stdout);
            }
            default:
                vprintf(--pszFmt, pArgs);
                return;
        }
    }
    va_end(pArgs);
}

#define VAR_ARG_MAX_NUM (unsigned char)10
#define VAR_ARG_MAX_LEN (unsigned char)20

typedef struct {
    E_VAR_TYPE eArgType;
    unsigned char aucArgVal[VAR_ARG_MAX_LEN];
}VAR_ARGE_NTRY;

typedef struct {
    unsigned char ucArgNum;
    VAR_ARGE_NTRY aucVarArg[VAR_ARG_MAX_NUM];
}VAR_ARG_LIST;

void ParseStructArrayArg(VAR_ARG_LIST *ptVarArgList) {
    int i = 0;
    for (i=0; i < ptVarArgList->ucArgNum; ++i) {
        E_VAR_TYPE eArgType = ptVarArgList->aucVarArg[i].eArgType;
        switch (eArgType) {
            case CHAR_TYPE:
                printf("The %dth Argument: %c\n", i+1, ptVarArgList->aucVarArg[i].aucArgVal[0]);
                break;
            case STR_TYPE:
                printf("The %dth Argument: %s\n", i+1, ptVarArgList->aucVarArg[i].aucArgVal);
                break;
            default:
                break;
        }
    }
}

int DummyFunc(void){
    printf("Here!!!\n");
    return 0;
}

void ParseFuncPtrVarArg(int i, ...) {
    va_list pArgs;
    va_start(pArgs, i);
    char *sVal = va_arg(pArgs, char *);
    va_end(pArgs);
    printf("%d %s ", i, sVal);
    
    int (*pf)(void) = va_arg(pArgs, int(*)(void));
    pf();
}

@interface ViewController ()

@property (nonatomic, strong) MyObject *myObj_1;

@property (nonatomic, strong) MyObject *myObj_2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test02];
    
//    [MyObject todoSomething];
    [[MyObject new] performSelector:@selector(todoSomething) withObject:nil];
    
    Class cls1 = [self class];
    if (class_isMetaClass(cls1)) {
        NSLog(@"[self class] 是元类");
    }else {
        NSLog(@"[self class] 不是元类");
    }
    
    Class cls2 = [[self class] class];
    if (class_isMetaClass(cls2)) {
        NSLog(@"[[self class] class] 是元类");
    }else {
        NSLog(@"[[self class] class] 不是元类");
    }
    
    Class cls3 = object_getClass(self);
    if (class_isMetaClass(cls3)) {
        NSLog(@"object_getClass(self) 是元类");
    }else {
        NSLog(@"objct_getClass(self) 不是元类");
    }
    
    Class cls4 = object_getClass(cls1);
    if (class_isMetaClass(cls4)) {
        NSLog(@"object_getClass([self class]) 是元类");
    }else {
        NSLog(@"objct_getClass([self class]) 不是元类");
    }
    
    Class cls5 = object_getClass(cls2);
    if (class_isMetaClass(cls5)) {
        NSLog(@"object_getClass([self class] class]) 是元类");
    }else {
        NSLog(@"objct_getClass([self class] class]) 不是元类");
    }
    
    unsigned int outCount = 0;
    Method *methodList1 = class_copyMethodList(cls5, &outCount);
    for (int i = 0; i < outCount; ++i) {
        Method m = methodList1[i];
        SEL sel = method_getName(m);
        NSString *mName = NSStringFromSelector(sel);
        NSLog(@"%@", mName);
    }
    
    unsigned int outCount2 = 0;
    Ivar *ivarList1 = class_copyIvarList(cls3, &outCount2);
    for (int i = 0; i < outCount2; ++i) {
        Ivar ivar = ivarList1[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *pName = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
        NSLog(@"%@", pName);
    }
    
    
    
//    id obj = objc_msgSend(objc_getClass("NSObject"), sel_registerName("alloc"));
//    objc_msgSend(objc, sel_registerName("init"));
    
}

+ (void)classTestMethod {
    NSLog(@"=-=-=-=-=-=-=");
}

- (void)test02 {

//    IntegerVarArgFunc(10);
//    IntegerVarArgFunc(10,20);
    
//    ParseVarArgByNum(3,11,22,33);
    
//    ParseVarArgByEnd(44,55,-1);
    
//    ParseVarArgType(2,INT_TYPE,222,STR_TYPE,"Hello World!");
    
//    MyPrintf("Binary string of number %d is = %b!\n", 9999, 9999);
    
//    VAR_ARG_LIST tVarArgList = {2, {{CHAR_TYPE,{'H'}}, {STR_TYPE, "TEST"}}};
//    ParseStructArrayArg(&tVarArgList);
    
//    ParseFuncPtrVarArg(1, "Welcome", DummyFunc);
}

- (void)test01 {
    
    //    [self doSomething];
    
    SEL sel1 = NULL;
    SEL sel2 = NULL;
    
    int count = 0;
    
    unsigned int outCount;
    Method *m_list = class_copyMethodList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
        Method m = m_list[i];
        SEL sel = method_getName(m);
        NSString *selName = NSStringFromSelector(sel);
        NSLog(@"🥺 -> %@ --- %p", selName, sel);
        if ([selName containsString:@"thing"]) {
            if (count == 0) {
                sel1 = sel;
                count++;
            }else if (count == 1) {
                sel2 = sel;
            }
        }
    }
    
    
    NSMethodSignature *signature1 = [[self class] instanceMethodSignatureForSelector:sel1];
    NSInvocation *invocation1 = [NSInvocation invocationWithMethodSignature:signature1];
    invocation1.target = self;
    invocation1.selector = sel1;
    [invocation1 invoke];
    
    NSMethodSignature *signature2 = [[self class] instanceMethodSignatureForSelector:sel2];
    NSInvocation *invocation2 = [NSInvocation invocationWithMethodSignature:signature2];
    invocation2.target = self;
    invocation2.selector = sel2;
    [invocation2 invoke];
    
}

- (void)customKVOTest {
    self.myObj_1 = [[MyObject alloc] init];
    self.myObj_1.desc = @"我的对象";
    self.myObj_1.version = 1;
    
    self.myObj_2 = [[MyObject alloc] init];
    self.myObj_2.desc = @"我的对象";
    self.myObj_2.version = 1;
    
    NSLog(@"");
    
    [self.myObj_1 SX_addObserver:self forKey:@"desc" withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
        NSLog(@"");
    }];
    
    NSLog(@"");
    
    
    self.myObj_1.desc = @"new desc";
}

- (void)systemKVOTest {
    self.myObj_1 = [[MyObject alloc] init];
    self.myObj_1.desc = @"我的对象";
    self.myObj_1.version = 1;
    
    self.myObj_2 = [[MyObject alloc] init];
    self.myObj_2.desc = @"我的对象";
    self.myObj_2.version = 1;
    
    NSLog(@"添加KVO之前");
    NSLog(@"p1 = %p, p2 = %p", [self.myObj_1 methodForSelector:@selector(setVersion:)], [self.myObj_2 methodForSelector:@selector(setVersion:)]);
    
    [self.myObj_1 addObserver:self forKeyPath:@"version" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    NSLog(@"添加KVO之后");
    NSLog(@"p1 = %p, p2 = %p", [self.myObj_1 methodForSelector:@selector(setVersion:)], [self.myObj_2 methodForSelector:@selector(setVersion:)]);
    
    
    self.myObj_1.desc = @"new";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@ --- %@", keyPath, object);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doSomething {
    NSLog(@"inside doSomething");
}

@end
