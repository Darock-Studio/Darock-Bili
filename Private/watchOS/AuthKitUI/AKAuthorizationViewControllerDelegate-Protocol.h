//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 466.7.8.3.2
//
#ifndef AKAuthorizationViewControllerDelegate_Protocol_h
#define AKAuthorizationViewControllerDelegate_Protocol_h
@import Foundation;

@protocol AKAuthorizationViewControllerDelegate <NSObject>
@optional
/* instance methods */
- (void)authorizationViewController:(id)controller didCompleteWithAuthorization:(id)authorization error:(id)error;
- (void)authorizationViewController:(id)controller didRequestAuthorizationWithUserProvidedInformation:(id)information completion:(id /* block */)completion;
- (void)authorizationViewController:(id)controller didRequestIconForRequestContext:(id)context completion:(id /* block */)completion;
@end

#endif /* AKAuthorizationViewControllerDelegate_Protocol_h */