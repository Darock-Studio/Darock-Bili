//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1262.300.81.4.10
//
#ifndef NSLayoutManagerDelegate_Protocol_h
#define NSLayoutManagerDelegate_Protocol_h
@import Foundation;

@protocol NSLayoutManagerDelegate <NSObject>
@optional
/* instance methods */
- (unsigned long long)layoutManager:(id)manager shouldGenerateGlyphs:(const unsigned short *)glyphs properties:(const long long *)properties characterIndexes:(const unsigned long long *)indexes font:(id)font forGlyphRange:(struct _NSRange { unsigned long long x0; unsigned long long x1; })range;
- (double)layoutManager:(id)manager lineSpacingAfterGlyphAtIndex:(unsigned long long)index withProposedLineFragmentRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })rect;
- (double)layoutManager:(id)manager paragraphSpacingBeforeGlyphAtIndex:(unsigned long long)index withProposedLineFragmentRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })rect;
- (double)layoutManager:(id)manager paragraphSpacingAfterGlyphAtIndex:(unsigned long long)index withProposedLineFragmentRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })rect;
- (long long)layoutManager:(id)manager shouldUseAction:(long long)action forControlCharacterAtIndex:(unsigned long long)index;
- (BOOL)layoutManager:(id)manager shouldBreakLineByWordBeforeCharacterAtIndex:(unsigned long long)index;
- (BOOL)layoutManager:(id)manager shouldBreakLineByHyphenatingBeforeCharacterAtIndex:(unsigned long long)index;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })layoutManager:(id)manager boundingBoxForControlGlyphAtIndex:(unsigned long long)index forTextContainer:(id)container proposedLineFragment:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })fragment glyphPosition:(struct CGPoint { double x0; double x1; })position characterIndex:(unsigned long long)index;
- (BOOL)layoutManager:(id)manager shouldSetLineFragmentRect:(inout struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; } *)rect lineFragmentUsedRect:(inout struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; } *)rect baselineOffset:(inout double *)offset inTextContainer:(id)container forGlyphRange:(struct _NSRange { unsigned long long x0; unsigned long long x1; })range;
- (void)layoutManagerDidInvalidateLayout:(id)layout;
- (void)layoutManager:(id)manager didCompleteLayoutForTextContainer:(id)container atEnd:(BOOL)end;
- (void)layoutManager:(id)manager textContainer:(id)container didChangeGeometryFromSize:(struct CGSize { double x0; double x1; })size;
@end

#endif /* NSLayoutManagerDelegate_Protocol_h */