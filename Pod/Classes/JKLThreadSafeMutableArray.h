//
//  JKLThreadSafeMutableArray.h
//  Pods
//
//  Created by Jacky on 29/12/2015.
//
//

#import <Foundation/Foundation.h>
#import "JKLThreadSafeMutableCollection.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKLThreadSafeMutableArray : JKLThreadSafeMutableCollection

- (NSUInteger) count;
- (id)objectAtIndex:(NSUInteger)index;
- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithObjects:(const id [])objects count:(NSUInteger)cnt;
- (instancetype)initWithCapacity:(NSUInteger)numItems;

- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end

@interface JKLThreadSafeMutableArray (NSExtendedArray)

- (NSArray<id> *)arrayByAddingObject:(id)anObject;
- (NSArray<id> *)arrayByAddingObjectsFromArray:(NSArray<id> *)otherArray;
- (NSString *)componentsJoinedByString:(NSString *)separator;
- (BOOL)containsObject:(id)anObject;
- (NSString *)description;
- (NSString *)descriptionWithLocale:(nullable id)locale;
- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level;
- (nullable id)firstObjectCommonWithArray:(NSArray<id> *)otherArray;
- (void)getObjects:(id __unsafe_unretained [])objects range:(NSRange)range;
- (NSUInteger)indexOfObject:(id)anObject;
- (NSUInteger)indexOfObject:(id)anObject inRange:(NSRange)range;
- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject;
- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
- (BOOL)isEqualToArray:(NSArray<id> *)otherArray;
- (id) firstObject NS_AVAILABLE(10_6, 4_0);
- (id) lastObject;
- (NSEnumerator<id> *)objectEnumerator;
- (NSEnumerator<id> *)reverseObjectEnumerator;
- (NSData *)sortedArrayHint;
- (NSArray<id> *)sortedArrayUsingFunction:(NSInteger (*)(id, id, void * __nullable))comparator context:(nullable void *)context;
- (NSArray<id> *)sortedArrayUsingFunction:(NSInteger (*)(id, id, void * __nullable))comparator context:(nullable void *)context hint:(nullable NSData *)hint;
- (NSArray<id> *)sortedArrayUsingSelector:(SEL)comparator;
- (NSArray<id> *)subarrayWithRange:(NSRange)range;
- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically;

- (NSArray<id> *)objectsAtIndexes:(NSIndexSet *)indexes;

- (id)objectAtIndexedSubscript:(NSUInteger)idx NS_AVAILABLE(10_8, 6_0);

- (NSUInteger)indexOfObjectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate NS_AVAILABLE(10_6, 4_0);
- (NSUInteger)indexOfObjectWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate NS_AVAILABLE(10_6, 4_0);
- (NSUInteger)indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate NS_AVAILABLE(10_6, 4_0);

- (NSIndexSet *)indexesOfObjectsPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate NS_AVAILABLE(10_6, 4_0);
- (NSIndexSet *)indexesOfObjectsWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate NS_AVAILABLE(10_6, 4_0);
- (NSIndexSet *)indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate NS_AVAILABLE(10_6, 4_0);

- (NSArray<id> *)sortedArrayUsingComparator:(NSComparator)cmptr NS_AVAILABLE(10_6, 4_0);
- (NSArray<id> *)sortedArrayWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr NS_AVAILABLE(10_6, 4_0);

- (NSUInteger)indexOfObject:(id)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator)cmp NS_AVAILABLE(10_6, 4_0); // binary search

@end

@interface JKLThreadSafeMutableArray (NSArrayCreation)

+ (instancetype)array;
+ (instancetype)arrayWithObject:(id)anObject;
+ (instancetype)arrayWithObjects:(const id [])objects count:(NSUInteger)cnt;
+ (instancetype)arrayWithArray:(NSArray<id> *)array;

- (instancetype)initWithArray:(NSArray<id> *)array;
- (instancetype)initWithArray:(NSArray<id> *)array copyItems:(BOOL)flag;

@end

@interface JKLThreadSafeMutableArray (NSExtendedMutableArray)

- (void)addObjectsFromArray:(NSArray<id> *)otherArray;
- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)removeAllObjects;
- (void)removeObject:(id)anObject inRange:(NSRange)range;
- (void)removeObject:(id)anObject;
- (void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
- (void)removeObjectIdenticalTo:(id)anObject;
- (void)removeObjectsInArray:(NSArray<id> *)otherArray;
- (void)removeObjectsInRange:(NSRange)range;
- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray range:(NSRange)otherRange;
- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray;
- (void)setArray:(NSArray<id> *)otherArray;
- (void)sortUsingFunction:(NSInteger (*)(id,  id, void * __nullable))compare context:(nullable void *)context;
- (void)sortUsingSelector:(SEL)comparator;

- (void)insertObjects:(NSArray<id> *)objects atIndexes:(NSIndexSet *)indexes;
- (void)removeObjectsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<id> *)objects;

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx NS_AVAILABLE(10_8, 6_0);

- (void)sortUsingComparator:(NSComparator)cmptr NS_AVAILABLE(10_6, 4_0);
- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr NS_AVAILABLE(10_6, 4_0);

@end

@interface JKLThreadSafeMutableArray (NSMutableArrayCreation)

+ (instancetype)arrayWithCapacity:(NSUInteger)numItems;
@end

NS_ASSUME_NONNULL_END