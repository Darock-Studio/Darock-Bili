//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 396.4.0.0.0
//
#ifndef TRINamespaceDescriptor_h
#define TRINamespaceDescriptor_h
@import Foundation;

#include "TRIAppContainer.h"

@class NSSet, NSString, NSURL;

@interface TRINamespaceDescriptor : NSObject

@property (readonly, nonatomic) NSString *namespaceName;
@property (readonly, nonatomic) unsigned int downloadNCV;
@property (readonly, nonatomic) NSURL *factorsURL;
@property (readonly, nonatomic) TRIAppContainer *appContainer;
@property (readonly, nonatomic) NSSet *upgradeNCVs;
@property (readonly, nonatomic) int cloudKitContainerId;
@property (readonly, nonatomic) NSString *resourceAttributionIdentifier;
@property (readonly, nonatomic) BOOL expensiveNetworkingAllowed;
@property (readonly, nonatomic) BOOL enableFetchDuringSetupAssistant;
@property (readonly, nonatomic) int purgeabilityLevel;
@property (readonly, nonatomic) BOOL availableToRootUser;

/* class methods */
+ (id)descriptorPathForNamespaceName:(id)name fromDirectory:(id)directory;
+ (id)loadFromFile:(id)file;
+ (id)loadWithNamespaceName:(id)name fromDirectory:(id)directory;
+ (BOOL)removeDescriptorWithNamespaceName:(id)name fromDirectory:(id)directory;
+ (id)descriptorsForDirectory:(id)directory filterBlock:(id /* block */)block;
+ (void)enumerateDescriptorsInDirectory:(id)directory block:(id /* block */)block;

/* instance methods */
- (id)initWithNamespaceName:(id)name downloadNCV:(unsigned int)ncv optionalParams:(id)params;
- (id)initWithDictionary:(id)dictionary;
- (id)factorsAbsolutePathAsOwner:(BOOL)owner;
- (id)dictionary;
- (BOOL)writeToFile:(id)file;
- (BOOL)saveToDirectory:(id)directory;
- (BOOL)removeFromDirectory:(id)directory;
- (BOOL)_upgradeNCVsIsValid:(id)valid;
- (BOOL)_upgradeNCVsArePositiveIntegers:(id)integers;
- (BOOL)_isEqualToNamespaceDescriptor:(id)descriptor;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
@end

#endif /* TRINamespaceDescriptor_h */