//
//  ViewController.m
//  Undo_Rodo
//
//  Created by 熊智凡 on 2018/10/18.
//  Copyright © 2018 Scorpio.X. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSUndoManager *undoManager = [[NSUndoManager alloc] init];
    [undoManager registerUndoWithTarget:self handler:^(id  _Nonnull target) {
        
    }];
    
    


}


@end
