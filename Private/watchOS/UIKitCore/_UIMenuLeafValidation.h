//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef _UIMenuLeafValidation_h
#define _UIMenuLeafValidation_h
@import Foundation;

#include "_UIValidatableCommand.h"

@interface _UIMenuLeafValidation : NSObject {
  /* instance variables */
  _UIValidatableCommand *_validatedCommand;
}

/* instance methods */
- (id)init;
- (id)validatedActionForTarget:(id)target action:(id)action;
- (id)validatedCommandForTarget:(id)target command:(id)command alternate:(id)alternate sender:(id)sender;
@end

#endif /* _UIMenuLeafValidation_h */