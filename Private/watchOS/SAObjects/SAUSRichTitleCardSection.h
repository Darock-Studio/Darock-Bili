//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3300.28.1.0.0
//
#ifndef SAUSRichTitleCardSection_h
#define SAUSRichTitleCardSection_h
@import Foundation;

#include "SAUSTitleCardSection.h"
#include "SAUIImageResource.h"

@class NSString;

@interface SAUSRichTitleCardSection : SAUSTitleCardSection

@property (nonatomic) BOOL centered;
@property (copy, nonatomic) NSString *contentRatingText;
@property (copy, nonatomic) NSString *subtitle;
@property (retain, nonatomic) SAUIImageResource *titleImage;

/* class methods */
+ (id)richTitleCardSection;
+ (id)richTitleCardSectionWithDictionary:(id)dictionary context:(id)context;

/* instance methods */
- (id)groupIdentifier;
- (id)encodedClassName;
@end

#endif /* SAUSRichTitleCardSection_h */