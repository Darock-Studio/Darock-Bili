//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKPassPersonalizationViewController_h
#define PKPassPersonalizationViewController_h
@import Foundation;

#include "UITableViewController.h"
#include "PKPassPersonalizationCellDelegate-Protocol.h"
#include "PKPassPersonalizationHeaderView.h"
#include "PKPassPersonalizationTermsViewControllerDelegate-Protocol.h"
#include "PKPassPersonalizationViewControllerDelegate-Protocol.h"

@class NSArray, NSString, PKContact, PKPass, UIBarButtonItem, UIButton;

@interface PKPassPersonalizationViewController : UITableViewController<PKPassPersonalizationCellDelegate, PKPassPersonalizationTermsViewControllerDelegate> {
  /* instance variables */
  PKPassPersonalizationHeaderView *_headerView;
  UIBarButtonItem *_personalizeNowButton;
  UIButton *_personalizeLaterButton;
  PKPass *_pass;
  NSString *_personalizationToken;
  PKContact *_contact;
  NSArray *_cellContexts;
  unsigned long long _personalizationSource;
  BOOL _hasScrolledToCells;
  BOOL _termsAndConditionsAccepted;
}

@property (weak, nonatomic) NSObject<PKPassPersonalizationViewControllerDelegate> *delegate;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithPass:(id)pass personalizationToken:(id)token personalizationSource:(unsigned long long)source;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)appear;
- (void)viewWillLayoutSubviews;
- (long long)numberOfSectionsInTableView:(id)view;
- (long long)tableView:(id)view numberOfRowsInSection:(long long)section;
- (id)tableView:(id)view cellForRowAtIndexPath:(id)path;
- (double)tableView:(id)view heightForRowAtIndexPath:(id)path;
- (double)tableView:(id)view heightForFooterInSection:(long long)section;
- (id)tableView:(id)view viewForFooterInSection:(long long)section;
- (BOOL)personalizationCellShouldBeginEditing:(id)editing;
- (void)personalizationCellDidChangeValue:(id)value;
- (BOOL)personalizationCellShouldReturn:(id)return;
- (void)scrollViewDidScroll:(id)scroll;
- (void)passPersonalizationTermsViewControllerDidAcceptTerms:(id)terms;
- (void)passPersonalizationTermsViewControllerDidDeclineTerms:(id)terms;
- (void)_personalizeNowButtonPressed:(id)pressed;
- (void)_personalizePass;
- (void)finishPersonalizationOfPassWithUniqueID:(id)id result:(BOOL)result;
- (BOOL)_contactReadyForPersonalization;
- (void)_scrollToCellsIfNeeded;
- (void)_configureHeaderViewForState:(unsigned long long)state;
- (void)_positionFooterView;
- (id)_nextCellForIndexPath:(id)path;
- (void)_presentPersonalizationErrorAlert;
@end

#endif /* PKPassPersonalizationViewController_h */