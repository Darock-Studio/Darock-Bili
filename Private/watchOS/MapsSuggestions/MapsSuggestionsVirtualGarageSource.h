//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2811.42.9.28.8
//
#ifndef MapsSuggestionsVirtualGarageSource_h
#define MapsSuggestionsVirtualGarageSource_h
@import Foundation;

#include "MapsSuggestionsBaseSource.h"
#include "MapsSuggestionsSource-Protocol.h"
#include "MapsSuggestionsSourceDelegate-Protocol.h"

@class NSString;

@interface MapsSuggestionsVirtualGarageSource : MapsSuggestionsBaseSource<MapsSuggestionsSource>

@property (weak, nonatomic) NSObject<MapsSuggestionsSourceDelegate> *delegate;
@property (readonly, nonatomic) NSString *uniqueName;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

@end

#endif /* MapsSuggestionsVirtualGarageSource_h */