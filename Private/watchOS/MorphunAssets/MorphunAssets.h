//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3300.101.1.0.0
//
#ifndef MorphunAssets_h
#define MorphunAssets_h
@import Foundation;

@class NSLock, NSMutableDictionary, NSString, NSUserDefaults, UAFAssetSetObserver;

@interface MorphunAssets : NSObject

@property (retain, nonatomic) NSUserDefaults *subscriptionCache;
@property (retain, nonatomic) NSMutableDictionary *subscriptionView;
@property (retain) NSLock *subscriptionViewLock;
@property (retain, nonatomic) NSString *subscriptionProcessKey;
@property (retain) NSMutableDictionary *readyLanguages;
@property (retain, nonatomic) UAFAssetSetObserver *subscriptionAssetSetObserver;

/* class methods */
+ (void)initForSiriX:(id /* block */)x;
+ (id)get;
+ (id)subscriptionDbInitializerWithKey:(id)key;
+ (void)MorphunAssetsLazyInitIfNeeded;
+ (id)assetPathDB;
+ (void)observeUAFAssetSet;
+ (id)getUAFAssetSets;
+ (id)getUAFAssetSetForUsageValue:(id)value;
+ (id)getUAFAssetForLocale:(id)locale;
+ (id)getTRINamespaceName;
+ (id)validateLocale:(id)locale;
+ (BOOL)validateLanguageCode:(id)code;
+ (id)bcpStringForLocale:(id)locale;
+ (id)bcpStringForComponentArray:(id)array;
+ (id)componentArrayForLocale:(id)locale;
+ (id)getFactorSuffixForLocale:(id)locale;
+ (void)setTrialNamespaceToUse:(long long)use;
+ (long long)getCurrentNamespace;
+ (id)getCurrentNamespaceName;
+ (id)MorphunDomain;
+ (id)uLocaleToNSLocale:(const void *)nslocale;
+ (id)SupportedLanguages;
+ (id)SupportedSiriLanguages;
+ (id)SupportedLocales;
+ (id)SupportedSiriLocales;
+ (id)EmbeddedLanguages;
+ (id)EmbeddedLocales;
+ (BOOL)isLanguageEmbedded:(id)embedded;
+ (BOOL)isLocaleEmbedded:(id)embedded;
+ (BOOL)isLocaleDownloadSupported:(id)supported;
+ (long long)deliveryMethodForLocale:(id)locale;
+ (id)EmbeddedVersion;
+ (id)getAssetPathForLocale:(id)locale;
+ (id)getAssetPathForLocale:(id)locale withError:(id *)error;
+ (id)getUAFAssetSetName;
+ (id)getUAFAssetName;
+ (id)getUAFUsageType;
+ (id)getUAFUsageValueForLocale:(id)locale;
+ (id)getFactorNameForLocale:(id)locale;
+ (id)getAssetPathForCurrentSiriLanguage;
+ (id)blockingRemoveAssetForLocale:(id)locale withTimeout:(unsigned long long)timeout;
+ (void)removeAssetForLocale:(id)locale withCompletion:(id /* block */)completion;
+ (void)onDemandDownloadForLocale:(id)locale withProgress:(id /* block */)progress withCompletion:(id /* block */)completion;
+ (id)blockingOnDemandDownloadForLocale:(id)locale withTimeout:(unsigned long long)timeout withProgress:(id /* block */)progress;

/* instance methods */
- (id)init;
- (id)processSubscriptions;
- (void)readSubscriptionView;
- (void)writeSubscriptionView;
- (id)referenceCountsFromSubscriptionView;
- (void)downloadLocaleIfNeeded:(id)needed withCompletion:(id /* block */)completion;
- (void)removeLanguageIfNeeded:(id)needed;
- (void)subscribeToLocale:(id)locale withCompletion:(id /* block */)completion;
- (void)unsubscribeFromLocale:(id)locale;
- (BOOL)isSubscribedToLocale:(id)locale;
- (BOOL)isAssetReadyForLocale:(id)locale;
- (id)listSubscriptions;
- (id)getMorphunDataPathForLocale:(id)locale;
- (id)getMorphunDataPathForLocale:(id)locale withError:(id *)error;
@end

#endif /* MorphunAssets_h */