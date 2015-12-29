//
//  JKLThreadSafeMutableArray.m
//  Pods
//
//  Created by Jacky on 29/12/2015.
//
//

#import "JKLThreadSafeMutableArray.h"

static char *const QUEUE_NAME = "com.jiakai.JKLThreadSafeMutableArray";

@interface JKLThreadSafeMutableArray ()
@property(nonatomic, strong) NSMutableArray *array;
@property(nonatomic, strong) dispatch_queue_t    queue;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation JKLThreadSafeMutableArray

#pragma mark - Object Life Cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [NSMutableArray array];
        _queue      = dispatch_queue_create(QUEUE_NAME, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

#pragma mark - NSCopying
- (id)copyWithZone:(nullable NSZone *)zone
{
    __block id copiedItem       = nil;
    __weak typeof(self) weakSelf = self;
    
    dispatch_sync(self.queue, ^{
        __strong typeof(self) strongSelf = weakSelf;
        copiedItem = [strongSelf.array copy];
    });
    
    return copiedItem;
}

#pragma mark - NSMutableCopying
- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    __block id copiedItem       = nil;
    __weak typeof(self) weakSelf = self;
    
    dispatch_sync(self.queue, ^{
        __strong typeof(self) strongSelf = weakSelf;
        copiedItem = [strongSelf.array mutableCopy];
    });
    
    return copiedItem;
}

@end

#pragma clang diagnostic pop
