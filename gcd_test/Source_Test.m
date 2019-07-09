//
//  Source_Test.m
//  gcd_test
//
//  Created by 熊智凡 on 2018/12/23.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "Source_Test.h"

@interface Source_Test ()

@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, strong) dispatch_source_t file_source;

@end

@implementation Source_Test

- (void)dealloc {
    dispatch_source_cancel(self.timer);
    dispatch_source_cancel(self.file_source);
}

- (void)main {
    [self testTow];
}

- (void)testOne {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"🥺🥺🥺🥺🥺🥺🥺🥺🥺🥺🥺");
    });
    dispatch_resume(timer);
    self.timer = timer;
}

- (void)cancel {
    dispatch_source_cancel(self.timer);
}

- (void)testTow {
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSArray<NSString *> *subPaths =  [fileManager subpathsOfDirectoryAtPath:libraryDir error:nil];
//    NSString *path = subPaths.firstObject;
    NSString *path = libraryDir;
    
    int const fd = open([path fileSystemRepresentation], O_EVTONLY);
    if (fd < 0) {
        NSLog(@"Unable to open the path = %@", path);
        return;
    }
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE, fd, DISPATCH_VNODE_WRITE, DISPATCH_TARGET_QUEUE_DEFAULT);
    dispatch_source_set_event_handler(source, ^{
        unsigned long const type = dispatch_source_get_data(source);
        switch (type) {
            case DISPATCH_VNODE_WRITE:
            {
                NSLog(@"Document目录内容发生变化!!!");
            }break;
            default:
                break;
        }
    });
    dispatch_source_set_cancel_handler(source, ^{
        close(fd);
    });
    dispatch_resume(source);
    self.file_source = source;
}

- (void)testThree {
    
}

@end
