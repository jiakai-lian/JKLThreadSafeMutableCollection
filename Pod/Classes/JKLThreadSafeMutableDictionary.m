//
//  JKLThreadSafeMutableDictionary.m
//  Pods
//
//  Created by jiakai lian on 28/12/2015.
//
//

#import "JKLThreadSafeMutableDictionary.h"

static char * const QUEUE_NAME = "com.jiakai.JKLThreadSafeMutableDictionary";

@interface JKLThreadSafeMutableDictionary ()
@property (nonatomic, strong) NSMutableDictionary * dictionary;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation JKLThreadSafeMutableDictionary

+ (instancetype) dictionary
{
    return [[self alloc] init];
}

+ (instancetype) dictionaryWithCapacity:(NSUInteger)numItems
{
    return [[self alloc] initWithCapacity:numItems];
}

+ (instancetype) dictionaryWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _dictionary = [NSMutableDictionary dictionary];
        _queue = dispatch_queue_create(QUEUE_NAME, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems
{
    self = [self init];
    if(self)
    {
        _dictionary = [NSMutableDictionary dictionaryWithCapacity:numItems];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary
{
    self = [self init];
    if(self)
    {
        _dictionary = [NSMutableDictionary dictionaryWithDictionary:otherDictionary];
    }
    return self;
}

//
//#pragma mark - read operations
//
//- (NSUInteger)count
//{
//    __block NSUInteger count;
//    __weak typeof(self) weakSelf = self;
//    dispatch_sync(self.queue, ^{
//        __strong typeof(self) strongSelf = weakSelf;
//        count = [strongSelf.dictioanry count];
//    });
//    return count;
//}
//
//- (id)objectForKey:(id)key
//{
//    __block id obj;
//    __weak typeof(self) weakSelf = self;
//    dispatch_sync(self.queue, ^{
//        __strong typeof(self) strongSelf = weakSelf;
//        obj = [strongSelf.dictioanry objectForKey:key];
//    });
//    return obj;
//}
//
//- (NSArray *)allKeys
//{
//    __block NSArray *keys;
//    __weak typeof(self) weakSelf = self;
//    dispatch_sync(_queue, ^{
//        __strong typeof(self) strongSelf = weakSelf;
//        keys = [strongSelf.dictioanry allKeys];
//    });
//    return keys;
//}
//
//- (NSArray *)allValues
//{
//    __block NSArray *vals;
//    __weak typeof(self) weakSelf = self;
//    dispatch_sync(self.queue, ^{
//        __strong typeof(self) strongSelf = weakSelf;
//        vals = [strongSelf.dictioanry allValues];
//    });
//    return vals;
//}
//
//- (id)objectForKeyedSubscript:(id<NSCopying>)key
//{
//    __block id obj;
//    __weak typeof(self) weakSelf = self;
//    dispatch_sync(self.queue, ^{
//        __strong typeof(self) strongSelf = weakSelf;
//        obj = [strongSelf.dictioanry objectForKeyedSubscript:key];
//    });
//    return obj;
//}
//
//#pragma mark - write operations
//
//- (void)setObject:(id)obj forKey:(id)key
//{
//    __weak typeof(self) weakSelf = self;
//    dispatch_barrier_async(self.queue, ^{
//        __strong typeof(self) strongSelf = weakSelf;
//        [strongSelf.dictioanry setObject:obj forKey:key];
//    });
//}
//
//- (void)removeObjectForKey:(id)key
//{
//    __weak typeof(self) weakSelf = self;
//    dispatch_barrier_async(_queue, ^{
//        __strong typeof(self) strongSelf = weakSelf;
//        [strongSelf.dictioanry removeObjectForKey:key];
//    });
//}
//
//- (void)removeObjectsForKeys:(NSArray*)keys
//{
//    __weak typeof(self) weakSelf = self;
//    dispatch_barrier_async(self.queue, ^{
//        __strong typeof(self) strongSelf = weakSelf;
//        [strongSelf.dictioanry removeObjectsForKeys:keys];
//    });
//}
//
//- (void)removeAllObjects
//{
//    __weak typeof(self) weakSelf = self;
//    dispatch_barrier_async(self.queue, ^{
//        __strong typeof(self) strongSelf = weakSelf;
//        [strongSelf.dictioanry removeAllObjects];
//    });
//}
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//{
//    @synchronized (delegateNodes) {
//        for (BCGCDMulticastDelegateNode *node in delegateNodes) {
//            NSMethodSignature *result = [node.delegate methodSignatureForSelector:aSelector];
//            
//            if (result != nil) {
//                return result;
//            }
//        }
//    }
//    
//    // This causes a crash...
//    // return [super methodSignatureForSelector:aSelector];
//    
//    // This also causes a crash...
//    // return nil;
//    
//    return [[self class] instanceMethodSignatureForSelector:@selector(doNothing)];
//}
//
//- (void)forwardInvocation:(NSInvocation *)origInvocation {
//  @autoreleasepool {
//    SEL selector = [origInvocation selector];
//    if ([self respondsToSelector:selector]) {
//      [origInvocation invokeWithTarget:self];
//    } else if ([self.dictioanry respondsToSelector:selector]) {
//      __weak typeof(self) weakSelf = self;
//      NSMethodSignature *methodSignature = [origInvocation methodSignature];
//      dispatch_async(self.queue, ^{
//        __strong typeof(self) strongSelf = weakSelf;
//        [origInvocation invokeWithTarget:strongSelf.dictioanry];
//      });
//    } else {
//      @throw [NSException exceptionWithName:NSInvalidArgumentException
//                                     reason:@"Unsupported Method"
//                                   userInfo:nil];
//    }
//  }
//}

- (BOOL)respondsToSelector:(SEL)aSelector
{
        if ([super respondsToSelector:aSelector])
            return YES;
    
   if ([self.dictionary respondsToSelector:aSelector])
        {
            return YES;
        }

    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    // can this class create the signature?
    NSMethodSignature* signature = [super methodSignatureForSelector:aSelector];
    
    // if not, try our dictoinary
    if (!signature)
    {
            if ([self.dictionary respondsToSelector:aSelector])
            {
                return [self.dictionary methodSignatureForSelector:aSelector];
            }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)origInvocation
{
        if ([self.dictionary respondsToSelector:[origInvocation selector]])
        {
                  __weak typeof(self) weakSelf = self;
                  NSMethodSignature *methodSignature = [origInvocation methodSignature];
            const char *type = [methodSignature methodReturnType];
            if(*type== *@encode(void))
            {
                //write operations
                dispatch_barrier_async(self.queue, ^{
                    __strong typeof(self) strongSelf = weakSelf;
                    [origInvocation invokeWithTarget:strongSelf.dictionary];
                });
            }
            else
            {
                //read operations
                dispatch_barrier_sync(self.queue, ^{
                    __strong typeof(self) strongSelf = weakSelf;
                    [origInvocation invokeWithTarget:strongSelf.dictionary];
                });
            }
            
            
        }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    // Prevent NSInvalidArgumentException
}

@end

#pragma clang diagnostic pop
