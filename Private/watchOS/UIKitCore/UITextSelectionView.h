//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef UITextSelectionView_h
#define UITextSelectionView_h
@import Foundation;

#include "UIView.h"
#include "UITextInteractionAssistant.h"
#include "UITextRangeView.h"
#include "UITextSelection.h"
#include "UIView.h"

@class CAKeyframeAnimation, NSArray;

@interface UITextSelectionView : UIView {
  /* instance variables */
  UITextInteractionAssistant *m_interactionAssistant;
  UITextSelection *m_selection;
  UIView *m_caretView;
  UIView *m_floatingCaretView;
  UITextRangeView *m_rangeView;
  BOOL m_caretBlinks;
  BOOL m_caretShowingNow;
  BOOL m_caretAnimating;
  BOOL m_ghostApperarance;
  BOOL m_caretVisible;
  BOOL m_visible;
  BOOL m_activated;
  BOOL m_wasShowingCommands;
  BOOL m_delayShowingCommands;
  BOOL m_dictationReplacementsMode;
  BOOL m_shouldEmphasizeNextSelectionRects;
  int m_showingCommandsCounter;
  NSArray *m_replacements;
  BOOL m_deferSelectionCommands;
  struct __CFRunLoopObserver * m_observer;
  BOOL m_activeCaret;
  BOOL m_isSuspended;
  int m_showingCommandsCounterForRotate;
  unsigned long long _activeGrabberSuppressionAssertions;
  CAKeyframeAnimation *_caretBlinkAnimation;
  id _floatingCaretBlinkAssertion;
  unsigned long long _viewDidCommitNotification;
  unsigned long long _viewDidStopNotification;
  id /* block */ _hideSelectionCommandsWorkItem;
  BOOL m_forceRangeView;
}

@property (readonly, nonatomic) UIView *caretView;
@property (readonly, nonatomic) UIView *floatingCaretView;
@property (readonly, nonatomic) UITextRangeView *rangeView;
@property (nonatomic) struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; } stashedCaretRect;
@property (nonatomic) BOOL isIndirectFloatingCaret;
@property (nonatomic) struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; } previousGhostCaretRect;
@property (readonly, weak, nonatomic) UITextInteractionAssistant *interactionAssistant;
@property (readonly, nonatomic) UITextSelection *selection;
@property (nonatomic) BOOL caretBlinks;
@property (nonatomic) BOOL visible;
@property (nonatomic) BOOL forceRangeView;
@property (readonly, nonatomic) BOOL selectionCommandsShowing;
@property (retain, nonatomic) NSArray *replacements;
@property (readonly, nonatomic) BOOL isInstalledInSelectionContainerView;
@property (nonatomic) BOOL caretVisible;
@property (nonatomic) BOOL ghostAppearance;
@property (nonatomic) BOOL activeFlattened;
@property (nonatomic) BOOL alertFlattened;
@property (nonatomic) BOOL sheetFlattened;
@property (nonatomic) BOOL popoverFlattened;
@property (nonatomic) BOOL navigationTransitionFlattened;
@property (nonatomic) int applicationDeactivationReason;

/* instance methods */
- (id)initWithInteractionAssistant:(id)assistant;
- (void)validateWithInteractionAssistant:(id)assistant;
- (void)willMoveToSuperview;
- (void)didMoveToSuperview;
- (void)invalidate;
- (BOOL)isValid;
- (void)dealloc;
- (void)detach;
- (void)activate;
- (void)deactivate;
- (void)deactivateAndCollapseSelection:(BOOL)selection;
- (void)windowDidResignOrBecomeKey;
- (void)inputModeDidChange:(id)change;
- (void)viewAnimate:(id)animate;
- (void)_updateViewAnimateNotificationObservationIfNecessary;
- (void)_registerForViewAnimationNotificationsIfNecessary;
- (void)_unregisterForViewAnimationNotificationsIfNecessary;
- (void)selectionWillScroll:(id)scroll;
- (void)selectionDidScroll:(id)scroll;
- (BOOL)affectedByScrollerNotification:(id)notification;
- (void)inputViewWillChange;
- (void)inputViewDidChange;
- (void)inputViewWillMove:(id)move;
- (void)inputViewDidMove;
- (void)inputViewWillAnimate;
- (void)inputViewDidAnimate;
- (void)selectionWillTranslateForReachability:(id)reachability;
- (void)selectionDidTranslateForReachability:(id)reachability;
- (void)textSelectionViewActivated:(id)activated;
- (void)willMoveToWindow:(id)window;
- (void)removeFromSuperview;
- (void)clearRangeAnimated:(BOOL)animated;
- (BOOL)_viewUsesAsynchronousProtocol;
- (id)_customSelectionContainerView;
- (BOOL)_activeAndVisible;
- (void)installIfNecessary;
- (id)_actingParentViewForGestureRecognizers;
- (void)selectionChanged;
- (void)updateSelectionRects;
- (void)tintColorDidChange;
- (void)didSuspend:(id)suspend;
- (void)willResume:(id)resume;
- (void)deferredUpdateSelectionRects;
- (void)setEmphasisOnNextSelectionRects;
- (void)deferredUpdateSelectionCommands;
- (void)updateSelectionRectsIfNeeded;
- (void)updateSelectionDots;
- (BOOL)shouldBeVisible;
- (void)appearOrFadeIfNecessary;
- (void)showCommandsWithReplacements:(id)replacements;
- (void)_showCommandsWithReplacements:(id)replacements forDictation:(BOOL)dictation afterDelay:(double)delay;
- (void)_showCommandsWithReplacements:(id)replacements isForContextMenu:(BOOL)menu forDictation:(BOOL)dictation arrowDirection:(long long)direction;
- (id)_editMenuSourceWindow;
- (id)menuInteraction;
- (BOOL)_editMenuIsVisible;
- (void)updateSelectionCommands;
- (void)cancelDelayedCommandRequests;
- (void)showCalloutBarAfterDelay:(double)delay;
- (void)showSelectionCommandsAfterDelay:(double)delay;
- (void)showSelectionCommands;
- (void)updateRangeViewForSelectionMode;
- (void)_showSelectionCommandsForContextMenu:(BOOL)menu;
- (void)calculateReplacementsWithGenerator:(id)generator andShowAfterDelay:(double)delay;
- (void)showReplacementsWithGenerator:(id)generator forDictation:(BOOL)dictation afterDelay:(double)delay;
- (void)hideSelectionCommandsAfterDelay:(double)delay reason:(long long)reason;
- (void)hideSelectionCommands;
- (void)_hideSelectionCommandsWithReason:(long long)reason;
- (id)hitTest:(struct CGPoint { double x0; double x1; })test withEvent:(id)event;
- (void)configureForSelectionMode;
- (void)configureForHighlightMode;
- (void)configureForReplacementMode;
- (void)configureForPencilHighlightMode;
- (void)configureForPencilDeletionPreviewMode;
- (BOOL)activeCaret;
- (void)clearCaret;
- (void)hideCaret:(int)caret;
- (void)_hideCaret:(int)caret;
- (void)animateBoxShrinkOn:(id)on;
- (void)animateExpanderOn:(id)on;
- (void)showInitialCaret;
- (void)showCaret:(int)caret;
- (void)_showCaret:(int)caret;
- (void)_setCaretBlinkAnimationEnabled:(BOOL)enabled;
- (id)ghostCaretViewColor;
- (id)caretViewColor;
- (id)floatingCaretViewColor;
- (void)addCaretToSubview;
- (BOOL)point:(struct CGPoint { double x0; double x1; })point isNearCursorRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })rect;
- (void)beginFloatingCaretView;
- (void)animatePulsingIndirectCaret:(id)caret;
- (void)animatePulsingDirectCaret:(id)caret;
- (void)willBeginFloatingCursor:(BOOL)cursor;
- (BOOL)_shouldUseIndirectFloatingCaret;
- (void)beginFloatingCursorAtPoint:(struct CGPoint { double x0; double x1; })point;
- (struct CGPoint { double x0; double x1; })floatingCursorPositionForPoint:(struct CGPoint { double x0; double x1; })point;
- (struct CGPoint { double x0; double x1; })floatingCursorPositionForPoint:(struct CGPoint { double x0; double x1; })point lineSnapping:(BOOL)snapping;
- (void)updateFloatingCursorAtPoint:(struct CGPoint { double x0; double x1; })point;
- (void)updateFloatingCursorAtPoint:(struct CGPoint { double x0; double x1; })point animated:(BOOL)animated;
- (void)animateCaret:(id)caret toPosition:(struct CGPoint { double x0; double x1; })position withSize:(struct CGSize { double x0; double x1; })size;
- (void)endFloatingCaretView;
- (void)endFloatingCursor;
- (id)obtainGrabberSuppressionAssertion;
- (BOOL)shouldSuppressSelectionHandles;
- (void)releaseGrabberHandleSuppressionAssertion:(id)assertion;
- (id)dynamicCaret;
- (id)dynamicCaretList;
- (void)updateDocumentHasContent:(BOOL)content;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })selectionBoundingBox;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })selectionBoundingBoxForRects:(id)rects;
- (void)layoutChangedByScrolling:(BOOL)scrolling;
- (void)prepareForMagnification;
- (void)doneMagnifying;
- (void)scaleWillChange:(id)change;
- (void)scaleDidChange:(id)change;
- (void)willRotate:(id)rotate;
- (void)didRotate:(id)rotate;
- (void)updateBaseIsStartWithDocumentPoint:(struct CGPoint { double x0; double x1; })point;
- (void)updateSelectionWithDocumentPoint:(struct CGPoint { double x0; double x1; })point;
- (id)scrollView;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })clippedTargetRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })rect;
- (void)mustFlattenForAlert:(id)alert;
- (void)canExpandAfterAlert:(id)alert;
- (void)mustFlattenForSheet:(id)sheet;
- (void)canExpandAfterSheet:(id)sheet;
- (void)mustFlattenForPopover:(id)popover;
- (void)canExpandAfterPopover:(id)popover;
- (void)saveDeactivationReason:(id)reason;
- (void)mustFlattenForResignActive:(id)active;
- (void)canExpandAfterBecomeActive:(id)active;
- (void)mustFlattenForNavigationTransition:(id)transition;
- (void)canExpandAfterNavigationTransition:(id)transition;
@end

#endif /* UITextSelectionView_h */