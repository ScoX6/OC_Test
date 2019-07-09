//
//  FourthViewController.m
//  Timer
//
//  Created by 熊智凡 on 2018/10/16.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1、创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 2、 创建timer添加到队列中
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 3、设置首次执行事件、执行间隔和精确度
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), (uint64_t)(2.f *NSEC_PER_SEC), 0);
    // 4、处理事件block
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"GCD Timer Excute");
    });
    // 5、激活事件
    dispatch_resume(timer);

    self.timer = timer;
    
//    dispatchTimer(self, 2.f, ^(dispatch_source_t timer) {
//        NSLog(@"lkfjsdlkfjslkd");
//    });
}

void dispatchTimer(id target, double timeInterval,void (^handler)(dispatch_source_t timer))
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer =dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), (uint64_t)(timeInterval *NSEC_PER_SEC), 0);
    // 设置回调
    __weak __typeof(target) weaktarget  = target;
    dispatch_source_set_event_handler(timer, ^{
        if (!weaktarget)  {
            dispatch_source_cancel(timer);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) handler(timer);
            });
        }
    });
    // 启动定时器
    dispatch_resume(timer);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)dealloc {
    dispatch_source_cancel(self.timer);
    NSLog(@"Fourth ViewController Destroy");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
