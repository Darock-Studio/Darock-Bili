//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.8.1.0.0
//
#ifndef CDMUAFAssetsManager_h
#define CDMUAFAssetsManager_h
@import Foundation;

@class NSArray, NSDictionary, NSMutableDictionary, NSString;

@interface CDMUAFAssetsManager : NSObject {
  /* instance variables */
  NSArray *_uafClientManagers;
  NSDictionary *_assetSetNameToUafClientManager;
  NSDictionary *_assetSetNameToFactors;
  NSDictionary *_factorToAssetSetName;
  NSMutableDictionary *_assetSetNameToObserver;
}

@property (readonly, nonatomic) NSString *locale;

/* class methods */
+ (id)getNLUAFClientManagers;
+ (void)reInitCDMUAFAssetsCache;
+ (id)getFactorsForClientManager:(id)manager;
+ (id)getAssistantUsages:(id)usages;
+ (id)getSsuUsages:(id)usages;
+ (id)getUAFClientManagersForLocale:(id)locale withGraphName:(id)name;
+ (id)getNLAssetFromUAFAsset:(id)uafasset withFactor:(id)factor withAssetSetName:(id)name;
+ (id)getNLAssetFromUAFAssetPostValidation:(id)validation asset:(id)asset locale:(id)locale assetSetName:(id)name;
+ (void)setAssetsAvailabilityForFactors:(id)factors withAssetSet:(id)set forAssetSetName:(id)name withDelegateHandler:(id)handler withFactorAndFolders:(id)folders useFileManager:(id)manager;
+ (BOOL)validateFactors:(id)factors inAssetSet:(id)set forLocale:(id)locale withAssetSetName:(id)name;
+ (void)subscribeToSsuAssetsForLocale:(id)locale;

/* instance methods */
- (id)initWithLocale:(id)locale withGraphName:(id)name;
- (void)setupWithError:(id *)error;
- (id)getAssetSetNameToUafClientManagerWithError:(id *)error;
- (id)populateAssetSetNameToFactorsForAssetSetNameToUafClientManager:(id)manager withError:(id *)error;
- (id)populateFactorToAssetSetNameForAssetSetNameToFactors:(id)factors withError:(id *)error;
- (id)filterFactors:(id)factors;
- (id)getUAFAssetsForFactors:(id)factors;
- (void)registerForFactors:(id)factors inAssetSetName:(id)name withAssetsDelegate:(id)delegate withFactorAndFolders:(id)folders useFileManager:(id)manager;
- (BOOL)areFactorsValid:(id)valid;
- (BOOL)registerForFactors:(id)factors withAssetsDelegate:(id)delegate withFactorAndFolders:(id)folders useFileManager:(id)manager withSelfContextId:(id)id withSelfMetadata:(id)metadata withDataDispatcherContext:(id)context;
- (id)getAssetSetNamesForFactorNames:(id)names;
- (BOOL)setAssetsProvisionalForFactors:(id)factors withSelfContextId:(id)id withSelfMetadata:(id)metadata withDataDispatcherContext:(id)context;
- (BOOL)setAssetsProvisionalForFactorNames:(id)names selfContextId:(id)id selfMetadata:(id)metadata dataDispatcherContext:(id)context;
- (BOOL)promoteAssetsForFactors:(id)factors withFailedFactors:(id)factors withSelfContextId:(id)id withSelfMetadata:(id)metadata withDataDispatcherContext:(id)context;
- (id)getUafClientManagerForAssetSetName:(id)name;
- (BOOL)promoteAssetsForAssetSetNames:(id)names selfContextId:(id)id selfMetadata:(id)metadata dataDispatcherContext:(id)context;
@end

#endif /* CDMUAFAssetsManager_h */