//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 597.5.2.1.0
//
#ifndef ISIconObserver_h
#define ISIconObserver_h
@import Foundation;

#include "ISIconManagerObserver-Protocol.h"

@protocol ISIconObserverDelegate;

@interface ISIconObserver : NSObject<ISIconManagerObserver>

@property (readonly, weak) NSObject<ISIconObserverDelegate> *delegate;

/* instance methods */
- (id)initWithDelegate:(id)delegate;
- (void)dealloc;
- (void)iconManager:(id)manager didInvalidateIcons:(id)icons;
@end

#endif /* ISIconObserver_h */