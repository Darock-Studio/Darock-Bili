//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef UIKeyboardLayoutCursor_h
#define UIKeyboardLayoutCursor_h
@import Foundation;

#include "UIKeyboardLayoutStar.h"
#include "UIAlertController.h"
#include "UIKBAlertControllerDelegate-Protocol.h"
#include "UIKBTree.h"
#include "UILabel.h"
#include "UILexicon.h"
#include "UIView.h"
#include "UIWindow.h"

@class NSArray, NSString;

@interface UIKeyboardLayoutCursor : UIKeyboardLayoutStar<UIKBAlertControllerDelegate> {
  /* instance variables */
  UIKBTree *_indirectKeyboard;
  UIView *_selectionView;
  NSArray *_keyplaneKeys;
  long long _selectedKeyIndex;
  BOOL _ignoreEventsUntilPressEnds;
  UILexicon *_recentInputs;
  BOOL _disableTouchInput;
  UIKBTree *_cachedMultitapKeyplane;
  BOOL _cachedCanMultitap;
  UILabel *_dictationHelpLabel;
  BOOL _didVariantDelete;
  BOOL _isForwardingEvent;
  int _overridenSelectedKeyType;
  struct CGPoint { double x; double y; } _keyplaneSwitchSelectedKeyFrameCenter;
  BOOL _selectInitialKey;
  BOOL _shouldStopDictationOnPressUp;
}

@property (retain, nonatomic) UIAlertController *recentInputsAlert;
@property (retain, nonatomic) NSString *keyplaneBeforeDictation;
@property (nonatomic) long long selectedKeyBeforeDictation;
@property (nonatomic) BOOL suppressOperations;
@property (nonatomic) BOOL overrideInitialKey;
@property (nonatomic) unsigned long long lastSelectedKeyIndex;
@property (nonatomic) BOOL shouldConfigureFloatingContentView;
@property (nonatomic) BOOL shouldToggleLetterCaseNext;
@property (readonly, nonatomic) BOOL slimLinearKeyboardTV;
@property (weak, nonatomic) UIWindow *focusWindow;
@property (readonly, nonatomic) UIKBTree *currentKey;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)carKeyboardNameForKeyboard:(id)keyboard screenTraits:(id)traits;
+ (struct CGSize { double x0; double x1; })keyboardSizeForInputMode:(id)mode screenTraits:(id)traits keyboardType:(long long)type;

/* instance methods */
- (id)initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (void)dealloc;
- (void)willMoveToWindow:(id)window;
- (void)runWithSuppressedActions:(id /* block */)actions;
- (unsigned long long)variantCountForKey:(id)key;
- (void)configureFloatingContentViewsIfNeeded;
- (id)keyViewAnimator;
- (void)showKeyboardWithInputTraits:(id)traits screenTraits:(id)traits splitTraits:(id)traits;
- (void)setKeyboardName:(id)name appearance:(long long)appearance;
- (void)setKeyboardAppearance:(long long)appearance;
- (void)setRenderConfig:(id)config;
- (id)cacheTokenForKeyplane:(id)keyplane;
- (void)flushKeyCache:(id)cache;
- (void)setKeyplaneName:(id)name;
- (BOOL)shouldAllowCurrentKeyplaneReload;
- (void)selectInitialKeyIfNecessary;
- (void)updateKeyplaneSwitchEdgeBiases;
- (void)updateDictationHelpString;
- (BOOL)shouldMatchCaseForDomainKeys;
- (void)showRecentInputsAlert;
- (void)alertDidDismiss;
- (void)didSelectRecentInputString:(id)string;
- (void)updateRecentInputsKeyIfNecessary;
- (void)acceptRecentInputIfNecessary;
- (void)setRecentInputs:(id)inputs;
- (BOOL)shouldPreventInputManagerHitTestingForKey:(id)key;
- (BOOL)shouldRetestKey:(id)key slidOffKey:(id)key withKeyplane:(id)keyplane;
- (unsigned char)getHandRestRecognizerState;
- (BOOL)supportsEmoji;
- (BOOL)isPossibleToTypeFast;
- (id)_keyplaneForKeyplaneProperties;
- (BOOL)usesAutoShift;
- (BOOL)ignoresShiftState;
- (void)setShift:(BOOL)shift;
- (BOOL)isAlphabeticPlane;
- (BOOL)isKanaPlane;
- (BOOL)supportsContinuousPath;
- (BOOL)diacriticForwardCompose;
- (void)setDisableTouchInput:(BOOL)input;
- (unsigned long long)targetEdgesForScreenGestureRecognition;
- (BOOL)shouldToggleKeyplaneWithName:(id)name;
- (BOOL)isKeyplaneDisabledWithName:(id)name;
- (BOOL)shouldMergeKey:(id)key;
- (int)stateForKeyplaneSwitchKey:(id)key;
- (int)stateForCandidateListKey:(id)key;
- (long long)defaultSelectedVariantIndexForKey:(id)key withActions:(unsigned long long)actions;
- (BOOL)canMultitap;
- (void)endMultitapForKey:(id)key;
- (void)longPressAction;
- (void)showPopupKeyplaneSwitcher;
- (int)activeStateForKey:(id)key;
- (int)enabledStateForKey:(id)key;
- (unsigned long long)downActionFlagsForKey:(id)key;
- (unsigned long long)cursorLocation;
- (void)setCursorLocation:(unsigned long long)location;
- (void)restoreFocusFromEntryPoint:(struct CGPoint { double x0; double x1; })point;
- (BOOL)shouldDeactivateWithoutWindow;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })selectionFrameForKeyIndex:(long long)index;
- (void)deactivateKey:(id)key;
- (void)setSelectedKeyIndex:(long long)index;
- (BOOL)refreshSelectedCellIfNecessaryForKey:(id)key;
- (BOOL)refreshSelectedCellIfNecessaryForKey:(id)key animated:(BOOL)animated;
- (void)setHighlightedVariantIndex:(long long)index key:(id)key;
- (long long)targetKeyIndexFromPoint:(struct CGPoint { double x0; double x1; })point;
- (long long)targetKeyIndexFromPoint:(struct CGPoint { double x0; double x1; })point inKeys:(id)keys;
- (long long)targetKeyIndexAtOffset:(struct CGPoint { double x0; double x1; })offset fromKey:(id)key;
- (id)keyHitTestInSameRowAsCenter:(struct CGPoint { double x0; double x1; })center size:(struct CGSize { double x0; double x1; })size;
- (BOOL)canHandleEvent:(id)event;
- (BOOL)canHandlePresses:(id)presses withEvent:(id)event;
- (void)takeKeyAction:(id)action;
- (void)clearVariantStateForKey:(id)key;
- (void)handleVariantDeleteIfNecessaryForKey:(id)key;
- (BOOL)handleLinearDirectionalInput:(int)input;
- (BOOL)handleVisualDirectionalInput:(int)input;
- (unsigned long long)getNextKeyplaneIndex:(unsigned long long)index;
- (void)returnToKeyplaneAfterDictation;
- (void)handleDidFinishDictation:(id)dictation;
- (void)pressesBegan:(id)began withEvent:(id)event;
- (void)pressesChanged:(id)changed withEvent:(id)event;
- (BOOL)_menuTapShouldExitVariants;
- (void)pressesEnded:(id)ended withEvent:(id)event;
- (void)pressesCancelled:(id)cancelled withEvent:(id)event;
- (BOOL)_handlePresses:(id)presses withEvent:(id)event;
- (void)remoteControlReceivedWithEvent:(id)event;
- (BOOL)_handleRemoteControlReceivedWithEvent:(id)event;
- (void)_wheelChangedWithEvent:(id)event;
- (BOOL)_handleWheelChangedWithEvent:(id)event;
- (void)_moveWithEvent:(id)event;
- (BOOL)_isDirectionalHeading:(unsigned long long)heading;
- (BOOL)_handleMoveWithEvent:(id)event;
- (unsigned long long)_indexOfFirstKeyPassingTest:(id /* block */)test;
- (BOOL)_isKeyboardReverseOfAppLayoutDirection;
- (id)getRomanAccentVariantsForString:(id)string inputMode:(id)mode keyboardVariantIndludes:(int)indludes;
- (double)defaultCursorAdjustDistance;
- (BOOL)isSlimLinearKeyboardTV;
- (BOOL)isAppRightToLeft;
- (BOOL)isKeyboardRightToLeft;
@end

#endif /* UIKeyboardLayoutCursor_h */