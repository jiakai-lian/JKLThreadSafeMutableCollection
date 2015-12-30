//
//  JKLThreadSafeMutableDictionary.m
//  Pods
//
//  Created by jiakai lian on 28/12/2015.
//
//

#import "JKLThreadSafeMutableDictionary.h"

@interface JKLThreadSafeMutableDictionary ()
@property(nonatomic, strong) NSMutableDictionary *internalObject;
@property(nonatomic, strong, readonly) dispatch_queue_t    queue;

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
        _internalObject = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    self = [self init];
    if (self) {
        _internalObject = [NSMutableDictionary dictionaryWithCapacity:numItems];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary {
    self = [self init];
    if (self) {
        _internalObject =
                [NSMutableDictionary dictionaryWithDictionary:otherDictionary];
    }
    return self;
}

- (instancetype)initWithObjects:(NSArray<id> *)objects
                        forKeys:(NSArray<id <NSCopying>> *)keys {
    self = [self init];
    if (self) {
        _internalObject =
                [NSMutableDictionary dictionaryWithObjects:objects
                                                   forKeys:keys];
    }
    return self;
}

- (instancetype)initWithObject:(id)object
                        forKey:(id <NSCopying>)key {
    self = [self init];
    if (self) {
        _internalObject =
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
        _internalObject =
                [[NSMutableDictionary alloc] initWithDictionary:otherDictionary
                                                      copyItems:flag];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self) {
        _internalObject = [coder decodeObjectForKey:NSStringFromSelector(@selector(internalObject))];
    }
    return self;
}

#pragma mark - MultiThreading Core Methods

- (dispatch_queue_t)queue {
    static dispatch_queue_t queue;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.jiakai.JKLThreadSafeMutableDictionary", DISPATCH_QUEUE_CONCURRENT);
    });

    return queue;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) return YES;

    if ([self.internalObject respondsToSelector:aSelector]) {
        return YES;
    }

    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    // can this class create the signature?
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];

    // if not, try our dictionary
    if (!signature) {
        if ([self.internalObject respondsToSelector:aSelector]) {
            return [self.internalObject methodSignatureForSelector:aSelector];
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)origInvocation {
    if ([self.internalObject respondsToSelector:[origInvocation selector]]) {
        __weak typeof(self) weakSelf         = self;
        NSMethodSignature   *methodSignature = [origInvocation methodSignature];
        const char          *type            = [methodSignature methodReturnType];
        if (*type == *@encode(void)) {
            // write operations
            dispatch_barrier_async(self.queue, ^{
                __strong typeof(self) strongSelf = weakSelf;
                [origInvocation invokeWithTarget:strongSelf.internalObject];
            });
        } else {
            // read operations
            dispatch_sync(self.queue, ^{
                __strong typeof(self) strongSelf = weakSelf;
                [origInvocation invokeWithTarget:strongSelf.internalObject];
            });
        }
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    // Prevent NSInvalidArgumentException
}

#pragma mark - Public Methods

- (NSString *)description {
    __block NSString *desc       = nil;
    __weak typeof(self) weakSelf = self;

    dispatch_sync(self.queue, ^{
        __strong typeof(self) strongSelf = weakSelf;
        desc = [strongSelf.internalObject description];
    });

    return desc;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.internalObject
                 forKey:NSStringFromSelector(@selector(internalObject))];
}

#pragma mark - NSCopying

- (id)copyWithZone:(nullable NSZone *)zone {
    __block id copiedItem        = nil;
    __weak typeof(self) weakSelf = self;

    dispatch_sync(self.queue, ^{
        __strong typeof(self) strongSelf = weakSelf;
        copiedItem = [strongSelf.internalObject copy];
    });

    return copiedItem;
}

#pragma mark - NSMutableCopying

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    __block id copiedItem        = nil;
    __weak typeof(self) weakSelf = self;

    dispatch_sync(self.queue, ^{
        __strong typeof(self) strongSelf = weakSelf;
        copiedItem = [JKLThreadSafeMutableDictionary dictionaryWithDictionary:strongSelf.internalObject];
    });

    return copiedItem;
}

@end

#pragma clang diagnostic pop
