//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4023.330.3.0.0
//
#ifndef NSArray_MSVAdditions_h
#define NSArray_MSVAdditions_h
@import Foundation;

@interface NSArray (MSVAdditions)
/* instance methods */
- (id)msv_prefixUpToIndex:(long long)index;
- (id)msv_suffixFromIndex:(long long)index;
- (id)msv_map:(id /* block */)msv_map;
- (id)msv_enumeratedMap:(id /* block */)map;
- (id)msv_compactMap:(id /* block */)map;
- (id)msv_enumeratedCompactMap:(id /* block */)map;
- (id)msv_flatMap:(id /* block */)map;
- (id)msv_filter:(id /* block */)msv_filter;
- (id)msv_firstWhere:(id /* block */)where;
- (BOOL)msv_reduceIntoBool:(BOOL)bool by:(id /* block */)by;
- (float)msv_reduceIntoFloat:(float)float by:(id /* block */)by;
- (double)msv_reduceIntoCGFloat:(double)cgfloat by:(id /* block */)by;
- (double)msv_reduceIntoDouble:(double)double by:(id /* block */)by;
- (long long)msv_reduceIntoInt:(long long)int by:(id /* block */)by;
- (int)msv_reduceIntoInt32:(int)int32 by:(id /* block */)by;
- (long long)msv_reduceIntoInt64:(long long)int64 by:(id /* block */)by;
- (unsigned long long)msv_reduceIntoUInt:(unsigned long long)uint by:(id /* block */)by;
- (unsigned int)msv_reduceIntoUInt32:(unsigned int)uint32 by:(id /* block */)by;
- (unsigned long long)msv_reduceIntoUInt64:(unsigned long long)uint64 by:(id /* block */)by;
- (id)msv_reduceIntoObject:(id)object by:(id /* block */)by;
- (BOOL)msv_reduceIntoBool:(BOOL)bool enumeratedBy:(id /* block */)by;
- (float)msv_reduceIntoFloat:(float)float enumeratedBy:(id /* block */)by;
- (double)msv_reduceIntoCGFloat:(double)cgfloat enumeratedBy:(id /* block */)by;
- (double)msv_reduceIntoDouble:(double)double enumeratedBy:(id /* block */)by;
- (long long)msv_reduceIntoInt:(long long)int enumeratedBy:(id /* block */)by;
- (int)msv_reduceIntoInt32:(int)int32 enumeratedBy:(id /* block */)by;
- (long long)msv_reduceIntoInt64:(long long)int64 enumeratedBy:(id /* block */)by;
- (unsigned long long)msv_reduceIntoUInt:(unsigned long long)uint enumeratedBy:(id /* block */)by;
- (unsigned int)msv_reduceIntoUInt32:(unsigned int)uint32 enumeratedBy:(id /* block */)by;
- (unsigned long long)msv_reduceIntoUInt64:(unsigned long long)uint64 enumeratedBy:(id /* block */)by;
- (id)msv_reduceIntoObject:(id)object enumeratedBy:(id /* block */)by;
- (id)msv_compactDescription;
- (id)msv_indexesOfObjectsEqualTo:(id)to;
- (long long)msv_firstIndexOfObjectsPassingTest:(id /* block */)test;
- (long long)msv_firstIndexOfObjectEqualTo:(id)to;
- (long long)msv_lastIndexOfObjectsPassingTest:(id /* block */)test;
- (long long)msv_lastIndexOfObjectEqualTo:(id)to;
- (id)msv_subarrayToIndex:(long long)index;
- (id)msv_subarrayFromIndex:(long long)index;
@end

#endif /* NSArray_MSVAdditions_h */