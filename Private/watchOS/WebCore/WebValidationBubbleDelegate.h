//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.1.17.12.4
//
#ifndef WebValidationBubbleDelegate_h
#define WebValidationBubbleDelegate_h
@import Foundation;

#include "UIPopoverPresentationControllerDelegate-Protocol.h"

@class NSString;

@interface WebValidationBubbleDelegate : NSObject<UIPopoverPresentationControllerDelegate>

@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (long long)adaptivePresentationStyleForPresentationController:(id)controller traitCollection:(id)collection;
@end

#endif /* WebValidationBubbleDelegate_h */