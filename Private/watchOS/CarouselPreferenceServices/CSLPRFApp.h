//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1112.2.15.0.0
//
#ifndef CSLPRFApp_h
#define CSLPRFApp_h
@import Foundation;

#include "CSLPRFApplication-Protocol.h"

@class BBSectionInfo, LSApplicationRecord, NSArray, NSString, NSURL;

@interface CSLPRFApp : NSObject<CSLPRFApplication> {
  /* instance variables */
  LSApplicationRecord *_lock_applicationRecord;
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _lock;
  BBSectionInfo *_bbSectionInfo;
}

@property (copy, @dynamic, nonatomic) NSString *bundleID;
@property (copy, @dynamic, nonatomic) NSString *name;
@property (copy, @dynamic, nonatomic) NSString *sdkVersion;
@property (readonly, copy, nonatomic) NSString *bundleIdentifier;
@property (readonly, copy, nonatomic) NSString *localizedName;
@property (readonly, copy, nonatomic) NSString *SDKVersion;
@property (readonly, nonatomic) BOOL supportsAlwaysOnDisplay;
@property (readonly, nonatomic) BOOL defaultsToPrivateAlwaysOnDisplayTreatment;
@property (readonly, copy, nonatomic) NSArray *counterpartIdentifiers;
@property (readonly, nonatomic) BOOL local;
@property (readonly, nonatomic) NSURL *URL;
@property (readonly, weak, nonatomic) LSApplicationRecord *applicationRecord;
@property (readonly, nonatomic) BOOL isRemovedSystemApp;
@property (readonly, nonatomic) BOOL isBBSourcedApplication;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)appWithBundleID:(id)id name:(id)name sdkVersion:(id)version supportsAlwaysOnDisplay:(BOOL)display defaultsToPrivateAlwaysOnDisplayTreatment:(BOOL)treatment;
+ (id)appWithACXRemoteApplication:(id)application;
+ (id)appWithApplicationRecord:(id)record;

/* instance methods */
- (id)initWithBundleIdentifier:(id)identifier localizedName:(id)name sdkVersion:(id)version supportsAlwaysOnDisplay:(BOOL)display defaultsToPrivateAlwaysOnDisplayTreatment:(BOOL)treatment applicationRecord:(id)record bbSectionInfo:(id)info;
- (long long)compare:(id)compare;
- (BOOL)isEqual:(id)equal;
- (BOOL)isLocal;
- (id)bbSectionInfo;
@end

#endif /* CSLPRFApp_h */