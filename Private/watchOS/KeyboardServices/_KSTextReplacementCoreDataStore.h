//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 157.200.0.0.0
//
#ifndef _KSTextReplacementCoreDataStore_h
#define _KSTextReplacementCoreDataStore_h
@import Foundation;

@class NSManagedObjectContext, NSManagedObjectModel, NSPersistentStoreCoordinator, NSString;
@protocol OS_dispatch_queue;

@interface _KSTextReplacementCoreDataStore : NSObject {
  /* instance variables */
  NSObject<OS_dispatch_queue> *_queueMOC;
  NSObject<OS_dispatch_queue> *_queuePSC;
}

@property (retain, nonatomic) NSString *directoryPath;
@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/* class methods */
+ (id)localCloudEntryFromMocObject:(id)object;

/* instance methods */
- (id)init;
- (id)initWithDirectoryPath:(id)path;
- (void)cleanup;
- (void)dealloc;
- (id)persistentStore;
- (BOOL)recordTextReplacementEntries:(id)entries;
- (void)fetchAndMergeTextReplacementEntry:(id)entry context:(id)context;
- (id)fetchTextReplacementEntry:(id)entry context:(id)context;
- (id)fetchTextReplacementWithUniqueName:(id)name context:(id)context;
- (BOOL)markDeletesForTextReplacementEntries:(id)entries;
- (BOOL)deleteTextReplacementsFromLocalStoreWithNames:(id)names excludeSavesToCloud:(BOOL)cloud;
- (BOOL)deleteTextReplacementsWithPredicate:(id)predicate;
- (id)textReplacementEntriesWithLimit:(unsigned long long)limit;
- (unsigned long long)countEntriesWithPredicate:(id)predicate;
- (id)queryEntriesWithPredicate:(id)predicate limit:(unsigned long long)limit;
- (id)queryManagedObjectsWithPredicate:(id)predicate limit:(unsigned long long)limit;
- (void)saveCKFetchToken:(id)token;
- (id)getCKFetchToken;
- (BOOL)didMakeInitialPull;
- (id)syncStateEntryShouldSave:(BOOL)save fetchToken:(id)token;
@end

#endif /* _KSTextReplacementCoreDataStore_h */