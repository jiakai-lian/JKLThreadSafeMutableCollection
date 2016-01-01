//
//  JKLThreadSafeMutableSet.h
//  Pods
//
//  Created by Jacky on 1/01/2016.
//
//

#import <Foundation/Foundation.h>
#import "JKLThreadSafeMutableCollection.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKLThreadSafeMutableSet : JKLThreadSafeMutableCollection

- (NSUInteger)count;
- (nullable id)member:(id)object;
- (NSEnumerator<id> *)objectEnumerator;

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithObjects:(const id[])objects
                          count:(NSUInteger)cnt;
- (instancetype)initWithCapacity:(NSUInteger)numItems;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;


@end

@interface JKLThreadSafeMutableSet (NSExtendedSet)

- (NSArray<id> *)allObjects;
- (nullable id)anyObject;
- (BOOL)containsObject:(id)anObject;
- (NSString *)description;
- (NSString *)descriptionWithLocale:(nullable id)locale;
- (BOOL)intersectsSet:(NSSet<id> *)otherSet;
- (BOOL)isEqualToSet:(NSSet<id> *)otherSet;
- (BOOL)isSubsetOfSet:(NSSet<id> *)otherSet;

- (void)makeObjectsPerformSelector:(SEL)aSelector NS_SWIFT_UNAVAILABLE("Use enumerateObjectsUsingBlock: or a for loop instead");
- (void)makeObjectsPerformSelector:(SEL)aSelector
                        withObject:(nullable id)argument NS_SWIFT_UNAVAILABLE("Use enumerateObjectsUsingBlock: or a for loop instead");

- (NSSet<id> *)setByAddingObject:(id)anObject NS_AVAILABLE(10_5, 2_0);
- (NSSet<id> *)setByAddingObjectsFromSet:(NSSet<id> *)other NS_AVAILABLE(10_5, 2_0);
- (NSSet<id> *)setByAddingObjectsFromArray:(NSArray<id> *)other NS_AVAILABLE(10_5, 2_0);

- (NSSet<id> *)objectsPassingTest:(BOOL (^)(id obj, BOOL *stop))predicate NS_AVAILABLE(10_6, 4_0);
- (NSSet<id> *)objectsWithOptions:(NSEnumerationOptions)opts
                      passingTest:(BOOL (^)(id obj, BOOL *stop))predicate NS_AVAILABLE(10_6, 4_0);

@end

@interface JKLThreadSafeMutableSet (NSSetCreation)

+ (instancetype)set;
+ (instancetype)setWithObject:(id)object;
+ (instancetype)setWithObjects:(const id[])objects
                         count:(NSUInteger)cnt;
+ (instancetype)setWithSet:(NSSet<id> *)set;
+ (instancetype)setWithArray:(NSArray<id> *)array;

- (instancetype)initWithSet:(NSSet<id> *)set;
- (instancetype)initWithSet:(NSSet<id> *)set
                  copyItems:(BOOL)flag;
- (instancetype)initWithArray:(NSArray<id> *)array;

@end

@interface JKLThreadSafeMutableSet (NSExtendedMutableSet)

- (void)addObjectsFromArray:(NSArray<id> *)array;
- (void)intersectSet:(NSSet<id> *)otherSet;
- (void)minusSet:(NSSet<id> *)otherSet;
- (void)removeAllObjects;
- (void)unionSet:(NSSet<id> *)otherSet;

- (void)setSet:(NSSet<id> *)otherSet;

@end

@interface JKLThreadSafeMutableSet (NSMutableSetCreation)

+ (instancetype)setWithCapacity:(NSUInteger)numItems;

@end

NS_ASSUME_NONNULL_END
