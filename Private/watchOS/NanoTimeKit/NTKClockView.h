//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2398.45.8.0.0
//
#ifndef NTKClockView_h
#define NTKClockView_h
@import Foundation;

#include "UIView.h"
#include "NTKClockViewDelegate-Protocol.h"
#include "PUICBlurViewSource-Protocol.h"

@class NSString;

@interface NTKClockView : UIView<PUICBlurViewSource>

@property (weak, nonatomic) NSObject<NTKClockViewDelegate> *delegate;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)snapshotImage;
- (BOOL)postsDidMoveToWindowNotification;
- (void)didMoveToWindow;
@end

#endif /* NTKClockView_h */