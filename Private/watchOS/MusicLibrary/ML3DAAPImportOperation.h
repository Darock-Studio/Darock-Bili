//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4023.330.6.0.0
//
#ifndef ML3DAAPImportOperation_h
#define ML3DAAPImportOperation_h
@import Foundation;

#include "ML3ImportOperation.h"

@class NSError;
@protocol {shared_ptr<DAAPParserDelegate>="__ptr_"^{DAAPParserDelegate}"__cntrl_"^{__shared_weak_count}};

@interface ML3DAAPImportOperation : ML3ImportOperation {
  /* instance variables */
  void * _importSession;
  NSError *_importError;
  struct shared_ptr<DAAPParserDelegate> { struct DAAPParserDelegate *__ptr_; struct __shared_weak_count *__cntrl_; } _delegate;
  unsigned char _updateType;
  long long _totalTrackCount;
  long long _totalContainerCount;
  long long _totalAlbumCount;
  long long _totalArtistCount;
  long long _processedTrackCount;
  long long _processedContainerCount;
  long long _processedArtistCount;
  long long _processedAlbumCount;
  BOOL _importSessionStarted;
  int _sourceType;
}

/* instance methods */
- (void)dealloc;
- (BOOL)performImportOfSourceType:(int)type usingConnection:(id)connection;
- (struct shared_ptr<ML3DAAPImportItem> { struct ML3DAAPImportItem * x0; struct __shared_weak_count * x1; })importItemFromDAAPElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })daapelement;
- (struct shared_ptr<ML3DAAPImportItem> { struct ML3DAAPImportItem * x0; struct __shared_weak_count * x1; })containerImportItemFromDAAPElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })daapelement withTrackIds:(struct vector<long long, std::allocator<long long>> { long long * x0; long long * x1; struct __compressed_pair<long long *, std::allocator<long long>> { long long * x0; } x2; })ids trackPersonIdentifiers:(struct vector<std::unordered_set<std::string>, std::allocator<std::unordered_set<std::string>>> { void * x0; void * x1; struct __compressed_pair<std::unordered_set<std::string> *, std::allocator<std::unordered_set<std::string>>> { void * x0; } x2; })identifiers;
- (struct shared_ptr<ML3DAAPImportItem> { struct ML3DAAPImportItem * x0; struct __shared_weak_count * x1; })personImportItemFromDAAPElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })daapelement;
- (struct shared_ptr<ML3DAAPImportItem> { struct ML3DAAPImportItem * x0; struct __shared_weak_count * x1; })albumImportItemFromDAAPTrackElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })element;
- (struct shared_ptr<ML3DAAPImportItem> { struct ML3DAAPImportItem * x0; struct __shared_weak_count * x1; })artistImportItemFromDAAPTrackElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })element artistEntityType:(long long)type;
- (struct shared_ptr<ML3DAAPImportItem> { struct ML3DAAPImportItem * x0; struct __shared_weak_count * x1; })albumImportItemFromDAAPElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })daapelement;
- (struct shared_ptr<ML3DAAPImportItem> { struct ML3DAAPImportItem * x0; struct __shared_weak_count * x1; })albumArtistImportItemFromDAAPElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })daapelement;
- (struct shared_ptr<ML3DAAPDeleteImportItem> { struct ML3DAAPDeleteImportItem * x0; struct __shared_weak_count * x1; })albumArtistItemFromDeletedDAAPArtistEntity:(const void *)entity;
- (struct shared_ptr<ML3DAAPDeleteImportItem> { struct ML3DAAPDeleteImportItem * x0; struct __shared_weak_count * x1; })albumItemFromDeletedDAAPAlbumEntity:(const void *)entity;
- (void)updateImportProgress:(float)progress;
- (BOOL)_preprocessDAAPPayloadFromFile:(id)file entityType:(int)type;
- (BOOL)_importDAAPPayloadFromFile:(id)file entityType:(int)type;
- (BOOL)_importDAAPPayloadFromFile:(id)file shouldProcessPlaylists:(BOOL)playlists;
- (void)_finishParsingWithError:(id)error;
- (BOOL)_processUpdateType:(unsigned char)type;
- (BOOL)_processTrackItemCount:(int)count;
- (BOOL)_processTrackElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })element;
- (BOOL)_processTrackImportItem:(struct shared_ptr<ML3DAAPImportItem> { struct ML3DAAPImportItem * x0; struct __shared_weak_count * x1; })item;
- (BOOL)_processDeletedTrackId:(long long)id;
- (BOOL)_processContainerItemCount:(int)count;
- (BOOL)_processContainerElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })element withTrackIds:(struct vector<long long, std::allocator<long long>> { long long * x0; long long * x1; struct __compressed_pair<long long *, std::allocator<long long>> { long long * x0; } x2; })ids trackPersonIdentifiers:(struct vector<std::unordered_set<std::string>, std::allocator<std::unordered_set<std::string>>> { void * x0; void * x1; struct __compressed_pair<std::unordered_set<std::string> *, std::allocator<std::unordered_set<std::string>>> { void * x0; } x2; })identifiers;
- (BOOL)_processDeletedContainerId:(long long)id;
- (BOOL)_processPersonElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })element;
- (BOOL)_processDeletedAlbumId:(const void *)id;
- (BOOL)_processDeletedArtistId:(const void *)id;
- (BOOL)_startImportSessionIfNeeded;
- (BOOL)_processAlbumCount:(int)count;
- (BOOL)_processArtistCount:(int)count;
- (BOOL)_processAlbumArtistFromArtistElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })element;
- (BOOL)_processAlbumFromAlbumElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })element;
- (BOOL)_processAlbumFromTrackElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })element importItem:(struct shared_ptr<ML3DAAPImportItem> { struct ML3DAAPImportItem * x0; struct __shared_weak_count * x1; })item albumArtistPersistentID:(long long)id;
- (BOOL)_processArtistFromTrackElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })element importItem:(struct shared_ptr<ML3DAAPImportItem> { struct ML3DAAPImportItem * x0; struct __shared_weak_count * x1; })item albumArtistPersistentID:(long long *)id;
- (struct shared_ptr<ML3DAAPImportItem> { struct ML3DAAPImportItem * x0; struct __shared_weak_count * x1; })_trackImportItemWithTrackElement:(struct shared_ptr<ML3CPP::Element> { struct Element * x0; struct __shared_weak_count * x1; })element;
- (int)_getTrackSource;
@end

#endif /* ML3DAAPImportOperation_h */