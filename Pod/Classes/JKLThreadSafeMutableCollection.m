//
//  JKLThreadSafeMutableCollection.m
//  Pods
//
//  Created by Jacky on 1/01/2016.
//
//

#import "JKLThreadSafeMutableCollection.h"

#import "JKLThreadSafeMutableCollectionPrivate.h"

@implementation JKLThreadSafeMutableCollection

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
        queue = dispatch_queue_create("com.jiakai.JKLThreadSafeMutableCollection", DISPATCH_QUEUE_CONCURRENT);
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
    
    // if not, try our internalObject
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
        copiedItem = [strongSelf.internalObject mutableCopy];
    });
    
    return copiedItem;
}


@end
