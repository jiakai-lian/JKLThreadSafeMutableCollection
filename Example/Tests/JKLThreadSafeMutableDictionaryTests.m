//
//  JKLThreadSafeMutableDictionaryTests.m
//  JKLThreadSafeMutableCollection
//
//  Created by jiakai lian on 28/12/2015.
//  Copyright © 2015 jiakai lian. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <JKLThreadSafeMutableCollection/JKLThreadSafeMutableDictionary.h>

@interface JKLThreadSafeMutableDictionaryTests : XCTestCase
@property(nonatomic, strong) JKLThreadSafeMutableDictionary *dic;
@property(nonatomic, copy) NSDictionary                     *sampleDictionary;
@property(nonatomic, copy) NSArray                          *sampleValues;
@property(nonatomic, copy) NSArray                          *sampleKeys;
@end

@implementation JKLThreadSafeMutableDictionaryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    self.sampleValues     = @[@"value1", @"value2", @"value3"];
    self.sampleKeys       = @[@"key1", @"key2", @"key3"];
    self.sampleDictionary = [NSDictionary dictionaryWithObjects:self.sampleValues
                                                        forKeys:self.sampleKeys];
    self.dic              = [JKLThreadSafeMutableDictionary dictionaryWithDictionary:self.sampleDictionary];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    self.dic = nil;
}

#pragma mark - Initializer

- (void)testDictionary {
    self.dic = [JKLThreadSafeMutableDictionary dictionary];
    XCTAssertNotNil(self.dic);
}

- (void)testDictionaryWithCapacity {
    self.dic = [JKLThreadSafeMutableDictionary dictionaryWithCapacity:5];
    XCTAssertNotNil(self.dic);
}

- (void)testDictionaryWithDictionary {
    self.dic = [JKLThreadSafeMutableDictionary dictionaryWithDictionary:self.sampleDictionary];
    XCTAssertNotNil(self.dic);
    XCTAssertEqual(self.dic.count, self.sampleDictionary.count);

    for (id <NSCopying> key in self.sampleDictionary.allKeys) {
        XCTAssert([self.sampleDictionary[key] isEqualToString:self.dic[key]]);
    }
}

- (void)testDictionaryWithObjectsForKeys {
    self.dic = [JKLThreadSafeMutableDictionary dictionaryWithObjects:self.sampleValues
                                                             forKeys:self.sampleKeys];
    XCTAssertNotNil(self.dic);
    XCTAssertEqual(self.dic.count, self.sampleDictionary.count);
    for (id <NSCopying> key in self.sampleDictionary.allKeys) {
        XCTAssert([self.sampleDictionary[key] isEqualToString:self.dic[key]]);
    }
}

- (void)testInit {
    self.dic = [[JKLThreadSafeMutableDictionary alloc] init];
    XCTAssertNotNil(self.dic);
}

- (void)testInitWithCapacity {
    self.dic = [[JKLThreadSafeMutableDictionary alloc] initWithCapacity:5];
    XCTAssertNotNil(self.dic);
}

- (void)testInitWithDictionary {
    self.dic = [[JKLThreadSafeMutableDictionary alloc] initWithDictionary:self.sampleDictionary];
    XCTAssertNotNil(self.dic);
    XCTAssertEqual(self.dic.count, self.sampleDictionary.count);

    for (id <NSCopying> key in self.sampleDictionary.allKeys) {
        XCTAssert([self.sampleDictionary[key] isEqualToString:self.dic[key]]);
    }
}

- (void)testInitWithObjectsForKeys {
    self.dic = [[JKLThreadSafeMutableDictionary alloc] initWithObjects:self.sampleValues
                                                               forKeys:self.sampleKeys];
    XCTAssertNotNil(self.dic);
    XCTAssertEqual(self.dic.count, self.sampleDictionary.count);
    for (id <NSCopying> key in self.sampleDictionary.allKeys) {
        XCTAssert([self.sampleDictionary[key] isEqualToString:self.dic[key]]);
    }
}

//- (void) testCaseInitWithObjectsForKeysCount {
//    self.dic = [[JKLThreadSafeMutableDictionary alloc] initWithObjects:self.sampleValues
//                                                               forKeys:self.sampleKeys count:self.sampleKeys.count];
//    XCTAssertNotNil(self.dic);
//    XCTAssertEqual(self.dic.count, self.sampleDictionary.count);
//    for (id <NSCopying> key in self.sampleDictionary.allKeys) {
//        XCTAssert([self.sampleDictionary[key] isEqualToString:self.dic[key]]);
//    }
//}

- (void)testCount {
    XCTAssertEqual(self.dic.count, self.sampleDictionary.count);
}

- (void)testObjectForKey {
    for (id <NSCopying> key in self.sampleDictionary.allKeys) {
        XCTAssert([self.sampleDictionary[key] isEqualToString:[self.dic objectForKey:key]]);
    }
}

- (void)testSetObjectForKey {
    self.dic = [JKLThreadSafeMutableDictionary dictionary];

    for (id <NSCopying> key in self.sampleDictionary.allKeys) {
        [self.dic setObject:self.sampleDictionary[key]
                     forKey:key];
    }

    XCTAssertEqual(self.dic.count, self.sampleDictionary.count);
    for (id <NSCopying> key in self.sampleDictionary.allKeys) {
        XCTAssert([self.sampleDictionary[key] isEqualToString:[self.dic objectForKey:key]]);
    }
}

- (void)testObjectForKeyedSubscript {
    for (id <NSCopying> key in self.sampleDictionary.allKeys) {
        XCTAssert([self.sampleDictionary[key] isEqualToString:self.dic[key]]);
    }
}

- (void)testSetObjectForKeyedSubscript {
    self.dic = [JKLThreadSafeMutableDictionary dictionary];

    for (id <NSCopying> key in self.sampleDictionary.allKeys) {
        self.dic[key] = self.sampleDictionary[key];
    }

    XCTAssertEqual(self.dic.count, self.sampleDictionary.count);
    for (id <NSCopying> key in self.sampleDictionary.allKeys) {
        XCTAssert([self.sampleDictionary[key] isEqualToString:self.dic[key]]);
    }
}

- (void)testKeyEnumerator {
    NSEnumerator *enumerator = [self.dic keyEnumerator];
    id           key         = nil;
    while ((key = [enumerator nextObject]) != nil) {
        XCTAssert([self.sampleDictionary[key] isEqualToString:self.dic[key]]);
    }
}

- (void)testRemoveObjectForKey {
    [self.dic removeObjectForKey:self.sampleKeys.firstObject];

    sleep(1);//due to internal dispatch barrier async implementation, wait for a second then check the result

    XCTAssertNil(self.dic[self.sampleKeys.firstObject]);

}

//TODO: normal creation, each method, encode/decode, fromJSON/toJSON, subscript, enumeration, copy/mutablecopy, multithreading

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
