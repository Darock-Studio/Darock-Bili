//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2005.6.1.3.2
//
#ifndef VCVideoQualityInfo_h
#define VCVideoQualityInfo_h
@import Foundation;

#include "VCObject.h"

@interface VCVideoQualityInfo : VCObject {
  /* instance variables */
  double _lastGoodVideoQualityTime;
  double _lastBadVideoQualityTime;
  double _lastVideoQualityDegradedSwitchTime;
  double _firstDegradedMeasure;
  double _videoDegradedThreshold;
  double _videoImprovedThreshold;
  double _videoMinFrameRate;
  BOOL _shouldUseExitHysteresis;
}

@property (readonly, nonatomic) BOOL isVideoQualityDegraded;
@property (nonatomic) BOOL videoIsExpected;

/* instance methods */
- (id)init;
- (void)dealloc;
- (void)resetLastGoodVideoQualityTime:(double)time;
- (BOOL)updateWithCurrentFramerate:(double)framerate bitrate:(double)bitrate time:(double)time;
@end

#endif /* VCVideoQualityInfo_h */