//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1004.0.0.0.0
//
#ifndef REMAccountsDataView_h
#define REMAccountsDataView_h
@import Foundation;

#include "REMStore.h"

@interface REMAccountsDataView : NSObject

@property (readonly, nonatomic) REMStore *store;

/* instance methods */
- (id)initWithStore:(id)store;
- (id)fetchAllAccountsWithError:(id *)error;
- (id)fetchAllAccountsForAccountManagementWithError:(id *)error;
- (id)fetchAllAccountsForDumpingWithError:(id *)error;
- (id)fetchPrimaryActiveCloudKitAccountREMObjectIDWithError:(id *)error;
- (id)fetchPrimaryActiveCloudKitAccountWithError:(id *)error;
- (id)fetchActiveCloudKitAccountObjectIDsWithFetchOption:(long long)option error:(id *)error;
- (id)fetchAccountWithObjectID:(id)id error:(id *)error;
- (id)fetchAccountsWithObjectIDs:(id)ids error:(id *)error;
- (id)fetchAccountWithExternalIdentifier:(id)identifier error:(id *)error;
- (id)fetchAccountsWithExternalIdentifiers:(id)identifiers error:(id *)error;
- (id)accountsFromStorages:(id)storages;
@end

#endif /* REMAccountsDataView_h */