//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef _PKEnterCurrencyWithSuggestionsTextField_h
#define _PKEnterCurrencyWithSuggestionsTextField_h
@import Foundation;

#include "UITextField.h"

@protocol _PKEnterCurrencyWithSuggestionsTextFieldDataSource;

@interface _PKEnterCurrencyWithSuggestionsTextField : UITextField

@property (weak, nonatomic) NSObject<_PKEnterCurrencyWithSuggestionsTextFieldDataSource> *suggestionsDataSource;

/* instance methods */
- (void)setInputDelegate:(id)delegate;
- (void)insertTextSuggestion:(id)suggestion;
@end

#endif /* _PKEnterCurrencyWithSuggestionsTextField_h */