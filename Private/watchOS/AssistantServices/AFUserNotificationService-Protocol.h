//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.23.5.2.1
//
#ifndef AFUserNotificationService_Protocol_h
#define AFUserNotificationService_Protocol_h
@import Foundation;

@protocol AFUserNotificationService 
/* instance methods */
- (void)postNotificationRequest:(id)request completion:(id /* block */)completion;
- (void)withdrawNotificationRequestWithIdentifier:(id)identifier;
@end

#endif /* AFUserNotificationService_Protocol_h */