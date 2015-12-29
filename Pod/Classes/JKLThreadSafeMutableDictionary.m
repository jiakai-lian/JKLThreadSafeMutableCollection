//
//  JKLThreadSafeMutableDictionary.m
//  Pods
//
//  Created by jiakai lian on 28/12/2015.
//
//

#import "JKLThreadSafeMutableDictionary.h"

static char *const QUEUE_NAME = "com.jiakai.JKLThreadSafeMutableDictionary";

@interface JKLThreadSafeMutableDictionary ()
@property(nonatomic, strong) NSMutableDictionary *dictionary;
@property(nonatomic, strong) dispatch_queue_t    queue;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation JKLThreadSafeMutableDictionary

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

- (instancetype)init {
    self = [super init];
    if (self) {
        _dictionary = [NSMutableDictionary dictionary];
        _queue      = dispatch_queue_create(QUEUE_NAME, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    self = [self init];
    if (self) {
        _dictionary = [NSMutableDictionary dictionaryWithCapacity:numItems];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary {
    self = [self init];
    if (self) {
        _dictionary =
                [NSMutableDictionary dictionaryWithDictionary:otherDictionary];
    }
    return self;
}

- (instancetype)initWithObjects:(NSArray<id> *)objects
                        forKeys:(NSArray<id <NSCopying>> *)keys {
    self = [self init];
    if (self) {
        _dictionary =
                [NSMutableDictionary dictionaryWithObjects:objects
                                                   forKeys:keys];
    }
    return self;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) return YES;

    if ([self.dictionary respondsToSelector:aSelector]) {
        return YES;
    }

    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    // can this class create the signature?
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];

    // if not, try our dictionary
    if (!signature) {
        if ([self.dictionary respondsToSelector:aSelector]) {
            return [self.dictionary methodSignatureForSelector:aSelector];
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)origInvocation {
    if ([self.dictionary respondsToSelector:[origInvocation selector]]) {
        __weak typeof(self) weakSelf         = self;
        NSMethodSignature   *methodSignature = [origInvocation methodSignature];
        const char          *type            = [methodSignature methodReturnType];
        if (*type == *@encode(void)) {
            // write operations
            dispatch_barrier_async(self.queue, ^{
                __strong typeof(self) strongSelf = weakSelf;
                [origInvocation invokeWithTarget:strongSelf.dictionary];
            });
        } else {
            // read operations
            dispatch_barrier_sync(self.queue, ^{
                __strong typeof(self) strongSelf = weakSelf;
                [origInvocation invokeWithTarget:strongSelf.dictionary];
            });
        }
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    // Prevent NSInvalidArgumentException
}

@end

#pragma clang diagnostic pop
