//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef _UIPlatterMenuSnapBehavior_h
#define _UIPlatterMenuSnapBehavior_h
@import Foundation;

#include "UIDynamicBehavior.h"
#include "UIAttachmentBehavior.h"

@interface _UIPlatterMenuSnapBehavior : UIDynamicBehavior {
  /* instance variables */
  UIAttachmentBehavior *_spring1;
  UIAttachmentBehavior *_spring2;
}

@property (nonatomic) double damping;
@property (nonatomic) double frequency;
@property (nonatomic) struct CGPoint { double x0; double x1; } anchorPoint;

/* instance methods */
- (id)initWithItem:(id)item attachedToAnchor:(struct CGPoint { double x0; double x1; })anchor;
@end

#endif /* _UIPlatterMenuSnapBehavior_h */