//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2206.0.5.0.0
//
#ifndef WFMPMediaContentItem_h
#define WFMPMediaContentItem_h
@import Foundation;

#include "WFGenericFileContentItem.h"
#include "WFContentItemClass-Protocol.h"
#include "WFObjectType.h"

@class MPMediaItem, NSDictionary, NSString, WFFileType;

@interface WFMPMediaContentItem : WFGenericFileContentItem<WFContentItemClass>

@property (readonly, nonatomic) MPMediaItem *mediaItem;
@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSString *artist;
@property (readonly, nonatomic) NSString *albumTitle;
@property (readonly, nonatomic) NSDictionary *metadataForSerialization;
@property (readonly, nonatomic) NSDictionary *additionalRepresentationsForSerialization;
@property (readonly, nonatomic) BOOL includesFileRepresentationInSerializedItem;
@property (readonly, nonatomic) BOOL hasStringOutput;
@property (readonly, nonatomic) WFFileType *preferredFileType;
@property (readonly, nonatomic) WFObjectType *preferredObjectType;
@property (readonly, nonatomic) BOOL cachesSupportedTypes;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)propertyBuilders;
+ (id)stringConversionBehavior;
+ (void)runQuery:(id)query withItems:(id)items permissionRequestor:(id)requestor completionHandler:(id /* block */)handler;
+ (id)ownedTypes;
+ (id)outputTypes;
+ (id)contentCategories;
+ (id)typeDescription;
+ (id)pluralTypeDescription;
+ (id)filterDescription;
+ (id)pluralFilterDescription;
+ (id)countDescription;
+ (BOOL)hasLibrary;
+ (BOOL)isAvailableOnPlatform:(long long)platform;

/* instance methods */
- (BOOL)getListSubtitle:(id /* block */)subtitle;
- (BOOL)getListAltText:(id /* block */)text;
- (BOOL)getListThumbnail:(id /* block */)thumbnail forSize:(struct CGSize { double x0; double x1; })size;
- (id)assetURL;
- (void)getPreferredFileSize:(id /* block */)size;
- (id)generateObjectRepresentationForClass:(Class)class options:(id)options error:(id *)error;
@end

#endif /* WFMPMediaContentItem_h */