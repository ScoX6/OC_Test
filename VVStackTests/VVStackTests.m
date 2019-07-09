//
//  VVStackTests.m
//  VVStackTests
//
//  Created by 熊智凡 on 2019/5/6.
//  Copyright © 2019 Scorpio.X. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VVStack.h"

@interface VVStackTests : XCTestCase

@end

@implementation VVStackTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testStackExist {
    XCTAssertNotNil([VVStack class], @"VVStack class should exist.");
}

- (void)testStackObjectCanBeCreated {
    VVStack *stack = [VVStack new];
    XCTAssertNotNil(stack, @"VVStack object can be created");
}

- (void)testPushANumberAndGetIt {
    VVStack *stack = [VVStack new];
    [stack push:4.6];
    double topNumber = [stack top];
    XCTAssertEqual(topNumber, 4.6, @"VVStack should can be pushed and has that top value.");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
