//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 582.60.2.0.0
//
#ifndef MCMParametersQuery_Protocol_h
#define MCMParametersQuery_Protocol_h
@import Foundation;

@protocol MCMParametersQuery 

@property (readonly, nonatomic) unsigned long long explicitFlags;
@property (readonly, nonatomic) NSSet *identifiers;
@property (readonly, nonatomic) unsigned long long containerClass;
@property (readonly, nonatomic) NSSet *groupIdentifiers;
@property (readonly, nonatomic) BOOL createIfNecessary;
@property (readonly, nonatomic) BOOL includeInfoInResult;
@property (readonly, nonatomic) BOOL includePathInResult;
@property (readonly, nonatomic) BOOL issueSandboxExtensions;
@property (readonly, nonatomic) unsigned int uid;
@property (readonly, nonatomic) MCMUserIdentity *userIdentity;
@property (readonly, nonatomic) BOOL transient;
@property (readonly, nonatomic) BOOL includeUnowned;
@property (readonly, nonatomic) BOOL expectSingleResult;
@property (readonly, nonatomic) BOOL fuzzyMatchTransient;
@property (readonly, nonatomic) BOOL fuzzyMatchInternalUUID;
@property (readonly, nonatomic) NSUUID *internalUUID;
@property (readonly, nonatomic) unsigned long long privateFlags;
@property (readonly, nonatomic) BOOL legacyPersonaPolicy;
@property (readonly, nonatomic) BOOL legacyExtensionPolicy;
@property (readonly, nonatomic) BOOL includeUserManagedAssetsRelPath;

@end

#endif /* MCMParametersQuery_Protocol_h */