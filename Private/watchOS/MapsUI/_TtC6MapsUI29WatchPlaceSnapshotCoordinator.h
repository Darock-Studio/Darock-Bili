//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 158.42.9.28.10
//
#ifndef _TtC6MapsUI29WatchPlaceSnapshotCoordinator_h
#define _TtC6MapsUI29WatchPlaceSnapshotCoordinator_h
@import Foundation;

#include "_MKStaticMapViewDelegate-Protocol.h"

@interface MapsUI.WatchPlaceSnapshotCoordinator : NSObject<_MKStaticMapViewDelegate> { // (Swift)
  /* instance variables */
   view;
   _loadingState;
   mapItemAnnotation;
   debugName;
}

/* instance methods */
- (id)init;
- (void)mapViewWillStartLoadingMap:(id)map;
- (void)mapViewDidFinishLoadingMap:(id)map;
- (void)mapViewDidFailLoadingMap:(id)map withError:(id)error;
- (id)mapView:(id)view viewForAnnotation:(id)annotation;
@end

#endif /* _TtC6MapsUI29WatchPlaceSnapshotCoordinator_h */