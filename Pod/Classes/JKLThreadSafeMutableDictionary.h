//
//  JKLThreadSafeMutableDictionary.h
//  Pods
//
//  Created by jiakai lian on 28/12/2015.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKLThreadSafeMutableDictionary
    : NSObject  //<NSCopying, NSMutableCopying, NSSecureCoding,
                //NSFastEnumeration>

- (NSUInteger)count;
- (nullable id)objectForKey:(id<NSCopying>)aKey;
- (NSEnumerator<id<NSCopying>> *)keyEnumerator;
- (instancetype)init NS_DESIGNATED_INITIALIZER;
//#if TARGET_OS_WIN32
//- (instancetype)initWithObjects:(const id[])objects
//                        forKeys:(const id<NSCopying>[])keys
//                          count:(NSUInteger)cnt;
//#else
//- (instancetype)initWithObjects:(const id[])objects
//                        forKeys:(const id<NSCopying>[])keys
//                          count:(NSUInteger)cnt NS_DESIGNATED_INITIALIZER;
//#endif
//- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
//    NS_DESIGNATED_INITIALIZER;

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

- (void)enumerateKeysAndObjectsUsingBlock:
    (void (^)(id<NSCopying> key, id obj, BOOL *stop))block
    NS_AVAILABLE(10_6, 4_0);
- (void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts
                                usingBlock:(void (^)(id<NSCopying> key, id obj,
                                                     BOOL *stop))block
    NS_AVAILABLE(10_6, 4_0);

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
//#if TARGET_OS_WIN32
//+ (instancetype)dictionaryWithObjects:(const id[])objects
//                              forKeys:(const id<NSCopying>[])keys
//                                count:(NSUInteger)cnt;
//#else
//+ (instancetype)dictionaryWithObjects:(const id[])objects
//                              forKeys:(const id<NSCopying>[])keys
//                                count:(NSUInteger)cnt;
//#endif

+ (instancetype)dictionaryWithObjectsAndKeys:
    (id)firstObject, ... NS_REQUIRES_NIL_TERMINATION
    NS_SWIFT_UNAVAILABLE("Use dictionary literals instead");

+ (instancetype)dictionaryWithDictionary:
    (NSDictionary<id<NSCopying>, id> *)dict;
+ (instancetype)dictionaryWithObjects:(NSArray<id> *)objects
                              forKeys:(NSArray<id<NSCopying>> *)keys;

- (instancetype)initWithObjectsAndKeys:(id)firstObject,
                                       ... NS_REQUIRES_NIL_TERMINATION;
- (instancetype)initWithDictionary:
    (NSDictionary<id<NSCopying>, id> *)otherDictionary;
- (instancetype)initWithDictionary:
                    (NSDictionary<id<NSCopying>, id> *)otherDictionary
                         copyItems:(BOOL)flag;
- (instancetype)initWithObjects:(NSArray<id> *)objects
                        forKeys:(NSArray<id<NSCopying>> *)keys;

@end

@interface JKLThreadSafeMutableDictionary (NSExtendedMutableDictionary)

- (void)addEntriesFromDictionary:
    (NSDictionary<id<NSCopying>, id> *)otherDictionary;
- (void)removeAllObjects;
- (void)removeObjectsForKeys:(NSArray<id<NSCopying>> *)keyArray;
- (void)setDictionary:(NSDictionary<id<NSCopying>, id> *)otherDictionary;
- (void)setObject:(nullable id)obj
forKeyedSubscript:(id)key NS_AVAILABLE(10_8, 6_0);

@end

@interface JKLThreadSafeMutableDictionary (NSMutableDictionaryCreation)

+ (instancetype)dictionaryWithCapacity:(NSUInteger)numItems;

+ (instancetype)dictionaryWithContentsOfFile:(NSString *)path;
+ (instancetype)dictionaryWithContentsOfURL:(NSURL *)url;
- (instancetype)initWithContentsOfFile:(NSString *)path;
- (instancetype)initWithContentsOfURL:(NSURL *)url;

@end

@interface JKLThreadSafeMutableDictionary (NSSharedKeySetDictionary)

/*  Use this method to create a key set to pass to +dictionaryWithSharedKeySet:.
 The keys are copied from the array and must be copyable.
 If the array parameter is nil or not an NSArray, an exception is thrown.
 If the array of keys is empty, an empty key set is returned.
 The array of keys may contain duplicates, which are ignored (it is undefined
 which object of each duplicate pair is used).
 As for any usage of hashing, is recommended that the keys have a
 well-distributed implementation of -hash, and the hash codes must satisfy the
 hash/isEqual: invariant.
 Keys with duplicate hash codes are allowed, but will cause lower performance
 and increase memory usage.
 */
+ (id)sharedKeySetForKeys:(NSArray<id<NSCopying>> *)keys
    NS_AVAILABLE(10_8, 6_0);
/*  Create a mutable dictionary which is optimized for dealing with a known set
 of keys.
 Keys that are not in the key set can still be set into the dictionary, but that
 usage is not optimal.
 As with any dictionary, the keys must be copyable.
 If keyset is nil, an exception is thrown.
 If keyset is not an object returned by +sharedKeySetForKeys:, an exception is
 thrown.
 */
+ (instancetype)dictionaryWithSharedKeySet:(id)keyset NS_AVAILABLE(10_8, 6_0);

@end

NS_ASSUME_NONNULL_END
