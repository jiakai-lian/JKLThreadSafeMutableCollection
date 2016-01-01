//
//  JKLThreadSafeMutableSetTests.m
//  JKLThreadSafeMutableCollection
//
//  Created by Jacky on 1/01/2016.
//  Copyright © 2016 jiakai lian. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <JKLThreadSafeMutableCollection/JKLThreadSafeMutableSet.h>

@interface JKLThreadSafeMutableSetTests : XCTestCase
@property(nonatomic, strong) JKLThreadSafeMutableSet *set;
@property(nonatomic, copy) NSSet                     *sampleSet;
@property(nonatomic, copy) NSArray                     *sampleArray;
@end

@implementation JKLThreadSafeMutableSetTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.sampleArray = @[@"item1", @"item2", @"item3", @"item4"];
    self.sampleSet = [NSSet setWithArray:self.sampleArray];
    self.set = [JKLThreadSafeMutableSet setWithSet:self.sampleSet];
}

- (void)tearDown {
    self.set = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSet {
    self.set = [JKLThreadSafeMutableSet set];
    
    XCTAssertNotNil(self.set);
}

- (void)testSetWithCapacity {
    self.set = [JKLThreadSafeMutableSet setWithCapacity:self.sampleSet.count];
    XCTAssertNotNil(self.set);
}

- (void)testSetWithObject {
    self.set = [JKLThreadSafeMutableSet setWithObject:self.sampleArray.firstObject];
    
    XCTAssertNotNil(self.set);
    XCTAssert(self.set.count == 1);
    XCTAssert([self.set.allObjects.firstObject isEqualToString:self.sampleArray.firstObject]);
}

- (void)testSetWithArray {
    self.set = [JKLThreadSafeMutableSet setWithArray:self.sampleArray];
    
    XCTAssertNotNil(self.set);
    XCTAssert(self.set.count == self.sampleArray.count);
    
    for (id object in self.sampleArray) {
        XCTAssert([self.set containsObject:object]);
    }
}

- (void)testInit {
    self.set = [[JKLThreadSafeMutableSet alloc] init];
    
    XCTAssertNotNil(self.set);
}

- (void)testInitWithCapacity {
    self.set = [[JKLThreadSafeMutableSet alloc] initWithCapacity:self.sampleSet.count];
    XCTAssertNotNil(self.set);
}

- (void)testInitWithArray {
    self.set = [[JKLThreadSafeMutableSet alloc] initWithArray:self.sampleArray];
    
    XCTAssertNotNil(self.set);
    XCTAssert(self.set.count == self.sampleArray.count);
    
    for (id object in self.sampleArray) {
        XCTAssert([self.set containsObject:object]);
    }
}

- (void)testDescription {
    XCTAssertNotNil([self.set description]);
    XCTAssert([[self.set description] isEqualToString:[self.sampleSet description]]);
}

- (void)testMultiThreading {
    
    static const NSUInteger DISPATCH_QUEUE_COUNT = 1000;
    static const NSUInteger ITERATION_COUNT      = 100;
    __weak typeof(self) weakSelf                 = self;
    
    for (NSUInteger i = 0; i < ITERATION_COUNT; i++) {
        @autoreleasepool {
            
            self.set = [JKLThreadSafeMutableSet set];
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            dispatch_apply(DISPATCH_QUEUE_COUNT, queue, ^(size_t i) {
                __strong typeof(self) strongSelf = weakSelf;
                
                [strongSelf.set addObject:@(i)];
                NSUInteger n = strongSelf.set.count;
                n++;
            });
        }
        
        XCTAssertEqual(DISPATCH_QUEUE_COUNT, self.set.count);
    }
}

- (void)testCopy {
    NSSet *set = [self.set copy];
    
    XCTAssert([set isKindOfClass:[NSSet class]]);
    
    for (id object in self.sampleArray) {
        XCTAssert([self.set containsObject:object]);
    }
}

- (void)testMutableCopy {
    NSMutableSet *set = [self.set mutableCopy];
    
    XCTAssert([set isKindOfClass:[NSMutableSet class]]);
    for (id object in self.sampleArray) {
        XCTAssert([self.set containsObject:object]);
    }
}

- (void)testArchiveUnarchive {
    NSData                         *data          = [NSKeyedArchiver archivedDataWithRootObject:self.set];
    JKLThreadSafeMutableSet *unarchivedSet = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssert([unarchivedSet isKindOfClass:[JKLThreadSafeMutableSet class]]);
    for (id object in self.sampleArray) {
        XCTAssert([unarchivedSet containsObject:object]);
    }
}


@end
