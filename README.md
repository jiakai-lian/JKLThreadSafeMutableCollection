# JKLThreadSafeMutableCollection

[![CI Status](http://img.shields.io/travis/jiakai lian/JKLThreadSafeMutableCollection.svg?style=flat)](https://travis-ci.org/jiakai lian/JKLThreadSafeMutableCollection)
[![Version](https://img.shields.io/cocoapods/v/JKLThreadSafeMutableCollection.svg?style=flat)](http://cocoapods.org/pods/JKLThreadSafeMutableCollection)
[![License](https://img.shields.io/cocoapods/l/JKLThreadSafeMutableCollection.svg?style=flat)](http://cocoapods.org/pods/JKLThreadSafeMutableCollection)
[![Platform](https://img.shields.io/cocoapods/p/JKLThreadSafeMutableCollection.svg?style=flat)](http://cocoapods.org/pods/JKLThreadSafeMutableCollection)

As Apple documented, NSDictionary, NSArray and NSSet are thread-safe, but not all the corresponding mutable classes.  JKLThreadSafeMutableCollection is developed to replace all those mutable classes by a lightweight solution.
This collection inlcudes **JKLThreadSafeMutableDictionary**, **JKLThreadSafeMutableArray** and **JKLThreadSafeMutableSet**.  All these classses support most of original NSMutable methods, include subscript feature(Ex. dictionary[key], array[index]).

## Thread Safe Implemenation
In terms of thread safe implemenation, all the classes in this collection are applying **concurrent read and exclusive write** model on a concurrent GCD queue. For performance comparision between different thread safe implementations, please check another repo [ThreadSafeClassDesign](https://github.com/jiakai-lian/ThreadSafeClassDesign).

##Black Magic In The Class
These classes utilize Objective-C run-time to simplify the method invocation procedure. Instead of rewriting each method for thread-safe, a custom message forwarding mechanism is implemented to pass external method callings to the internal object by return types. Therefore, no overwriting needed for most of object methods except class methods, initializer methods and few special methods. 

The following private method is the core method for the above explanation.
```Ruby
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
```



## Usage

To run the example project, clone the repo, and run `pod `install from the Example directory first.

## Requirements

## Installation

JKLThreadSafeMutableCollection is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JKLThreadSafeMutableCollection"
```

## Author

jiakai lian, jiakai.lian@gmail.com

## License

JKLThreadSafeMutableCollection is available under the MIT license. See the LICENSE file for more info.
