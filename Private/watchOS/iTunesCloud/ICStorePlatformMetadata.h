//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4023.330.5.0.0
//
#ifndef ICStorePlatformMetadata_h
#define ICStorePlatformMetadata_h
@import Foundation;

@class NSArray, NSDate, NSDictionary, NSString, NSURL;

@interface ICStorePlatformMetadata : NSObject

@property (readonly, copy, nonatomic) NSDictionary *metadataDictionary;
@property (readonly, copy, nonatomic) NSString *artistName;
@property (readonly, nonatomic) long long artistStoreAdamID;
@property (readonly, copy, nonatomic) NSString *cloudUniversalLibraryID;
@property (readonly, copy, nonatomic) NSString *collectionName;
@property (readonly, nonatomic) long long collectionStoreAdamID;
@property (readonly, copy, nonatomic) NSString *composerName;
@property (readonly, copy, nonatomic) NSString *copyrightText;
@property (readonly, nonatomic) long long discNumber;
@property (readonly, nonatomic) double duration;
@property (readonly, copy, nonatomic) NSDate *expirationDate;
@property (readonly, nonatomic) long long explicitRating;
@property (readonly, nonatomic) BOOL isExplicit;
@property (readonly, copy, nonatomic) NSArray *genreNames;
@property (readonly, nonatomic) BOOL hasLyrics;
@property (readonly, nonatomic) BOOL hasTimeSyncedLyrics;
@property (readonly, copy, nonatomic) NSString *kind;
@property (readonly, nonatomic) long long movementCount;
@property (readonly, copy, nonatomic) NSString *movementName;
@property (readonly, nonatomic) long long movementNumber;
@property (readonly, copy, nonatomic) NSString *name;
@property (readonly, copy, nonatomic) NSArray *offers;
@property (readonly, copy, nonatomic) NSString *playlistGlobalID;
@property (readonly, copy, nonatomic) NSString *radioStationStringID;
@property (readonly, copy, nonatomic) NSDate *releaseDate;
@property (readonly, nonatomic) BOOL shouldShowComposer;
@property (readonly, nonatomic) long long storeAdamID;
@property (readonly, copy, nonatomic) NSArray *formerStoreAdamIDs;
@property (readonly, copy, nonatomic) NSString *title;
@property (readonly, nonatomic) long long trackNumber;
@property (readonly, nonatomic) long long trackCount;
@property (readonly, copy, nonatomic) NSString *workName;
@property (readonly, copy, nonatomic) NSArray *artworkInfos;
@property (readonly, copy, nonatomic) NSArray *audioTraits;
@property (readonly, copy, nonatomic) NSURL *classicalURL;
@property (readonly, nonatomic) BOOL supportsVocalAttenuation;

/* class methods */
+ (id)storeServerCalendar;

/* instance methods */
- (id)initWithMetadataDictionary:(id)dictionary;
- (id)initWithMetadataDictionary:(id)dictionary expirationDate:(id)date;
- (id)offerWithType:(id)type;
- (id)_storePlatformReleaseDateFormatter;
@end

#endif /* ICStorePlatformMetadata_h */