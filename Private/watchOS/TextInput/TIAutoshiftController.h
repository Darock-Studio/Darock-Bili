//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3431.206.0.0.0
//
#ifndef TIAutoshiftController_h
#define TIAutoshiftController_h
@import Foundation;

#include "TITextInputTraits.h"

@interface TIAutoshiftController : NSObject

@property (readonly, nonatomic) TITextInputTraits *textInputTraits;
@property (nonatomic) BOOL enabled;

/* instance methods */
- (id)initWithTextInputTraits:(id)traits;
- (unsigned long long)actionForDocumentState:(id)state inputMangerState:(id)state;
- (BOOL)isSelectionAtSentenceAutoshiftBoundaryWithDocumentState:(id)state inputManagerState:(id)state;
- (BOOL)isEnabled;
@end

#endif /* TIAutoshiftController_h */