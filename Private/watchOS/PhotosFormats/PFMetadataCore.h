//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef PFMetadataCore_h
#define PFMetadataCore_h
@import Foundation;

#include "NSCopying-Protocol.h"
#include "PFHEVCProfileInformation.h"
#include "PFMetadata-Protocol.h"
#include "PFMetadataTypeVerifier.h"
#include "PFTimeZoneLookup.h"

@class CLLocation, NSArray, NSData, NSDate, NSDictionary, NSNumber, NSString, NSTimeZone, NSURL, UTType;

@interface PFMetadataCore : NSObject<PFMetadata, NSCopying> {
  /* instance variables */
  NSNumber *_pixelWidth;
  NSNumber *_pixelHeight;
  PFTimeZoneLookup *_cachedTimeZoneLookup;
}

@property (retain, nonatomic) PFMetadataTypeVerifier *typeVerifier;
@property (nonatomic) long long sourceType;
@property (retain, nonatomic) PFTimeZoneLookup *timeZoneLookup;
@property (nonatomic) unsigned char detail;
@property (retain, nonatomic) NSURL *fileURL;
@property (retain, nonatomic) UTType *contentType;
@property (nonatomic) long long orientation;
@property (retain, nonatomic) NSDictionary *fileSystemProperties;
@property (retain, nonatomic) NSDate *utcCreationDate;
@property (nonatomic) long long creationDateSource;
@property (retain, nonatomic) NSDate *creationDate;
@property (retain, nonatomic) NSString *creationDateString;
@property (retain, nonatomic) NSTimeZone *timeZone;
@property (retain, nonatomic) CLLocation *gpsLocation;
@property (retain, nonatomic) NSNumber *latitude;
@property (retain, nonatomic) NSNumber *longitude;
@property (retain, nonatomic) NSNumber *altitude;
@property (retain, nonatomic) NSNumber *speed;
@property (retain, nonatomic) NSDate *gpsDateTime;
@property (retain, nonatomic) NSNumber *isSpatialMediaValue;
@property (nonatomic) long long spatialVideoRecommendationForImmersiveMode;
@property (readonly, nonatomic) NSString *originalFileName;
@property (readonly, nonatomic) unsigned long long fileSize;
@property (readonly, nonatomic) NSDate *fileCreationDate;
@property (readonly, nonatomic) NSDate *fileModificationDate;
@property (readonly, nonatomic) struct CGSize { double x0; double x1; } exifPixelSize;
@property (readonly, nonatomic) struct CGSize { double x0; double x1; } orientedPixelSize;
@property (readonly, nonatomic) NSString *timeZoneName;
@property (readonly, nonatomic) NSNumber *timeZoneOffset;
@property (readonly, nonatomic) BOOL isImage;
@property (readonly, nonatomic) BOOL isMovie;
@property (readonly, nonatomic) NSString *cameraMake;
@property (readonly, nonatomic) NSString *cameraModel;
@property (readonly, nonatomic) NSString *captionAbstract;
@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSString *spatialOverCaptureIdentifier;
@property (readonly, nonatomic) BOOL isSpatialOverCapture;
@property (readonly, nonatomic) BOOL isHDR;
@property (readonly, nonatomic) BOOL isHDR_TS22028_5;
@property (readonly, nonatomic) BOOL isHDR_ExtendedRange;
@property (readonly, nonatomic) NSString *livePhotoPairingIdentifier;
@property (readonly, nonatomic) NSString *originatingAssetIdentifier;
@property (readonly, nonatomic) NSString *renderOriginatingAssetIdentifier;
@property (readonly, nonatomic) NSString *artworkContentDescription;
@property (readonly, nonatomic) NSArray *keywords;
@property (readonly, nonatomic) NSDictionary *syndicationProperties;
@property (readonly, nonatomic) BOOL isSyndicationOriginated;
@property (readonly, nonatomic) BOOL isSpatialMedia;
@property (readonly, nonatomic) NSNumber *playbackVariation;
@property (readonly, nonatomic) NSDictionary *cgImageProperties;
@property (readonly, nonatomic) NSData *imageData;
@property (readonly, nonatomic) struct CGImageSource * imageSource;
@property (readonly, nonatomic) struct CGImageMetadata * cgImageMetadata;
@property (readonly, nonatomic) NSString *speedRef;
@property (readonly, nonatomic) NSNumber *gpsHPositioningError;
@property (readonly, nonatomic) NSNumber *imageDirection;
@property (readonly, nonatomic) NSString *imageDirectionRef;
@property (readonly, nonatomic) BOOL isDeferredPhotoProxy;
@property (readonly, nonatomic) BOOL isDeferredPhotoProxyExpectingDepth;
@property (readonly, nonatomic) BOOL hasCustomRendered;
@property (readonly, nonatomic) long long customRendered;
@property (readonly, nonatomic) BOOL isPanorama;
@property (readonly, nonatomic) BOOL isPortrait;
@property (readonly, nonatomic) BOOL hasDepthDataAndIsNotRenderedSDOF;
@property (readonly, nonatomic) NSArray *focusPoints;
@property (readonly, nonatomic) NSNumber *focusMode;
@property (readonly, nonatomic) NSNumber *focusDistance;
@property (readonly, nonatomic) NSNumber *exposureBias;
@property (readonly, nonatomic) BOOL flashFired;
@property (readonly, nonatomic) NSNumber *flashValue;
@property (readonly, nonatomic) NSNumber *flashCompensation;
@property (readonly, nonatomic) NSNumber *focalLength;
@property (readonly, nonatomic) NSNumber *focalLengthIn35mm;
@property (readonly, nonatomic) NSNumber *digitalZoomRatio;
@property (readonly, nonatomic) NSNumber *iso;
@property (readonly, nonatomic) NSNumber *meteringMode;
@property (readonly, nonatomic) NSNumber *exposureTime;
@property (readonly, nonatomic) NSNumber *whiteBalance;
@property (readonly, nonatomic) NSNumber *whiteBalanceIndex;
@property (readonly, nonatomic) NSNumber *lightSource;
@property (readonly, nonatomic) NSNumber *fNumber;
@property (readonly, nonatomic) NSNumber *brightness;
@property (readonly, nonatomic) struct CGColorSpace * cgColorSpace;
@property (readonly, nonatomic) NSString *lensMake;
@property (readonly, nonatomic) NSString *lensModel;
@property (readonly, nonatomic) NSNumber *lensMinimumMM;
@property (readonly, nonatomic) NSNumber *lensMaximumMM;
@property (readonly, nonatomic) NSString *cameraSerialNumber;
@property (readonly, nonatomic) NSString *ownerName;
@property (readonly, nonatomic) NSString *firmware;
@property (readonly, nonatomic) NSString *burstUuid;
@property (readonly, nonatomic) NSString *groupingUuid;
@property (readonly, nonatomic) NSString *deferredPhotoProcessingIdentifier;
@property (readonly, nonatomic) NSString *imageCaptureRequestIdentifier;
@property (readonly, nonatomic) NSString *photoProcessingIdentifier;
@property (readonly, nonatomic) NSNumber *hdrGain;
@property (readonly, nonatomic) NSDictionary *hdrGainMap;
@property (readonly, nonatomic) BOOL hasHDRGainMap;
@property (readonly, nonatomic) NSNumber *hdrGainMapPercentageValue;
@property (readonly, nonatomic) BOOL isSDOF;
@property (readonly, nonatomic) NSString *profileName;
@property (readonly, nonatomic) NSNumber *GIFDelayTime;
@property (readonly, nonatomic) NSNumber *HEICSDelayTime;
@property (readonly, nonatomic) unsigned long long photoProcessingFlags;
@property (readonly, nonatomic) NSString *portraitInLandscapeCamera;
@property (readonly, nonatomic) BOOL isPhotoBooth;
@property (readonly, nonatomic) BOOL isScreenshot;
@property (readonly, nonatomic) NSString *userComment;
@property (readonly, nonatomic) NSString *defaultProfileName;
@property (readonly, nonatomic) NSNumber *semanticStyleToneBias;
@property (readonly, nonatomic) NSNumber *semanticStyleWarmthBias;
@property (readonly, nonatomic) NSNumber *semanticStyleRenderingVersion;
@property (readonly, nonatomic) NSNumber *semanticStylePreset;
@property (readonly, nonatomic) BOOL isFrontFacingCamera;
@property (readonly, nonatomic) BOOL isProRAW;
@property (readonly, nonatomic) unsigned long long photosAppFeatureFlags;
@property (readonly, nonatomic) NSNumber *nrfSrlStatus;
@property (readonly, nonatomic) NSNumber *srlCompensationValue;
@property (readonly, nonatomic) BOOL isAutoloop;
@property (readonly, nonatomic) BOOL isLoopingVideo;
@property (readonly, nonatomic) BOOL isMirror;
@property (readonly, nonatomic) BOOL isLongExposure;
@property (readonly, nonatomic) BOOL isAutoLivePhoto;
@property (readonly, nonatomic) NSNumber *livePhotoVitalityScore;
@property (readonly, nonatomic) BOOL hasVitality;
@property (readonly, nonatomic) BOOL livePhotoVitalityLimitingAllowed;
@property (readonly, nonatomic) struct { long long x0; int x1; unsigned int x2; long long x3; } duration;
@property (readonly, nonatomic) NSNumber *durationTimeInterval;
@property (readonly, nonatomic) NSNumber *nominalFrameRate;
@property (readonly, nonatomic) NSNumber *videoDataRate;
@property (readonly, nonatomic) NSNumber *audioDataRate;
@property (readonly, nonatomic) NSNumber *audioSampleRate;
@property (readonly, nonatomic) NSNumber *audioTrackFormat;
@property (readonly, nonatomic) NSNumber *audioTrackFormatFlags;
@property (readonly, nonatomic) unsigned int firstVideoTrackCodec;
@property (readonly, nonatomic) NSString *firstVideoTrackCodecString;
@property (readonly, nonatomic) NSNumber *videoDynamicRange;
@property (readonly, nonatomic) NSString *videoCodecName;
@property (readonly, nonatomic) NSString *author;
@property (readonly, nonatomic) NSString *captureMode;
@property (readonly, nonatomic) BOOL isTimelapse;
@property (readonly, nonatomic) BOOL isActionCam;
@property (readonly, nonatomic) BOOL isSloMo;
@property (readonly, nonatomic) BOOL isProRes;
@property (readonly, nonatomic) NSString *montageString;
@property (readonly, nonatomic) struct { long long x0; int x1; unsigned int x2; long long x3; } stillImageDisplayTime;
@property (readonly, nonatomic) NSNumber *livePhotoMinimumClientVersion;
@property (readonly, nonatomic) BOOL isCinematicVideo;
@property (readonly, nonatomic) UTType *contentTypeFromFastModernizeVideoMedia;
@property (readonly, nonatomic) struct opaqueCMFormatDescription * videoTrackFormatDescription;
@property (readonly, nonatomic) NSString *firstVideoTrackFormatDebugDescription;
@property (readonly, nonatomic) NSString *colorPrimaries;
@property (readonly, nonatomic) NSString *transferFunction;
@property (readonly, nonatomic) NSNumber *livePhotoVitalityTransitionScore;
@property (readonly, nonatomic) BOOL isPlayable;
@property (readonly, nonatomic) BOOL isDecodable;
@property (readonly, nonatomic) NSNumber *apacAudioTrackChannelCount;
@property (readonly, nonatomic) NSNumber *apacAudioTrackHoaChannelCount;
@property (readonly, nonatomic) NSNumber *apacAudioTrackBedChannelCount;
@property (readonly, nonatomic) NSString *apacAudioTrackCodecProfileLevelDescription;
@property (readonly, nonatomic) NSString *outOfBandHintsBase64String;
@property (readonly, nonatomic) PFHEVCProfileInformation *hevcProfileInfo;

/* class methods */
+ (id)_filterDictionary:(id)dictionary;
+ (id)_filterArray:(id)array;
+ (BOOL)_canEncodeInPropertyList:(id)list;
+ (id)_filterPropertyListObject:(id)object;
+ (id)encodedDataWithPropertyListObject:(id)object;
+ (id)propertyListObjectFromEncodedData:(id)data expectedClass:(Class)class options:(unsigned long long)options error:(id *)error;

/* instance methods */
- (id)initWithContentType:(id)type detail:(unsigned char)detail timeZoneLookup:(id)lookup;
- (id)initWithMetadataPlist:(id)plist timeZoneLookup:(id)lookup;
- (BOOL)configureWithMetadataPlist:(id)plist;
- (id)pixelWidth;
- (id)pixelHeight;
- (id)software;
- (id)altitudeRef;
- (unsigned long long)_stillImageProcessingFlags;
- (void)enumerateRawThumbnailInfoWithBlock:(id /* block */)block;
- (id)audioBytesPerPacket;
- (id)audioFramesPerPacket;
- (id)audioBytesPerFrame;
- (id)audioChannelsPerFrame;
- (id)audioBitsPerChannel;
- (void)computePixelWidthAndHeightValue;
- (void)_computeOrientationValue;
- (void)computeDateTimeValues;
- (void)_computeGPSLocation;
- (void)computeGPSValues;
- (void)_computeIsSpatialMediaValue;
- (id)_makeGPSProperties;
- (id)_makeDateTimeProperties;
- (id)_makeGeometryProperties;
- (id)_dateTimeOriginalForSyndicationProperties;
- (id)_dateTimeSubsecOriginalForSyndicationProperties;
- (id)_dateTimeOffsetOriginalForSyndicationProperties;
- (BOOL)_convertTimeZoneOffsetString:(id)string toSeconds:(double *)seconds;
- (id)hdrGainFromValue:(id)value;
- (void)loadMetadataWithCompletionHandler:(id /* block */)handler;
- (id)plistForEncoding;
- (id)jsonDictionary;
- (id)copyWithZone:(struct _NSZone *)zone;
- (BOOL)isEqual:(id)equal;
- (void)setImageSourceProperties:(id)properties;
- (void)setKeysAndValues:(id)values inDictionary:(id)dictionary;
- (void)fixupGPSWithDate:(id)date time:(id)time;
- (id)exifDictionary;
- (id)exifAuxDictionary;
- (id)makerAppleDictionary;
- (id)makerNikonDictionary;
- (id)makerCanonDictionary;
- (id)ciffDictionary;
- (id)gifDictionary;
- (id)gpsDictionary;
- (id)tiffDictionary;
- (id)iptcDictionary;
@end

#endif /* PFMetadataCore_h */