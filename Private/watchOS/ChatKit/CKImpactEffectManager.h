//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1262.300.81.4.10
//
#ifndef CKImpactEffectManager_h
#define CKImpactEffectManager_h
@import Foundation;

#include "CKAudioController.h"
#include "CKAudioControllerDelegate-Protocol.h"
#include "CKBalloonView.h"
#include "CKSendAnimationManager-Protocol.h"
#include "CKSendAnimationManagerDelegate-Protocol.h"

@class CABackdropLayer, NSIndexSet, NSString, UIScrollView, UIWindow;
@protocol CKSendAnimationBalloonProvider;

@interface CKImpactEffectManager : NSObject<CKAudioControllerDelegate, CKSendAnimationManager>

@property (retain, nonatomic) UIWindow *expressiveSendAnimationWindow;
@property (retain, nonatomic) CKBalloonView *expressiveSendAnimationBalloon;
@property (retain, nonatomic) CKBalloonView *originalBalloonView;
@property (retain, nonatomic) UIScrollView *expressiveSendScrollView;
@property (retain, nonatomic) CABackdropLayer *expressiveSendAnimationBackdrop;
@property (retain, nonatomic) CKAudioController *audioController;
@property (nonatomic) BOOL isAnimating;
@property (retain, nonatomic) NSIndexSet *undoSendChatItems;
@property (weak, nonatomic) NSObject<CKSendAnimationManagerDelegate> *delegate;
@property (readonly, nonatomic) NSString *animatingIdentifier;
@property (nonatomic) BOOL isDisabled;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;
@property (weak, nonatomic) NSObject<CKSendAnimationManagerDelegate> *sendAnimationManagerDelegate;
@property (weak, nonatomic) NSObject<CKSendAnimationBalloonProvider> *sendAnimationBalloonProvider;

/* class methods */
+ (id)effectIdentifiers;
+ (id)maskingStringForID:(id)id;
+ (BOOL)identifierIsValidImpactEffect:(id)effect;
+ (BOOL)identifierIsAnimatedImpactEffect:(id)effect;
+ (BOOL)identifierShouldPlayInWindow:(id)window;
+ (id)localizedEffectNameForEffectWithIdentifier:(id)identifier;

/* instance methods */
- (id)init;
- (void)animateMessages:(id)messages;
- (void)animateMessages:(id)messages withEffectIdentifier:(id)identifier beginAnimationFromTranscriptPresentedState:(BOOL)state;
- (void)setupAudioPlayerWithURL:(id)url;
- (void)playSoundForEffectIdentifier:(id)identifier;
- (void)playSoundForPopAnimation;
- (void)playUndoSendAnimationForChatItem:(id)item;
- (void)_animateLastMessage:(id)message withEffectIdentifier:(id)identifier beginAnimationFromTranscriptPresentedState:(BOOL)state;
- (void)_renderEffectInView;
- (void)_renderEffectInWindow;
- (void)matchScrollViewOffset:(id)offset;
- (void)stopAllEffects;
- (void)_sizeAnimationWindow;
- (id)_sendAnimationContextForIdentifier:(id)identifier message:(id)message isSender:(BOOL)sender beginAnimationFromTranscriptPresentedState:(BOOL)state;
- (id)cloneBalloonForAnimationWithChatItem:(id)item;
- (void)popAnimationDidBegin;
- (void)animationWillBeginWithContext:(id)context;
- (void)animationDidFinishWithContext:(id)context;
- (void)_visibleCells:(id *)cells aboveItem:(id)item;
- (void)_cleanupExpressiveSendComponents;
- (void)dealloc;
- (void)_audioSessionOptionsWillChange:(id)change;
- (void)stopPlayingSound;
@end

#endif /* CKImpactEffectManager_h */