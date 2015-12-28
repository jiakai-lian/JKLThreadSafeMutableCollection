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
@property (nonatomic, strong) JKLThreadSafeMutableDictionary * dic;
@property (nonatomic, copy) NSDictionary * sampleDictionary;
@end

@implementation JKLThreadSafeMutableDictionaryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.dic = [JKLThreadSafeMutableDictionary dictionary];
    self.sampleDictionary = @{@"key1":@"value1",@"key2":@"value2",@"key3":@"value3"};
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.dic = nil;
}

- (void)testDictionary {
    self.dic = [JKLThreadSafeMutableDictionary dictionary];
    XCTAssertNotNil(self.dic);
}

- (void)testDictionaryWithCapacity{
    self.dic = [JKLThreadSafeMutableDictionary dictionaryWithCapacity:5];
    XCTAssertNotNil(self.dic);
}

- (void)testDictionaryWithDictionary{
    self.dic = [JKLThreadSafeMutableDictionary dictionaryWithDictionary:self.sampleDictionary];
    XCTAssertNotNil(self.dic);
    XCTAssertEqual(self.dic.count,self.sampleDictionary.count);
    
    for(id<NSCopying> key in self.sampleDictionary.allKeys)
    {
        XCTAssert([self.sampleDictionary[key] isEqualToString:self.dic[key]]);
    }
}


- (void)testInit {
    self.dic = [[JKLThreadSafeMutableDictionary alloc] init];
    XCTAssertNotNil(self.dic);
}

- (void)testInitWithCapacity{
    self.dic = [[JKLThreadSafeMutableDictionary alloc] initWithCapacity:5];
    XCTAssertNotNil(self.dic);
}

- (void)testInitWithDictionary{
    self.dic = [[JKLThreadSafeMutableDictionary alloc] initWithDictionary:self.sampleDictionary];
    XCTAssertNotNil(self.dic);
    XCTAssertEqual(self.dic.count,self.sampleDictionary.count);
    
    for(id<NSCopying> key in self.sampleDictionary.allKeys)
    {
        XCTAssert([self.sampleDictionary[key] isEqualToString:self.dic[key]]);
    }
}

//TODO: normal creation, each method, encode/decode, fromJSON/toJSON, subscript, enumeration, copy/mutablecopy, multithreading

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
