//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2811.42.9.28.8
//
#ifndef MapsSuggestionsStrategy_Protocol_h
#define MapsSuggestionsStrategy_Protocol_h
@import Foundation;

@protocol MapsSuggestionsStrategy <MapsSuggestionsObject>

@property (weak, nonatomic) MapsSuggestionsManager *manager;

/* instance methods */
- (id)topSuggestionsWithSourceEntries:(id)entries error:(id *)error;
- (BOOL)preFiltersKept:(id)kept;
- (BOOL)postFiltersKept:(id)kept;
- (void)addPreFilter:(id)filter;
- (void)addPostFilter:(id)filter;
- (void)removeFilter:(id)filter;
- (void)removeAllFilters;
- (void)addImprover:(id)improver;
- (void)removeAllImprovers;
- (void)addDeduper:(id)deduper;
- (void)removeAllDedupers;
- (void)clearData;
@end

#endif /* MapsSuggestionsStrategy_Protocol_h */