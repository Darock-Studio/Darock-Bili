//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3.26.3.6.0
//
#ifndef DMCProfileDetailsViewController_h
#define DMCProfileDetailsViewController_h
@import Foundation;

#include "DMCProfileTableViewController.h"
#include "DMCProfileViewModel.h"

@class NSArray, NSString;

@interface DMCProfileDetailsViewController : DMCProfileTableViewController

@property (retain, nonatomic) DMCProfileViewModel *profileViewModel;
@property (nonatomic) BOOL showTitleIfOnlyOneSection;
@property (nonatomic) BOOL viewControllerCanPop;
@property (nonatomic) BOOL shouldShowWarningText;
@property (retain, nonatomic) NSArray *sections;
@property (nonatomic) int mode;
@property (nonatomic) double tableViewBottomInset;
@property (copy, nonatomic) NSString *tableTitle;

/* instance methods */
- (id)initWithProfileViewModel:(id)model;
- (id)initWithProfileViewModel:(id)model mode:(int)mode;
- (void)_setup;
- (void)viewWillAppear:(BOOL)appear;
- (void)viewDidAppear:(BOOL)appear;
- (void)viewWillDisappear:(BOOL)disappear;
- (void)dealloc;
- (void)_profileChanged:(id)changed;
- (void)_reloadTable:(id)table;
- (void)setProfileDetailsMode:(int)mode;
- (void)setProfileViewModel:(id)model mode:(int)mode;
- (void)reloadSectionArray;
- (void)_updateStateForCurrentMode;
- (long long)numberOfSectionsInTableView:(id)view;
- (id)tableView:(id)view titleForHeaderInSection:(long long)section;
- (id)tableView:(id)view titleForFooterInSection:(long long)section;
- (long long)tableView:(id)view numberOfRowsInSection:(long long)section;
- (id)tableView:(id)view cellForRowAtIndexPath:(id)path;
- (void)tableView:(id)view didSelectRowAtIndexPath:(id)path;
- (void)_doneButtonTapped:(id)tapped;
@end

#endif /* DMCProfileDetailsViewController_h */