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

- (void)testDescription {
    XCTAssertNotNil([self.array description]);
    XCTAssert([[self.array description] isEqualToString:[self.sampleArray description]]);
}

- (void)testMultiThreading {

    static const NSUInteger DISPATCH_QUEUE_COUNT = 1000;
    static const NSUInteger ITERATION_COUNT      = 100;
    __weak typeof(self) weakSelf                 = self;

    for (NSUInteger i = 0; i < ITERATION_COUNT; i++) {
        @autoreleasepool {

            self.array = [JKLThreadSafeMutableArray array];

            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

            dispatch_apply(DISPATCH_QUEUE_COUNT, queue, ^(size_t i) {
                __strong typeof(self) strongSelf = weakSelf;

                [strongSelf.array addObject:@(i)];
                NSUInteger n = strongSelf.array.count;
                n++;
            });
        }

        XCTAssertEqual(DISPATCH_QUEUE_COUNT, self.array.count);
    }
}

- (void)testCopy {
    NSDictionary *dic = [self.array copy];

    XCTAssert([dic isKindOfClass:[NSArray class]]);

    for (int i = 0; i < self.array.count; ++i) {
        XCTAssert([self.array[i] isEqualToString:self.sampleArray[i]]);
    }
}

- (void)testMutableCopy {
    JKLThreadSafeMutableArray *dic = [self.array mutableCopy];

    XCTAssert([dic isKindOfClass:[NSMutableArray class]]);
    for (int i = 0; i < self.array.count; ++i) {
        XCTAssert([self.array[i] isEqualToString:self.sampleArray[i]]);
    }
}

- (void)testArchiveUnarchive {
    NSData                         *data          = [NSKeyedArchiver archivedDataWithRootObject:self.array];
    JKLThreadSafeMutableArray *unarchivedDic = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    XCTAssert([unarchivedDic isKindOfClass:[JKLThreadSafeMutableArray class]]);
    for (int i = 0; i < self.array.count; ++i) {
        XCTAssert([self.array[i] isEqualToString:self.sampleArray[i]]);
    }
}

@end
