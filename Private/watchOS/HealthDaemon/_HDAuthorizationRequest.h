//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef _HDAuthorizationRequest_h
#define _HDAuthorizationRequest_h
@import Foundation;

@class NSSet, NSUUID;

@interface _HDAuthorizationRequest : NSObject {
  /* instance variables */
  id /* block */ _completionHandler;
  NSUUID *_identifier;
  NSSet *_typesToWrite;
  NSSet *_typesToRead;
}

/* instance methods */
- (id)description;
@end

#endif /* _HDAuthorizationRequest_h */