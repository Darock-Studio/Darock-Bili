//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.21.3.0.0
//
#ifndef CSPowerLogger_h
#define CSPowerLogger_h
@import Foundation;

@protocol OS_dispatch_queue;

@interface CSPowerLogger : NSObject

@property (nonatomic) unsigned long long selfTriggerSuppressionPlaybackRoute;
@property (nonatomic) unsigned long long selfTriggerSuppressionAudioSource;
@property (nonatomic) double selfTriggerSuppressionStartTime;
@property (nonatomic) unsigned long long numSelfTriggersInInterval;
@property (nonatomic) BOOL selfTriggerSuppressionIsPhoneCallConnected;
@property (retain, nonatomic) NSObject<OS_dispatch_queue> *queue;

/* class methods */
+ (id)sharedPowerLogger;

/* instance methods */
- (id)init;
- (void)powerLogVoiceTriggerStart;
- (void)powerLogVoiceTriggerStop;
- (void)powerWithNumFalseWakeup:(unsigned long long)wakeup withDuration:(double)duration withPhraseDict:(id)dict;
- (void)powerLogSiriConfigWithVoiceTriggerEnabled:(BOOL)enabled withLanguage:(id)language withModelVersion:(id)version;
- (void)powerLogSecondPassWithResult:(unsigned long long)result withSecondPassScore:(float)score withPhId:(unsigned long long)id;
- (void)powerLogSelfTriggerSuppressionDetectedWithSpeakerType:(unsigned long long)type withAudioSource:(unsigned long long)source atTime:(double)time isPhoneCall:(BOOL)call;
- (void)powerLogSelfTriggerSuppressionStartWithSpeakerType:(unsigned long long)type withAudioSource:(unsigned long long)source atTime:(double)time isPhoneCall:(BOOL)call;
- (void)powerLogSelfTriggerSuppressionStopAtTime:(double)time;
- (void)_borealisPowerlog:(id)powerlog;
- (void)_configPowerlog:(id)powerlog;
- (void)_updateConfigToPreferencesWithLanguage:(id)language withModelVersion:(id)version;
- (void)_emitSelfTriggerSuppressionToBiomeWithStsDuration:(double)duration;
@end

#endif /* CSPowerLogger_h */