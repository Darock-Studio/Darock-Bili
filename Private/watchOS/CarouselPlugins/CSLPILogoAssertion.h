//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1112.2.15.0.0
//
#ifndef CSLPILogoAssertion_h
#define CSLPILogoAssertion_h
@import Foundation;

@class CSLUIOverlayAssertion;

@interface CSLPILogoAssertion : NSObject {
  /* instance variables */
  CSLUIOverlayAssertion *_overlayAssertion;
}

/* class methods */
+ (void)setOverlayAssertionVendor:(id)vendor;
+ (id)assertionWithName:(id)name;

/* instance methods */
- (id)initWithName:(id)name;
@end

#endif /* CSLPILogoAssertion_h */