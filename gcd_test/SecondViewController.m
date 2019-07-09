//
//  SecondViewController.m
//  gcd_test
//
//  Created by 熊智凡 on 2019/1/18.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (nonatomic, copy) dispatch_block_t myBlock;

@property (nonatomic, strong) dispatch_semaphore_t semaphore_t;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    __weak typeof(self) weak_self = self;
    self.view.backgroundColor = [UIColor greenColor];
    dispatch_async(dispatch_queue_create("my queue", DISPATCH_QUEUE_CONCURRENT), ^{
        
        sleep(2.f);
    
        self.semaphore_t = dispatch_semaphore_create(0);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.f * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"dispatch wait %@ - %@", self.semaphore_t, self);

            dispatch_semaphore_wait(self.semaphore_t, DISPATCH_TIME_FOREVER);
            NSLog(@"dispatch wait %@ - %@", self.semaphore_t, self);
            
            self.myBlock = ^{
                NSLog(@"do something - %@", weak_self);
            };
            self.myBlock();
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.f * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            dispatch_semaphore_signal(self.semaphore_t);
            NSLog(@"dispatch single %@", self.semaphore_t);
        });
        
    });
    
}

- (void)dealloc {
    NSLog(@"SecondVC Dealloc");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.semaphore_t = nil;
    
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
