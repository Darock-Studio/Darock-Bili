//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2653.2.1.0.0
//
#ifndef DAContainerProvider_h
#define DAContainerProvider_h
@import Foundation;

@interface DAContainerProvider : NSObject
/* class methods */
+ (id)providerWithContactStore:(id)store;
+ (id)providerWithAddressBook:(void *)book;

/* instance methods */
- (id)containerWithExternalIdentifier:(id)identifier forAccountWithExternalIdentifier:(id)identifier;
- (id)allContainers;
- (id)allContainersForAccountWithExternalIdentifier:(id)identifier;
- (id)createNewContainerWithType:(int)type name:(id)name externalIdentifier:(id)identifier constraintsPath:(id)path syncData:(id)data contentReadonly:(BOOL)readonly propertiesReadonly:(BOOL)readonly forAccount:(id)account;
- (void)setDefaultContainer:(id)container withLocalDBHelper:(id)dbhelper onlyIfNotSet:(BOOL)set;
- (BOOL)setLastSyncDateForContainer:(id)container;
- (void)mergeAllRecordsIntoContainer:(id)container shouldInsertChangeHistoryRecords:(BOOL)records;
@end

#endif /* DAContainerProvider_h */