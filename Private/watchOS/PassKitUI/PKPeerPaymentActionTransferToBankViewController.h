//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKPeerPaymentActionTransferToBankViewController_h
#define PKPeerPaymentActionTransferToBankViewController_h
@import Foundation;

#include "PKPeerPaymentActionViewController.h"
#include "PKAnimatedNavigationBarTitleView.h"
#include "PKEnterCurrencyAmountPassTableHeaderFooterView.h"
#include "PKEnterCurrencyAmountPassViewDelegate-Protocol.h"
#include "PKPeerPaymentActionControllerDelegate-Protocol.h"
#include "UITableViewDataSource-Protocol.h"
#include "UITableViewDelegate-Protocol.h"
#include "_PKVisibilityBackdropView.h"
#include "_PKVisibilityBackdropViewDelegate-Protocol.h"

@class NSArray, NSDecimalNumber, NSNumberFormatter, NSString, PKPaymentPass, UIImageView, UILabel, UITableView;

@interface PKPeerPaymentActionTransferToBankViewController : PKPeerPaymentActionViewController<_PKVisibilityBackdropViewDelegate, PKPeerPaymentActionControllerDelegate, UITableViewDelegate, UITableViewDataSource, PKEnterCurrencyAmountPassViewDelegate> {
  /* instance variables */
  NSArray *_supportedTransferActions;
  NSNumberFormatter *_currencyFormatter;
  NSNumberFormatter *_percentageFormatter;
  PKPaymentPass *_defaultInstantFundsOutPaymentPass;
  BOOL _isSmallPhone;
  BOOL _usesAccessibilityLayout;
  PKAnimatedNavigationBarTitleView *_passNavbarTitleView;
  UITableView *_tableView;
  UIImageView *_navbarPassView;
  _PKVisibilityBackdropView *_blurringView;
  UILabel *_footerTextLabel;
  PKEnterCurrencyAmountPassTableHeaderFooterView *_tableHeaderView;
  NSDecimalNumber *_feePercentage;
  NSDecimalNumber *_minimumFee;
  NSDecimalNumber *_maximumFee;
  double _backdropWeight;
}

@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithPaymentPass:(id)pass webService:(id)service passLibraryDataProvider:(id)provider context:(long long)context;
- (void)dealloc;
- (void)loadView;
- (void)viewWillLayoutSubviews;
- (id)tableView:(id)view cellForRowAtIndexPath:(id)path;
- (void)tableView:(id)view didSelectRowAtIndexPath:(id)path;
- (BOOL)tableView:(id)view shouldDrawTopSeparatorForSection:(long long)section;
- (long long)numberOfSectionsInTableView:(id)view;
- (long long)tableView:(id)view numberOfRowsInSection:(long long)section;
- (double)tableView:(id)view heightForRowAtIndexPath:(id)path;
- (void)scrollViewDidScroll:(id)scroll;
- (long long)visibilityBackdropView:(id)view preferredStyleForTraitCollection:(id)collection;
- (void)peerPaymentActionController:(id)controller hasChangedState:(unsigned long long)state;
- (id)presentationSceneIdentifierForPeerPaymentActionController:(id)controller;
- (void)updateAccountValues;
- (void)enterCurrencyAmountPassViewDidLoadPassSnapshot:(id)snapshot;
- (void)setMaxBalance:(id)balance;
- (void)setMinBalance:(id)balance;
- (void)setMaxLoadAmount:(id)amount;
- (void)setMinLoadAmount:(id)amount;
- (void)setCardBalance:(id)balance;
- (id)_transferBarButton;
- (id)_spinnerBarButton;
- (void)_updateBarButtonEnabledState;
- (void)_transferBarButtonPressed:(id)pressed;
- (void)_updateCurrentAmount:(id)amount shouldGenerateNewSuggestions:(BOOL)suggestions;
- (void)_currentAmountDidChangeTo:(id)to shouldGenerateNewSuggestions:(BOOL)suggestions;
- (BOOL)_isCurrentAmountValid;
- (void)_calculateBlur;
- (BOOL)_passViewInNavBar;
- (id)_indexPathForAction:(unsigned long long)action;
- (id)_calculateFee;
- (void)_updateTableHeaderHeight;
- (id)_amountPassView;
- (void)_updateFooterText;
- (id)_defaultInstantFundsOutPaymentPass;
- (void)_dismissViewController:(id)controller;
- (void)_showNavigationBarSpinner:(BOOL)spinner;
- (id)_detailTextForAction:(unsigned long long)action;
@end

#endif /* PKPeerPaymentActionTransferToBankViewController_h */