//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1450.2.4.0.0
//
#ifndef SSProtocolCondition_h
#define SSProtocolCondition_h
@import Foundation;

@interface SSProtocolCondition : NSObject {
  /* instance variables */
  long long _operator;
  id _value;
}

/* class methods */
+ (id)newConditionWithDictionary:(id)dictionary;

/* instance methods */
- (id)initWithDictionary:(id)dictionary;
- (void)dealloc;
- (BOOL)evaluateWithContext:(id)context;
@end

#endif /* SSProtocolCondition_h */