//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.1.17.12.4
//
#ifndef WBSParsecSearchSimpleResult_Protocol_h
#define WBSParsecSearchSimpleResult_Protocol_h
@import Foundation;

#include "WBSParsecLegacySearchResult.h"
#include "WBSParsecImageRepresentation.h"
#include "WBSParsecSearchSimpleResult-Protocol.h"

@class NSArray, NSString;
@protocol WBSParsecSearchSession;

@protocol WBSParsecSearchSimpleResult <WBSParsecSearchResultPresentedInCard>

@property (readonly, nonatomic) NSString *footnote;

@end

#endif /* WBSParsecSearchSimpleResult_Protocol_h */