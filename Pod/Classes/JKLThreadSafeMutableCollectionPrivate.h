//
//  JKLThreadSafeMutableCollectionPrivate.h
//  Pods
//
//  Created by Jacky on 1/01/2016.
//
//

@interface JKLThreadSafeMutableCollection()
@property(nonatomic, strong) id internalObject;
@property(nonatomic, strong, readonly) dispatch_queue_t    queue;
@end