//
//  JKLThreadSafeMutableDictionary.h
//  Pods
//
//  Created by jiakai lian on 28/12/2015.
//
//

#import <Foundation/Foundation.h>
#import "JKLThreadSafeMutableCollection.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKLThreadSafeMutableDictionary: JKLThreadSafeMutableCollection

- (NSUInteger)count;
- (nullable id)objectForKey:(id<NSCopying>)aKey;
- (NSEnumerator<id<NSCopying>> *)keyEnumerator;
- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (void)removeObjectForKey:(id<NSCopying>)aKey;
- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey;
- (instancetype)initWithCapacity:(NSUInteger)numItems;

@end

@interface JKLThreadSafeMutableDictionary (NSExtendedDictionary)

- (NSArray<id<NSCopying>> *)allKeys;
- (NSArray<id<NSCopying>> *)allKeysForObject:(id)anObject;
- (NSArray<id> *)allValues;
- (NSString *)description;
- (NSString *)descriptionInStringsFileFormat;
- (NSString *)descriptionWithLocale:(nullable id)locale;
- (NSString *)descriptionWithLocale:(nullable id)locale
                             indent:(NSUInteger)level;
- (BOOL)isEqualToDictionary:(NSDictionary<id<NSCopying>, id> *)otherDictionary;
- (NSEnumerator<id> *)objectEnumerator;
- (NSArray<id> *)objectsForKeys:(NSArray<id<NSCopying>> *)keys
                 notFoundMarker:(id)marker;
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
- (BOOL)writeToURL:(NSURL *)url
        atomically:(BOOL)atomically;  // the atomically flag is ignored if url
                                      // of a type that cannot be written
                                      // atomically.

- (NSArray<id<NSCopying>> *)keysSortedByValueUsingSelector:(SEL)comparator;
// count refers to the number of elements in the dictionary
- (void)getObjects:(id __unsafe_unretained[])objects
           andKeys:(id<NSCopying> __unsafe_unretained[])keys
             count:(NSUInteger)count NS_AVAILABLE(10_7, 5_0);

- (nullable id)objectForKeyedSubscript:(id<NSCopying>)key
    NS_AVAILABLE(10_8, 6_0);

- (NSArray<id<NSCopying>> *)keysSortedByValueUsingComparator:(NSComparator)cmptr
    NS_AVAILABLE(10_6, 4_0);
- (NSArray<id<NSCopying>> *)keysSortedByValueWithOptions:(NSSortOptions)opts
                                         usingComparator:(NSComparator)cmptr
    NS_AVAILABLE(10_6, 4_0);

- (NSSet<id<NSCopying>> *)keysOfEntriesPassingTest:
    (BOOL (^)(id<NSCopying> key, id obj, BOOL *stop))predicate
    NS_AVAILABLE(10_6, 4_0);
- (NSSet<id<NSCopying>> *)keysOfEntriesWithOptions:(NSEnumerationOptions)opts
                                       passingTest:
                                           (BOOL (^)(id<NSCopying> key, id obj,
                                                     BOOL *stop))predicate
    NS_AVAILABLE(10_6, 4_0);

@end

@interface JKLThreadSafeMutableDictionary (NSDictionaryCreation)

+ (instancetype)dictionary;
+ (instancetype)dictionaryWithObject:(id)object forKey:(id<NSCopying>)key;

+ (instancetype)dictionaryWithDictionary:
    (NSDictionary<id<NSCopying>, id> *)dict;
+ (instancetype)dictionaryWithObjects:(NSArray<id> *)objects
                              forKeys:(NSArray<id<NSCopying>> *)keys;

- (instancetype)initWithDictionary:
    (NSDictionary<id<NSCopying>, id> *)otherDictionary;
- (instancetype)initWithDictionary:
                    (NSDictionary<id<NSCopying>, id> *)otherDictionary
                         copyItems:(BOOL)flag;
- (instancetype)initWithObject:(id)object
                        forKey:(id<NSCopying>) key;
- (instancetype)initWithObjects:(NSArray<id> *)objects
                        forKeys:(NSArray<id<NSCopying>> *)keys;

@end

@interface JKLThreadSafeMutableDictionary (NSExtendedMutableDictionary)

- (void)addEntriesFromDictionary:
    (NSDictionary<id<NSCopying>, id> *)otherDictionary;
- (void)removeAllObjects;
- (void)removeObjectsForKeys:(NSArray<id<NSCopying>> *)keyArray;
- (void)setInternalObject:(NSDictionary<id<NSCopying>, id> *)otherInternalObject;
- (void)setObject:(nullable id)obj
forKeyedSubscript:(id)key NS_AVAILABLE(10_8, 6_0);

@end

@interface JKLThreadSafeMutableDictionary (NSMutableDictionaryCreation)

+ (instancetype)dictionaryWithCapacity:(NSUInteger)numItems;

@end


NS_ASSUME_NONNULL_END
