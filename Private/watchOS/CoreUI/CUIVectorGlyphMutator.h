//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 866.4.0.0.0
//
#ifndef CUIVectorGlyphMutator_h
#define CUIVectorGlyphMutator_h
@import Foundation;

@interface CUIVectorGlyphMutator : NSObject

@property (nonatomic) struct CGPath * originPath;
@property (nonatomic) double pointSize;
@property (nonatomic) struct { double * x0; unsigned long long x1; } originPoints;
@property (nonatomic) struct { double * x0; unsigned long long x1; } ultralightDeltas;
@property (nonatomic) struct { double * x0; unsigned long long x1; } blackDeltas;

/* class methods */
+ (double *)realloc_cgfloat_array:(double *)realloc_cgfloat_array withNewCount:(unsigned long long)count;
+ (struct { double * x0; unsigned long long x1; })pointArrayFromPath:(struct CGPath *)path;
+ (struct { double * x0; unsigned long long x1; })deltaArrayFrom:(struct { double * x0; unsigned long long x1; })from to:(struct { double * x0; unsigned long long x1; })to;
+ (struct { double x0; double x1; })transformForGlyphSize:(long long)size;
+ (struct { double x0; double x1; })scalarsForGlyphWeight:(long long)weight glyphSize:(long long)size;

/* instance methods */
- (id)initWithPointSize:(double)size regular:(struct CGPath *)regular ultralight:(struct CGPath *)ultralight black:(struct CGPath *)black;
- (void)dealloc;
- (struct { double * x0; unsigned long long x1; })applyDeltasWithScalars:(struct { double x0; double x1; })scalars;
- (struct { double * x0; unsigned long long x1; })applyDeltasWithScalars:(struct { double x0; double x1; })scalars andTransform:(struct { double x0; double x1; })transform;
- (struct CGPath *)pathForScalars:(struct { double x0; double x1; })scalars;
- (struct CGPath *)pathForScalars:(struct { double x0; double x1; })scalars andTransform:(struct { double x0; double x1; })transform;
- (struct CGPath *)cgPathFrom:(struct { double * x0; unsigned long long x1; })from;
@end

#endif /* CUIVectorGlyphMutator_h */