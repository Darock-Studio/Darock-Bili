//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3628.0.0.0.0
//
#ifndef CNVCard30CardBuilder_h
#define CNVCard30CardBuilder_h
@import Foundation;

#include "CNVCardLineFactory-Protocol.h"
#include "CNVCardPerson-Protocol.h"

@class NSMutableArray;

@interface CNVCard30CardBuilder : NSObject

@property (readonly, nonatomic) NSObject<CNVCardPerson> *person;
@property (readonly, nonatomic) NSMutableArray *lines;
@property (nonatomic) long long groupCount;
@property (nonatomic) unsigned long long countOfLinesBeforePhoto;
@property (readonly, copy, nonatomic) id /* block */ retrofitPhoto;
@property (nonatomic) BOOL photoHandled;
@property (readonly, nonatomic) NSMutableArray *unknownProperties;
@property (readonly, nonatomic) NSObject<CNVCardLineFactory> *lineFactory;

/* class methods */
+ (id)builderWithPerson:(id)person;
+ (unsigned long long)estimatedBytesAvailableForPhotoWithOptions:(id)options serializer:(id)serializer;

/* instance methods */
- (id)initWithPerson:(id)person;
- (void)buildWithSerializer:(id)serializer;
- (void)removeUnknownPropertiesWithTag:(id)tag;
- (void)addLineWithName:(id)name value:(id)value;
- (void)addBeginningOfCard;
- (void)addEndOfCard;
- (void)addNameLines;
- (void)addNameComponents;
- (void)addFullName;
- (void)addAddressingGrammar;
- (void)addOrganization;
- (void)addEmailAddresses;
- (void)addPhoneNumbers;
- (void)addPostalAddresses;
- (void)addSocialProfiles;
- (void)addActivityAlerts;
- (void)addNote;
- (void)addURLs;
- (void)addCalendarURIs;
- (void)addBirthday;
- (void)addAlternateBirthday;
- (void)addOtherDates;
- (void)addRelatedNames;
- (void)addCompanyMarker;
- (void)addNameOrderMarker;
- (void)addCategories;
- (void)addUnknownProperties;
- (void)addCardDAVUID;
- (void)addUID;
- (void)addPhonemeData;
- (void)addPreferredLikenessSource;
- (void)addPreferredApplePersonaIdentifier;
- (void)addDowntimeWhitelist;
- (void)addImageType;
- (void)addImageHash;
- (void)addWallpaper;
- (void)addWatchWallpaperImageData;
- (void)addSharedPhotoDisplayPreference;
- (void)addImageBackgroundColorsData;
- (void)addInstantMessagingInfo;
- (void)addInstantMessagingHandles:(id)handles;
- (void)addLegacyInstantMessagingHandles:(id)handles forService:(id)service vCardProperty:(id)property;
- (void)addPhotoWithOptions:(id)options;
- (BOOL)addPhotoReferences;
- (void)preparePhotoLineWithOptions:(id)options;
- (void)_addAttributesForCropRects:(id)rects imageHash:(id)hash toLine:(id)line;
- (void)addPropertyLinesForValues:(id)values generator:(id)generator;
@end

#endif /* CNVCard30CardBuilder_h */