//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.1.17.12.4
//
#ifndef DOMHTMLFrameElement_h
#define DOMHTMLFrameElement_h
@import Foundation;

#include "DOMHTMLElement.h"
#include "DOMAbstractView.h"
#include "DOMDocument.h"
#include "WebFrame.h"

@class NSString;

@interface DOMHTMLFrameElement : DOMHTMLElement

@property (readonly, nonatomic) WebFrame *contentFrame;
@property (copy) NSString *frameBorder;
@property (copy) NSString *longDesc;
@property (copy) NSString *marginHeight;
@property (copy) NSString *marginWidth;
@property (copy) NSString *name;
@property BOOL noResize;
@property (copy) NSString *scrolling;
@property (copy) NSString *src;
@property (readonly) DOMDocument *contentDocument;
@property (readonly) DOMAbstractView *contentWindow;
@property (copy) NSString *location;
@property (readonly) int width;
@property (readonly) int height;

/* instance methods */
- (int)structuralComplexityContribution;
@end

#endif /* DOMHTMLFrameElement_h */