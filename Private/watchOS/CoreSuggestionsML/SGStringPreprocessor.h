//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1226.2.2.1.0
//
#ifndef SGStringPreprocessor_h
#define SGStringPreprocessor_h
@import Foundation;

@class NSMutableData;

@interface SGStringPreprocessor : NSObject {
  /* instance variables */
  NSMutableData *_buffer;
}

/* instance methods */
- (id)init;
- (unsigned short *)bufferPtrWithMinimumLength:(unsigned long long)length;
- (void)replace:(id)replace withBuffer:(unsigned short *)buffer toIndex:(unsigned long long)index;
- (void)removeCharacters:(id)characters withExceptions:(id)exceptions fromString:(id)string;
- (id)characterSetFromString:(id)string;
- (void)lowerCase:(id)case;
- (void)separateCharacter:(id)character withValue:(id)value;
- (void)separateFrenchElisions:(id)elisions;
- (void)removeCharacters:(id)characters withValue:(id)value;
- (void)replaceCharactersWithSpaces:(id)spaces withValue:(id)value;
- (void)removeNonASCII:(id)ascii;
- (void)removePunctuation:(id)punctuation;
- (void)removeSpacingModifierLetters:(id)letters;
- (void)removeDuplicateWhitespace:(id)whitespace;
- (void)mergeNumbersSeparatedByASCIISpace:(id)asciispace;
- (void)replaceNumbersWithString:(id)string withValue:(id)value;
- (void)mergeTwoOrMoreConsecutiveCharacters:(id)characters;
- (void)mergeAnyConsecutiveCharacters:(id)characters;
- (void)mergeAnyConsecutiveNonalphabeticCharactersWithExceptions:(id)exceptions withValue:(id)value;
- (void)mergeAnyConsecutiveNonalphabeticCharacters:(id)characters;
- (void)replaceLinksWithString:(id)string withValue:(id)value;
- (void)trimWhitespace:(id)whitespace;
- (void)removeNonBasicMultilingualPlane:(id)plane;
- (void)decomposeStringWithCompatibilityMapping:(id)mapping;
- (void)decomposeAndRecomposeStringWithCompatibilityMapping:(id)mapping;
- (void)stripCombiningMarks:(id)marks;
- (void)stripNonBaseCharacters:(id)characters;
- (void)removeNonBaseCharacters:(id)characters;
- (void)removeEmojiModifyingCharactersWithExceptions:(id)exceptions withValue:(id)value;
- (void)removeEmojiModifyingCharacters:(id)characters;
- (void)removeEmojisWithExceptions:(id)exceptions withValue:(id)value;
- (void)removeEmojis:(id)emojis;
- (void)removeNonEmojiSymbolsWithExceptions:(id)exceptions withValue:(id)value;
- (void)removeNonEmojiSymbols:(id)symbols;
- (void)replaceAllWhitespaceWithSpaces:(id)spaces;
- (void)removePunctuationWithExceptions:(id)exceptions withValue:(id)value;
- (void)removeSymbols:(id)symbols;
- (void)removeSymbolsWithExceptions:(id)exceptions withValue:(id)value;
- (void)transformFullwidthToHalfwidth:(id)halfwidth;
- (void)transformFullwidthToHalfwidthASCII:(id)ascii;
- (void)transformHalfwidthToFullwidthCJK:(id)cjk;
- (void)combineDakutenAndHandakuten:(id)handakuten;
- (void)replaceContactNamesWithString:(id)string withValue:(id)value;
- (void)addToStart:(id)start withValue:(id)value;
- (void)addToEnd:(id)end withValue:(id)value;
- (void)finalizeForWordPieceCaseInsensitive:(id)insensitive;
- (void)finalizeForWordPieceCaseSensitive:(id)sensitive;
@end

#endif /* SGStringPreprocessor_h */