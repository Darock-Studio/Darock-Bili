//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKPeerPaymentAssociatedAccountsController_h
#define PKPeerPaymentAssociatedAccountsController_h
@import Foundation;

#include "PKContactAvatarManager.h"
#include "PKPeerPaymentAssociatedAccountControllerDoneTapHelper.h"
#include "PKPeerPaymentAssociatedAccountPresentationContext.h"
#include "PKPeerPaymentAssociatedAccountSetupDelegate-Protocol.h"

@class NSString, PKFamilyMemberCollection, PKPaymentService, PKPeerPaymentAccount, PKPeerPaymentService, UINavigationController;
@protocol PKPassLibraryDataProvider;

@interface PKPeerPaymentAssociatedAccountsController : NSObject<PKPeerPaymentAssociatedAccountSetupDelegate> {
  /* instance variables */
  long long _context;
  PKPaymentService *_paymentService;
  PKPeerPaymentService *_peerPaymentService;
  PKPeerPaymentAccount *_account;
  PKFamilyMemberCollection *_familyCollection;
  PKContactAvatarManager *_avatarManager;
  UINavigationController *_navigationController;
  PKPeerPaymentAssociatedAccountPresentationContext *_presentationContext;
  PKPeerPaymentAssociatedAccountControllerDoneTapHelper *_doneTapHelper;
  NSString *_viewerFamilyMemberTypeAnalyticsKey;
  NSObject<PKPassLibraryDataProvider> *_passLibraryDataProvider;
  BOOL _didBeginReporter;
}

@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithFamilyCollection:(id)collection avatarManager:(id)manager passLibraryDataProvider:(id)provider context:(long long)context;
- (void)presentAssociatedAccountsFlowWithPresentationContext:(id)context fromNavigationController:(id)controller;
- (void)addPeerPaymentAssociatedAccountSetupCompletedWithSucess:(BOOL)sucess updatedAccount:(id)account forFamilyMember:(id)member;
- (void)addPeerPaymentAssociatedAccountDidSkipSetupForFamilyMember:(id)member;
- (void)_endReportingSessionIfNecessary;
- (void)_begingReportingIfNecessary;
- (void)_peerPaymentAccountChanged:(id)changed;
@end

#endif /* PKPeerPaymentAssociatedAccountsController_h */