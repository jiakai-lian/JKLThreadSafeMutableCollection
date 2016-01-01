//
//  JKLThreadSafeMutableSet.m
//  Pods
//
//  Created by Jacky on 1/01/2016.
//
//

#import "JKLThreadSafeMutableSet.h"

#import "JKLThreadSafeMutableCollectionPrivate.h"

@interface JKLThreadSafeMutableSet ()

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation JKLThreadSafeMutableSet

#pragma mark - Object Life Cycle

+ (instancetype)set {
    return [[self alloc] init];
}

+ (instancetype)setWithObject:(id)anObject {
    return [[self alloc] initWithObject:anObject];
}

+ (instancetype)setWithSet:(NSSet<id> *)set {
    return [[self alloc] initWithSet:set];
}

+ (instancetype)setWithArray:(NSArray<id> *)array {
    return [[self alloc] initWithArray:array];
}

+ (instancetype)setWithCapacity:(NSUInteger)numItems {
    return [[self alloc] initWithCapacity:numItems];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        super.internalObject = [NSMutableSet set];
    }
    return self;
}

- (instancetype)initWithObject:anObject {
    self = [self init];
    if (self) {
        super.internalObject = [NSMutableSet setWithObject:anObject];
    }
    return self;
}

- (instancetype)initWithObjects:(const id[])objects
                          count:(NSUInteger)cnt
{
    self = [self init];
    if (self) {
        super.internalObject = [[NSMutableSet alloc] initWithObjects:objects count:cnt];
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    self = [self init];
    if (self) {
        super.internalObject = [NSMutableSet setWithCapacity:numItems];
    }
    return self;
}

- (instancetype)initWithArray:(NSArray<id> *)array {
    self = [self init];
    if (self) {
        super.internalObject = [NSMutableSet setWithArray:array];
    }
    return self;
}

- (instancetype)initWithSet:(NSSet<id> *)set
                    copyItems:(BOOL)flag {
    self = [self init];
    if (self) {
        super.internalObject = [[NSMutableSet alloc] initWithSet:set
                                                      copyItems:flag];
    }
    return self;
}

- (instancetype)initWithSet:(NSSet<id> *)set {
    self = [self init];
    if (self) {
        super.internalObject = [[NSMutableSet alloc] initWithSet:set];
    }
    return self;
}

@end

#pragma clang diagnostic pop
