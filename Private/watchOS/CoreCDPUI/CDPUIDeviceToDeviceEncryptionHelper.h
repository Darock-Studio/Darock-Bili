//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 359.4.1.2.1
//
#ifndef CDPUIDeviceToDeviceEncryptionHelper_h
#define CDPUIDeviceToDeviceEncryptionHelper_h
@import Foundation;

#include "CDPUIDeviceToDeviceEncryptionFlowContext.h"
#include "CDPUIDeviceToDeviceEncryptionPasscodeValidationDelegate-Protocol.h"

@class AKAppleIDAuthenticationController, NSString, PUICNavigationController, UIViewController;
@protocol CDPLocalSecretFollowUpProvider, CDPUIDeviceToDeviceEncryptionHelperDelegate;

@interface CDPUIDeviceToDeviceEncryptionHelper : NSObject<CDPUIDeviceToDeviceEncryptionPasscodeValidationDelegate> {
  /* instance variables */
  AKAppleIDAuthenticationController *_authenticationController;
  PUICNavigationController *_navigationController;
  UIViewController *_initialTopViewController;
}

@property (retain, nonatomic) NSObject<CDPLocalSecretFollowUpProvider> *followUpProvider;
@property (readonly, weak, nonatomic) UIViewController *presentingViewController;
@property (weak, nonatomic) NSObject<CDPUIDeviceToDeviceEncryptionHelperDelegate> *delegate;
@property (readonly, nonatomic) CDPUIDeviceToDeviceEncryptionFlowContext *context;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)_newLegacyFlowContext;
+ (id)_newLegacyFlowContextForAltDSID:(id)dsid;
+ (id)_newLegacyFlowContextWithContext:(id)context;

/* instance methods */
- (id)initWithContext:(id)context;
- (id)initWithPresentingViewController:(id)controller;
- (void)dealloc;
- (void)performDeviceToDeviceEncryptionStateRepairWithCompletion:(id /* block */)completion;
- (void)performDeviceToDeviceEncryptionStateRepairForContext:(id)context withCompletion:(id /* block */)completion;
- (void)_configurePresentingViewControllerForModalPresentation;
- (void)_beginUpgradeFlowWithContext:(id)context completion:(id /* block */)completion;
- (void)_continueUpgradeFlowWithContext:(id)context completion:(id /* block */)completion;
- (void)_continueAuthenticatedUpgradeFlowWithContext:(id)context authenticationResults:(id)results completion:(id /* block */)completion;
- (void)_performAuthenticatedRepairFlowWithContext:(id)context stateController:(id)controller completion:(id /* block */)completion;
- (void)_determineUpgradeEligibilityForContext:(id)context completion:(id /* block */)completion;
- (void)_determineSecurityUpgradeEligibilityForContext:(id)context completion:(id /* block */)completion;
- (void)_determineManateeUpgradeEligibilityForContext:(id)context completion:(id /* block */)completion;
- (void)_determineEscrowRepairUpgradeEligibilityForContext:(id)context completion:(id /* block */)completion;
- (void)_validateLocalSecretForContext:(id)context withStateController:(id)controller completion:(id /* block */)completion;
- (void)_createLocalSecretForContext:(id)context completion:(id /* block */)completion;
- (void)_presentIneligibilityAlertForFlowContext:(id)context completion:(id /* block */)completion;
- (void)_requestPermissionToCreatePasscodeForFlowContext:(id)context completion:(id /* block */)completion;
- (void)_presentSpinnerViewControllerWithCompletion:(id /* block */)completion;
- (id)_authenticationContextForFlowContext:(id)context;
- (id)_inAppAuthenticationContextForFlowContext:(id)context;
- (id)_authenticationController;
- (id)_newUpgradeUIProvider;
- (id)_presentingViewController;
- (id)_presentingNavigationController;
- (id)_navigationController;
- (void)_configureNavigationController;
- (void)_dismissNavigationControllerWithCompletion:(id /* block */)completion;
- (id)_stateControllerForFlowContext:(id)context withAuthenticationResults:(id)results;
- (id)_repairContextForFlowContext:(id)context withAuthenticationResults:(id)results;
- (id)_stateControllerWithRepairContext:(id)context;
- (id)_cdpErrorWithUnderlyingError:(id)error;
- (BOOL)_hasLocalSecret;
- (BOOL)_hasManatee;
- (BOOL)_inCircle;
- (void)_postBiometricFollowUp;
- (id)_newSpinnerViewController;
- (void)localSecretValidationCanCancelWithViewController:(id)controller completion:(id /* block */)completion;
@end

#endif /* CDPUIDeviceToDeviceEncryptionHelper_h */