//
//  JKLThreadSafeMutableDictionary.m
//  Pods
//
//  Created by jiakai lian on 28/12/2015.
//
//

#import "JKLThreadSafeMutableDictionary.h"

#import "JKLThreadSafeMutableCollectionPrivate.h"

@interface JKLThreadSafeMutableDictionary ()
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation JKLThreadSafeMutableDictionary

#pragma mark - Object Life Cycle

+ (instancetype)dictionary {
    return [[self alloc] init];
}

+ (instancetype)dictionaryWithCapacity:(NSUInteger)numItems {
    return [[self alloc] initWithCapacity:numItems];
}

+ (instancetype)dictionaryWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

+ (instancetype)dictionaryWithObjects:(NSArray<id> *)objects
                              forKeys:(NSArray<id <NSCopying>> *)keys {
    return [[self alloc] initWithObjects:objects
                                 forKeys:keys];
}

+ (instancetype)dictionaryWithObject:(id)object
                              forKey:(id <NSCopying>)key {
    return [[self alloc] initWithObject:object
                                 forKey:key];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        super.internalObject = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    self = [self init];
    if (self) {
        super.internalObject = [NSMutableDictionary dictionaryWithCapacity:numItems];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary {
    self = [self init];
    if (self) {
        super.internalObject =
                [NSMutableDictionary dictionaryWithDictionary:otherDictionary];
    }
    return self;
}

- (instancetype)initWithObjects:(NSArray<id> *)objects
                        forKeys:(NSArray<id <NSCopying>> *)keys {
    self = [self init];
    if (self) {
        super.internalObject =
                [NSMutableDictionary dictionaryWithObjects:objects
                                                   forKeys:keys];
    }
    return self;
}

- (instancetype)initWithObject:(id)object
                        forKey:(id <NSCopying>)key {
    self = [self init];
    if (self) {
        super.internalObject =
                [NSMutableDictionary dictionaryWithObject:object
                                                   forKey:key];
    }
    return self;
}

- (instancetype)initWithDictionary:
        (NSDictionary<id <NSCopying>, id> *)otherDictionary
                         copyItems:(BOOL)flag {
    self = [self init];
    if (self) {
        super.internalObject =
                [[NSMutableDictionary alloc] initWithDictionary:otherDictionary
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
