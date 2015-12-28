//
//  JKLThreadSafeMutableDictionary.h
//  Pods
//
//  Created by jiakai lian on 28/12/2015.
//
//

#import <Foundation/Foundation.h>

@interface JKLThreadSafeMutableDictionary : NSObject //<NSCopying, NSMutableCopying, NSSecureCoding>
//@interface JKLThreadSafeMutableDictionary: NSMutableDictionary

+ (instancetype) dictionary;
+ (instancetype) dictionaryWithCapacity:(NSUInteger)numItems;
+ (instancetype) dictionaryWithDictionary:(NSDictionary *)dict;

- (instancetype) init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCapacity:(NSUInteger)numItems;
- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;

#pragma mark - read operations
- (id)objectForKey:(id)aKey;
- (NSArray*)allValues;
- (NSArray*)allKeys;
- (NSUInteger)count;

- (id)objectForKeyedSubscript:(id<NSCopying>)key;

#pragma mark - write operations
- (void)setObject:(id)obj forKey:(id<NSCopying>)key;
- (void)removeObjectForKey:(id)key;
- (void)removeObjectsForKeys:(NSArray*)keys;
- (void)removeAllObjects;

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key;

@end
