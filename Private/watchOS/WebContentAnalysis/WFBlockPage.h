//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 50.0.0.0.0
//
#ifndef WFBlockPage_h
#define WFBlockPage_h
@import Foundation;

@class NSString, NSURL;

@interface WFBlockPage : NSObject {
  /* instance variables */
  NSString *preferredLanguage;
}

@property (readonly) NSURL *pageTemplateURL;
@property (retain) NSString *userVisibleURLString;
@property (retain) NSString *formActionURLString;

/* instance methods */
- (id)initNoOveridePageWithUsername:(id)username;
- (id)initWithUsername:(id)username overridesAllowded:(BOOL)allowded;
- (id)_initWithUsername:(id)username fileName:(id)name;
- (void)dealloc;
- (id)_blockpage;
- (id)_fileContentWithName:(id)name extension:(id)extension;
- (id)_css;
- (id)page;
@end

#endif /* WFBlockPage_h */