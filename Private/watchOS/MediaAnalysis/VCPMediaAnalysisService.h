//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 205.6.1.0.0
//
#ifndef VCPMediaAnalysisService_h
#define VCPMediaAnalysisService_h
@import Foundation;

#include "VCPMediaAnalysisClientProtocol-Protocol.h"

@class NSMutableDictionary, NSXPCConnection;
@protocol OS_dispatch_queue;

@interface VCPMediaAnalysisService : NSObject<VCPMediaAnalysisClientProtocol> {
  /* instance variables */
  NSXPCConnection *_connection;
  NSObject<OS_dispatch_queue> *_managementQueue;
  NSObject<OS_dispatch_queue> *_handlerQueue;
  NSMutableDictionary *_progressBlocks;
  int _nextRequestID;
}

/* class methods */
+ (id)defaultDeferredProcessingTypes;
+ (id)sharedAnalysisService;
+ (id)analysisService;
+ (id)errorWithDescription:(id)description;
+ (int)queryProgress:(float *)progress forPhotoLibrary:(id)library andTaskID:(unsigned long long)id;
+ (int)queryProgress:(float *)progress forPhotoLibrary:(id)library andTaskID:(unsigned long long)id withExtendTimeoutBlock:(id /* block */)block;
+ (int)queryCachedFaceAnalysisProgress:(id *)progress forPhotoLibrary:(id)library;
+ (int)queryCachedFaceAnalysisProgress:(id *)progress forPhotoLibrary:(id)library withExtendTimeoutBlock:(id /* block */)block;
+ (int)queryProgressDetail:(id *)detail forPhotoLibrary:(id)library andTaskID:(unsigned long long)id;
+ (int)queryProgressDetail:(id *)detail forPhotoLibrary:(id)library andTaskID:(unsigned long long)id withExtendTimeoutBlock:(id /* block */)block;
+ (int)queryProgressDetail:(id *)detail forPhotoLibraryURL:(id)url andTaskID:(unsigned long long)id;
+ (int)queryProgressDetail:(id *)detail forPhotoLibraryURL:(id)url andTaskID:(unsigned long long)id withExtendTimeoutBlock:(id /* block */)block;

/* instance methods */
- (int)requestStaticStickerScoringForLibrary:(id)library options:(id)options completionHandler:(id /* block */)handler;
- (BOOL)requestDeferredProcessingTypes:(id)types assets:(id)assets error:(id *)error;
- (id)assetsPendingDeferredProcessingWithPhotoLibraryURL:(id)url error:(id *)error;
- (int)requestForceDeferredProcessingWithProgessHandler:(id /* block */)handler andCompletionHandler:(id /* block */)handler;
- (int)downloadVideoEncoderWithCompletionHandler:(id /* block */)handler;
- (int)requestIdentificationOfFaces:(id)faces withCompletionHandler:(id /* block */)handler;
- (int)requestProcessingTypes:(unsigned long long)types forAssetsWithLocalIdentifiers:(id)identifiers fromPhotoLibraryWithURL:(id)url progressHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestClusterCacheValidationWithPhotoLibraryURL:(id)url progressHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestResetFaceClusteringStateWithPhotoLibraryURL:(id)url progressHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestReclusterFacesWithPhotoLibraryURL:(id)url progressHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestRebuildPersonsWithLocalIdentifiers:(id)identifiers photoLibraryURL:(id)url progressHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)queryAutoCounterOptInStatusForPhotoLibraryURL:(id)url withPersonLocalIdentifiers:(id)identifiers completionHandler:(id /* block */)handler;
- (int)requestOptInAutoCounterForPhotoLibraryURL:(id)url withPersons:(id)persons completionHandler:(id /* block */)handler;
- (int)requestDumpAutoCounterForPhotoLibraryURL:(id)url completionHandler:(id /* block */)handler;
- (int)requestAutoCounterAccuracyCalculationForPhotoLibraryURL:(id)url completionHandler:(id /* block */)handler;
- (int)requestAutoCounterAccuracyCalculationForPhotoLibraryURL:(id)url clusterStateURL:(id)url groundTruthURL:(id)url completionHandler:(id /* block */)handler;
- (int)requestAutoCounterSIMLValidationForPhotoLibraryURL:(id)url simlGroundTruthURL:(id)url completionHandler:(id /* block */)handler;
- (int)requestResetFaceClassificationModelForPhotoLibraryURL:(id)url progressHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestResetPetClassificationModelForPhotoLibraryURL:(id)url progressHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestSuggestedMePersonIdentifierWithContext:(id)context photoLibraryURL:(id)url progressHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestPersonPromoterStatusWithAdvancedFlag:(BOOL)flag photoLibraryURL:(id)url progressHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestPersonProcessingForPhotoLibraryURL:(id)url options:(id)options progressHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestResetPersons:(id)persons forPhotoLibraryURL:(id)url completionHandler:(id /* block */)handler;
- (int)requestSuggestedPersonsForPersonWithLocalIdentifier:(id)identifier toBeConfirmedPersonSuggestions:(id)suggestions toBeRejectedPersonSuggestions:(id)suggestions photoLibraryURL:(id)url progessHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestUpdateKeyFacesOfPersonsWithLocalIdentifiers:(id)identifiers forceUpdate:(BOOL)update photoLibraryURL:(id)url progessHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestFaceCandidatesforKeyFaceForPersonsWithLocalIdentifiers:(id)identifiers photoLibraryURL:(id)url progessHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (id)init;
- (id)connection;
- (int)requestBackgroundAnalysisForAssets:(id)assets fromPhotoLibraryWithURL:(id)url realTime:(BOOL)time progessHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestBackgroundAnalysisForAssets:(id)assets realTime:(BOOL)time progessHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestProcessingWithTaskID:(unsigned long long)id forPhotoLibrary:(id)library withOptions:(id)options progessHandler:(id /* block */)handler andCompletionHandler:(id /* block */)handler;
- (int)requestBackgroundProcessingWithTaskID:(unsigned long long)id forPhotoLibrary:(id)library progessHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestSceneProcessingForPhotoLibrary:(id)library withOptions:(id)options progressHandler:(id /* block */)handler andCompletionHandler:(id /* block */)handler;
- (int)requestFaceProcessingForPhotoLibrary:(id)library withOptions:(id)options progressHandler:(id /* block */)handler andCompletionHandler:(id /* block */)handler;
- (int)requestMultiWorkerProcessingForPhotoLibrary:(id)library withOptions:(id)options progressHandler:(id /* block */)handler andCompletionHandler:(id /* block */)handler;
- (int)requestFullProcessingForPhotoLibrary:(id)library withOptions:(id)options progressHandler:(id /* block */)handler andCompletionHandler:(id /* block */)handler;
- (int)requestVideoCaptionForFrames:(id)frames withOptions:(id)options progressHandler:(id /* block */)handler andCompletionHandler:(id /* block */)handler;
- (int)requestRecentsProcessing:(unsigned long long)processing photoLibrary:(id)library progressHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (int)requestProcessingWithTaskID:(unsigned long long)id forAssets:(id)assets withOptions:(id)options progressHandler:(id /* block */)handler andCompletionHandler:(id /* block */)handler;
- (int)requestLivePhotoEffectsForAssets:(id)assets withOptions:(id)options progressHandler:(id /* block */)handler andCompletionHandler:(id /* block */)handler;
- (int)requestSceneProcessingForAssets:(id)assets withOptions:(id)options progressHandler:(id /* block */)handler andCompletionHandler:(id /* block */)handler;
- (int)requestFaceProcessingForAssets:(id)assets withOptions:(id)options progressHandler:(id /* block */)handler andCompletionHandler:(id /* block */)handler;
- (int)requestQuickFaceIdentificationForPhotoLibraryURL:(id)url withOptions:(id)options andCompletionHandler:(id /* block */)handler;
- (void)reportProgress:(double)progress forRequest:(int)request;
- (void)cancelRequest:(int)request;
- (void)cancelAllRequests;
- (void)cancelBackgroundActivity;
- (void)invalidate;
- (void)notifyLibraryAvailableAtURL:(id)url;
- (int)requestPersonPreferenceForPhotoLibraryURL:(id)url completionHandler:(id /* block */)handler;
- (int)requestVIPModelFilepathForPhotoLibraryURL:(id)url forModelType:(unsigned long long)type completionHandler:(id /* block */)handler;
@end

#endif /* VCPMediaAnalysisService_h */