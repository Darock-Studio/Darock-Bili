//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.7.1.0.0
//
#ifndef _EARLmLoader_h
#define _EARLmLoader_h
@import Foundation;

@protocol {shared_ptr<quasar::LmLoader2>="__ptr_"^{LmLoader2}"__cntrl_"^{__shared_weak_count}};

@interface _EARLmLoader : NSObject {
  /* instance variables */
  struct shared_ptr<quasar::LmLoader2> { struct LmLoader2 *__ptr_; struct __shared_weak_count *__cntrl_; } _loader;
}

/* class methods */
+ (void)initialize;

/* instance methods */
- (id)init;
- (id)fetchOrLoadModelWithDirectory:(id)directory recognizer:(id)recognizer;
- (id)loadForRecognitionWithDirectory:(id)directory recognizer:(id)recognizer task:(id)task applicationName:(id)name;
- (void)invalidate;
@end

#endif /* _EARLmLoader_h */