//
//  JKLThreadSafeMutableArray.m
//  Pods
//
//  Created by Jacky on 29/12/2015.
//
//

#import "JKLThreadSafeMutableArray.h"

#import "JKLThreadSafeMutableCollectionPrivate.h"

@interface JKLThreadSafeMutableArray ()
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation JKLThreadSafeMutableArray

#pragma mark - Object Life Cycle

+ (instancetype)array {
    return [[self alloc] init];
}

+ (instancetype)arrayWithObject:(id)anObject {
    return [[self alloc] initWithObject:anObject];
}

+ (instancetype)arrayWithArray:(NSArray<id> *)array {
    return [[self alloc] initWithArray:array];
}

+ (instancetype)arrayWithCapacity:(NSUInteger)numItems {
    return [[self alloc] initWithCapacity:numItems];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        super.internalObject = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithObject:anObject {
    self = [self init];
    if (self) {
        super.internalObject = [NSMutableArray arrayWithObject:anObject];
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    self = [self init];
    if (self) {
        super.internalObject = [NSMutableArray arrayWithCapacity:numItems];
    }
    return self;
}

- (instancetype)initWithArray:(NSArray<id> *)array {
    self = [self init];
    if (self) {
        super.internalObject = [NSMutableArray arrayWithArray:array];
    }
    return self;
}

- (instancetype)initWithArray:(NSArray<id> *)array
                    copyItems:(BOOL)flag {
    self = [self init];
    if (self) {
        super.internalObject = [[NSMutableArray alloc] initWithArray:array
                                                      copyItems:flag];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self) {
        super.internalObject = [coder decodeObjectForKey:NSStringFromSelector(@selector(internalObject))];
    }
    return self;
}
@end

#pragma clang diagnostic pop
