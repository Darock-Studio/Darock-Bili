//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2220.14.1.0.0
//
#ifndef AVAssetTrack_h
#define AVAssetTrack_h
@import Foundation;

#include "AVAsset.h"
#include "AVAssetTrackInternal.h"
#include "AVAsynchronousKeyValueLoading-Protocol.h"
#include "AVIntegrityChecking-Protocol.h"
#include "NSCopying-Protocol.h"

@class NSString;

@interface AVAssetTrack : NSObject<AVIntegrityChecking, NSCopying, AVAsynchronousKeyValueLoading> {
  /* instance variables */
  AVAssetTrackInternal *_track;
}

@property (readonly, nonatomic) BOOL defunct;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;
@property (readonly, weak, nonatomic) AVAsset *asset;
@property (readonly, nonatomic) int trackID;

/* class methods */
+ (id)mediaCharacteristicsForMediaTypes;
+ (BOOL)expectsPropertyRevisedNotifications;
+ (id)keyPathsForValuesAffectingTimeRange;

/* instance methods */
- (BOOL)isDefunct;
- (BOOL)_hasMultipleEdits;
- (BOOL)_hasScaledEdits;
- (BOOL)_hasEmptyEdits;
- (BOOL)_hasMultipleDistinctFormatDescriptions;
- (BOOL)_firstFormatDescriptionIsLPCM;
- (void)_startListeningToFigAssetTrackNotifications;
- (void)_stopListeningToFigAssetTrackNotifications;
- (id)_initWithAsset:(id)asset trackID:(int)id trackIndex:(long long)index;
- (id)init;
- (id)_initWithAsset:(id)asset trackID:(int)id;
- (id)_initWithAsset:(id)asset trackIndex:(long long)index;
- (id)copyWithZone:(struct _NSZone *)zone;
- (void)dealloc;
- (id)_weakReference;
- (id)_assetTrackInspector;
- (struct OpaqueFigTrackReader *)_figTrackReader;
- (struct OpaqueFigAssetTrack *)_figAssetTrack;
- (long long)statusOfValueForKey:(id)key;
- (long long)statusOfValueForKey:(id)key error:(id *)error;
- (void)loadValuesAsynchronouslyForKeys:(id)keys completionHandler:(id /* block */)handler;
- (id)mediaType;
- (id)formatDescriptions;
- (BOOL)isPlayable;
- (BOOL)isDecodable;
- (int)playabilityValidationResult;
- (BOOL)isEnabled;
- (BOOL)isSelfContained;
- (long long)totalSampleDataLength;
- (BOOL)_subtitleFormatDescriptionMatchesTextDisplayFlags:(unsigned int)flags flagsMask:(unsigned int)mask;
- (BOOL)hasMediaCharacteristic:(id)characteristic;
- (BOOL)hasMediaCharacteristics:(id)characteristics;
- (id)mediaCharacteristics;
- (struct { struct { long long x0; int x1; unsigned int x2; long long x3; } x0; struct { long long x0; int x1; unsigned int x2; long long x3; } x1; })timeRange;
- (struct { struct { long long x0; int x1; unsigned int x2; long long x3; } x0; struct { long long x0; int x1; unsigned int x2; long long x3; } x1; })mediaPresentationTimeRange;
- (struct { struct { long long x0; int x1; unsigned int x2; long long x3; } x0; struct { long long x0; int x1; unsigned int x2; long long x3; } x1; })mediaDecodeTimeRange;
- (struct { long long x0; int x1; unsigned int x2; long long x3; })latentBaseDecodeTimeStampOfFirstTrackFragment;
- (BOOL)requiresFrameReordering;
- (BOOL)hasAudioSampleDependencies;
- (int)naturalTimeScale;
- (float)estimatedDataRate;
- (float)peakDataRate;
- (id)languageCode;
- (id)extendedLanguageTag;
- (id)locale;
- (struct CGSize { double x0; double x1; })naturalSize;
- (struct CGSize { double x0; double x1; })dimensions;
- (struct CGAffineTransform { double x0; double x1; double x2; double x3; double x4; double x5; })preferredTransform;
- (long long)layer;
- (float)preferredVolume;
- (id)loudnessInfo;
- (float)nominalFrameRate;
- (struct { long long x0; int x1; unsigned int x2; long long x3; })minFrameDuration;
- (id)segments;
- (id)segmentForTrackTime:(struct { long long x0; int x1; unsigned int x2; long long x3; })time;
- (void)loadSegmentForTrackTime:(struct { long long x0; int x1; unsigned int x2; long long x3; })time completionHandler:(id /* block */)handler;
- (BOOL)segmentsExcludeAudioPrimingAndRemainderDurations;
- (struct { struct { long long x0; int x1; unsigned int x2; long long x3; } x0; struct { long long x0; int x1; unsigned int x2; long long x3; } x1; })gaplessSourceTimeRange;
- (id)segmentsAsPresented;
- (struct { long long x0; int x1; unsigned int x2; long long x3; })samplePresentationTimeForTrackTime:(struct { long long x0; int x1; unsigned int x2; long long x3; })time;
- (void)loadSamplePresentationTimeForTrackTime:(struct { long long x0; int x1; unsigned int x2; long long x3; })time completionHandler:(id /* block */)handler;
- (id)commonMetadata;
- (id)availableMetadataFormats;
- (id)metadataForFormat:(id)format;
- (void)loadMetadataForFormat:(id)format completionHandler:(id /* block */)handler;
- (id)metadata;
- (long long)alternateGroupID;
- (long long)defaultAlternateGroupID;
- (long long)provisionalAlternateGroupID;
- (BOOL)isExcludedFromAutoselectionInTrackGroup;
- (id)_firstAssociatedTrackWithAssociationType:(id)type;
- (id)_fallbackTrack;
- (id)_pairedForcedOnlySubtitlesTrack;
- (id)_trackReferences;
- (BOOL)hasProtectedContent;
- (BOOL)hasAudibleBooksContent;
- (BOOL)isAudibleBooksContentAuthorized;
- (BOOL)hasSeamSamples;
- (id)availableTrackAssociationTypes;
- (id)associatedTracksOfType:(id)type;
- (void)loadAssociatedTracksOfType:(id)type completionHandler:(id /* block */)handler;
- (BOOL)canProvideSampleCursors;
- (id)makeSampleCursorWithPresentationTimeStamp:(struct { long long x0; int x1; unsigned int x2; long long x3; })stamp;
- (id)makeSampleCursorAtFirstSampleInDecodeOrder;
- (id)makeSampleCursorAtLastSampleInDecodeOrder;
- (BOOL)isEqual:(id)equal;
@end

#endif /* AVAssetTrack_h */