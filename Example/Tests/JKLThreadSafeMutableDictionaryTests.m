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
@property(nonatomic, copy) NSSortDescriptor *sort;

@end

@implementation JKLThreadSafeMutableDictionaryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.sort = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];

    self.sampleValues     = @[@"value1", @"value2", @"valueSame", @"valueSame"];
    self.sampleKeys       = @[@"key1", @"key2", @"key3", @"key4"];
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

- (void)testDictionaryWithObjectForKey {
    self.dic = [JKLThreadSafeMutableDictionary dictionaryWithObject:self.sampleValues.firstObject
                                                             forKey:self.sampleKeys.firstObject];
    XCTAssertNotNil(self.dic);
    XCTAssertEqual(self.dic.count, 1);
    XCTAssert([self.sampleDictionary[self.sampleKeys.firstObject] isEqualToString:self.dic[self.sampleKeys.firstObject]]);
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

- (void)testInitWithObjectForKey {
    self.dic = [[JKLThreadSafeMutableDictionary alloc] initWithObject:self.sampleValues.firstObject
                                                             forKey:self.sampleKeys.firstObject];
    XCTAssertNotNil(self.dic);
    XCTAssertEqual(self.dic.count, 1);
    XCTAssert([self.sampleDictionary[self.sampleKeys.firstObject] isEqualToString:self.dic[self.sampleKeys.firstObject]]);
}

- (void)testInitWithDictionaryCopyItems {
    self.dic = [[JKLThreadSafeMutableDictionary alloc] initWithDictionary:self.sampleDictionary copyItems:YES];
    
    XCTAssertNotNil(self.dic);
    XCTAssertEqual(self.dic.count, self.sampleDictionary.count);
    for (id <NSCopying> key in self.sampleDictionary.allKeys) {
        XCTAssert([self.sampleDictionary[key] isEqualToString:self.dic[key]]);
    }
}

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

- (void)testAllKeys {
    NSArray * allKeys = [self.dic allKeys];

    XCTAssertEqual(allKeys.count, self.dic.count);
    XCTAssertEqual(allKeys.count, self.sampleKeys.count);
    for (id <NSCopying> key in allKeys) {
        XCTAssertNotNil(self.dic[key]);
    }
}

- (void)testAllKeysForObject {
    NSArray * allKeys = [self.dic allKeysForObject:self.sampleValues.lastObject];
    NSArray * sampleAllKeys = [self.sampleDictionary allKeysForObject:self.sampleValues.lastObject];

    XCTAssertEqual(allKeys.count, sampleAllKeys.count);
    for (id <NSCopying> key in allKeys) {
        XCTAssert([self.sampleDictionary[key] isEqualToString:self.dic[key]]);
    }
}

- (void)testAllValues {
    NSArray * allValues = [[self.dic allValues] sortedArrayUsingDescriptors:@[self.sort]];

    XCTAssertEqual(allValues.count, self.sampleValues.count);
    XCTAssertEqual(allValues.count, self.dic.count);
    for (int i = 0; i < allValues.count; ++i) {
        XCTAssert([self.sampleValues[i] isEqualToString:allValues[i]]);
    }
}

- (void)testDescription {
    XCTAssertNotNil([self.dic description]);
    XCTAssert([[self.dic description] isEqualToString:[self.sampleDictionary description]]);
}

- (void)testDescriptionInStringsFileFormat {
    XCTAssertNotNil([self.dic descriptionInStringsFileFormat]);
    XCTAssert([[self.sampleDictionary descriptionInStringsFileFormat] isEqualToString:[self.dic descriptionInStringsFileFormat]]);
}

- (void)testDescriptionWithLocale {
    NSString * desc =  [self.dic descriptionWithLocale:[NSLocale systemLocale]];
    XCTAssertNotNil(desc);
    XCTAssert([[self.sampleDictionary descriptionWithLocale:[NSLocale systemLocale]] isEqualToString:desc]);
}

- (void)testDescriptionWithLocaleIndent {
    static NSUInteger level = 1;
    NSString * desc =  [self.dic descriptionWithLocale:[NSLocale systemLocale] indent:level];
    XCTAssertNotNil(desc);
    XCTAssert([[self.sampleDictionary descriptionWithLocale:[NSLocale systemLocale] indent:level] isEqualToString:desc]);
}

- (void)testIsEqualToDictionary {
    XCTAssert([self.dic isEqualToDictionary:self.sampleDictionary]);
}

- (void)testObjectEnumerator {
    NSEnumerator *enumerator = [self.dic objectEnumerator];
    id           value         = nil;
    while ((value = [enumerator nextObject]) != nil) {
        BOOL isFound = NO;
        for(id sampleValue in [self.sampleDictionary allValues])
        {
            if([sampleValue isEqualToString:value])
            {
                isFound = YES;
            }
        }
        XCTAssert(isFound);
    }
}

//TODO: More test cases

//TODO: normal creation, each method, encode/decode, fromJSON/toJSON, subscript, enumeration, copy/mutablecopy, multithreading

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
