//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3431.206.0.0.0
//
#ifndef TIKeyboardInputManagerTransliteration_h
#define TIKeyboardInputManagerTransliteration_h
@import Foundation;

#include "TIKeyboardInputManagerTransliterationBase.h"

@class NSArray, NSMapTable, NSMutableArray, TLTransliterator;

@interface TIKeyboardInputManagerTransliteration : TIKeyboardInputManagerTransliterationBase

@property (retain, nonatomic) TLTransliterator *transliterator;
@property (nonatomic) BOOL prioritizeLatinCandidates;
@property (nonatomic) BOOL hasCandidates;
@property (retain, nonatomic) NSArray *currentCandidates;
@property (retain, nonatomic) NSMapTable *transliteratorCandidateByMecabraCandidatePointerValue;
@property (retain, nonatomic) NSMutableArray *committedCandidates;

/* instance methods */
- (id)initWithConfig:(id)config keyboardState:(id)state;
- (void *)initImplementation;
- (Class)keyEventMapClass;
- (id)keyEventMap;
- (id)keyboardBehaviors;
- (id)wordCharacters;
- (id)defaultCandidate;
- (BOOL)supportsNumberKeySelection;
- (void)syncToKeyboardState:(id)state from:(id)from afterContextChange:(BOOL)change;
- (void)suspend;
- (id)candidates;
- (BOOL)usesCandidateSelection;
- (id)handleAcceptedCandidate:(id)candidate keyboardState:(id)state;
- (void)deleteFromInputWithContext:(id)context;
- (id)candidateContextByVerifyingAgainstDocumentState;
- (id)sortingMethods;
- (id)titleForSortingMethod:(id)method;
- (id)groupedCandidatesFromCandidates:(id)candidates usingSortingMethod:(id)method;
- (id)dictionaryInputMode;
- (void)loadFavoniusTypingModel;
- (id)autocorrectionCandidateStrings;
- (id)mecabraCandidatePointerValueWithCandidate:(id)candidate;
- (id)candidatesWithTypedString:(id)string autocorrectedString:(id)string;
- (id)candidatesForInputString:(id)string;
- (id)keyboardConfiguration;
@end

#endif /* TIKeyboardInputManagerTransliteration_h */