//
//  JKLThreadSafeMutableArrayTests.m
//  JKLThreadSafeMutableCollection
//
//  Created by Jacky on 29/12/2015.
//  Copyright © 2015 jiakai lian. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <JKLThreadSafeMutableCollection/JKLThreadSafeMutableArray.h>

@interface JKLThreadSafeMutableArrayTests : XCTestCase
@property(nonatomic, strong) JKLThreadSafeMutableArray *array;
@property(nonatomic, copy) NSArray                     *sampleArray;
@end

@implementation JKLThreadSafeMutableArrayTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    self.sampleArray = @[@"item1", @"item2", @"item3", @"item4"];

    self.array = [JKLThreadSafeMutableArray arrayWithArray:self.sampleArray];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.array       = nil;
    self.sampleArray = nil;

    [super tearDown];
}

- (void)testArray {
    self.array = [JKLThreadSafeMutableArray array];

    XCTAssertNotNil(self.array);
}

- (void)testArrayWithCapacity {
    self.array = [JKLThreadSafeMutableArray arrayWithCapacity:self.sampleArray.count];
    XCTAssertNotNil(self.array);
}

- (void)testArrayWithObject {
    self.array = [JKLThreadSafeMutableArray arrayWithObject:self.sampleArray.firstObject];

    XCTAssertNotNil(self.array);
    XCTAssert(self.array.count == 1);
    XCTAssert([self.array.firstObject isEqualToString:self.sampleArray.firstObject]);
}

- (void)testArrayWithArray {
    self.array = [JKLThreadSafeMutableArray arrayWithArray:self.sampleArray];

    XCTAssertNotNil(self.array);
    XCTAssert(self.array.count == self.sampleArray.count);

    for (int i = 0; i < self.array.count; ++i) {
        XCTAssert([self.array[i] isEqualToString:self.sampleArray[i]]);
    }
}

- (void)testInit {
    self.array = [[JKLThreadSafeMutableArray alloc] init];

    XCTAssertNotNil(self.array);
}

- (void)testInitWithCapacity {
    self.array = [[JKLThreadSafeMutableArray alloc] initWithCapacity:self.sampleArray.count];
    XCTAssertNotNil(self.array);
}

- (void)testInitWithArray {
    self.array = [[JKLThreadSafeMutableArray alloc] initWithArray:self.sampleArray];

    XCTAssertNotNil(self.array);
    XCTAssert(self.array.count == self.sampleArray.count);

    for (int i = 0; i < self.array.count; ++i) {
        XCTAssert([self.array[i] isEqualToString:self.sampleArray[i]]);
    }
}

@end
