//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3431.206.0.0.0
//
#ifndef TIKeyboardInputManager_mul_h
#define TIKeyboardInputManager_mul_h
@import Foundation;

#include "TIKeyboardInputManager.h"

@interface TIKeyboardInputManager_mul : TIKeyboardInputManager {
  /* instance variables */
  BOOL _isSuspended;
}

@property (nonatomic) BOOL compositionDisabled;
@property (readonly, nonatomic) BOOL shouldDynamicallySwitchComposedTextBetweenInternalAndExternal;

/* instance methods */
- (void)resume;
- (void)suspend;
- (id)keyboardConfiguration;
- (id)lexiconLocaleOfString:(id)string inputMode:(id)mode;
- (void)clearInput;
- (id)handleKeyboardInput:(id)input;
- (id)externalStringToInternal:(id)internal;
- (id)internalStringToExternal:(id)external;
- (unsigned int)internalIndexToExternal:(unsigned int)external;
- (unsigned int)externalIndexToInternal:(unsigned int)internal;
- (void)enumerateInputModesWithBlock:(id /* block */)block;
- (unsigned int)lexiconIDForInputMode:(id)mode;
- (float)weightForInputMode:(id)mode;
- (BOOL)isUsingMultilingual;
- (struct { struct String { unsigned short x0; unsigned short x1; unsigned short x2; unsigned char x3; char * x4; char x5[16] } x0; struct String { unsigned short x0; unsigned short x1; unsigned short x2; unsigned char x3; char * x4; char x5[16] } x1; struct String { unsigned short x0; unsigned short x1; unsigned short x2; unsigned char x3; char * x4; char x5[16] } x2; struct String { unsigned short x0; unsigned short x1; unsigned short x2; unsigned char x3; char * x4; char x5[16] } x3; struct String { unsigned short x0; unsigned short x1; unsigned short x2; unsigned char x3; char * x4; char x5[16] } x4; unsigned int x5; float x6; })lexiconInfoForInputMode:(id)mode;
- (struct vector<KB::LexiconInfo, std::allocator<KB::LexiconInfo>> { struct  * x0; struct  * x1; struct __compressed_pair<KB::LexiconInfo *, std::allocator<KB::LexiconInfo>> { struct  * x0; } x2; })lexiconInformationVector;
- (void *)languageModelContainer;
- (BOOL)validEnglishTransformerMultilingualConfig;
- (BOOL)updateLanguageModelForKeyboardState;
- (BOOL)containsActiveLanguage:(id)language language:(id)language;
- (BOOL)shouldUpdateDictionary;
- (void)loadDictionaries;
- (void)didUpdateInputModes:(id)modes;
- (void)didUpdateInputModeProbabilities:(id)probabilities;
- (void)updateLanguagePriors;
- (id)resourceInputModes;
@end

#endif /* TIKeyboardInputManager_mul_h */