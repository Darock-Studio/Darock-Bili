//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 104.0.1.0.0
//
#ifndef SAWithYouDetector_h
#define SAWithYouDetector_h
@import Foundation;

#include "SAAnalyticsServiceProtocol-Protocol.h"
#include "SABluetoothScanRequestProtocol-Protocol.h"
#include "SADeviceRecord.h"
#include "SALocationRequestProtocol-Protocol.h"
#include "SATimeClientProtocol-Protocol.h"
#include "SATimeServiceProtocol-Protocol.h"
#include "SATravelTypeClassifierClientProtocol-Protocol.h"
#include "SAWithYouDetectorServiceProtocol-Protocol.h"

@class NSDate, NSHashTable, NSMutableDictionary, NSMutableSet, NSUUID;

@interface SAWithYouDetector : NSObject<SAWithYouDetectorServiceProtocol, SATimeClientProtocol, SATravelTypeClassifierClientProtocol>

@property (retain, nonatomic) NSObject<SATimeServiceProtocol> *clock;
@property (weak, nonatomic) NSObject<SABluetoothScanRequestProtocol> *bluetoothScanner;
@property (weak, nonatomic) NSObject<SALocationRequestProtocol> *locationRequester;
@property (retain, nonatomic) NSObject<SAAnalyticsServiceProtocol> *analytics;
@property (retain, nonatomic) NSHashTable *clients;
@property (retain, nonatomic) SADeviceRecord *deviceRecord;
@property (nonatomic) BOOL longScanIsOngoing;
@property (nonatomic) BOOL requestedShortScan;
@property (retain, nonatomic) NSDate *lastLongScanRequest;
@property (retain, nonatomic) NSDate *lastStartOfScan;
@property (retain, nonatomic) NSDate *lastEndOfScan;
@property (nonatomic) BOOL isNotifyWhileTravelingEnabled;
@property (nonatomic) BOOL isPeriodicScansNeeded;
@property (nonatomic) BOOL isInVehicularTravel;
@property (retain, nonatomic) NSDate *nextOpportunisticScanDate;
@property (retain, nonatomic) NSUUID *nextScheduledAlarm;
@property (retain, nonatomic) NSDate *previousBufferEmptyTime;
@property (retain, nonatomic) NSDate *initializationTime;
@property (retain, nonatomic) NSMutableSet *relevantDevicesToFindDuringLongScan;
@property (retain, nonatomic) NSMutableDictionary *foundDevicesDuringCurrentScan;
@property (nonatomic) BOOL isFindingRelevantDevices;
@property (retain, nonatomic) NSDate *lastRelevantDeviceFoundTime;
@property (nonatomic) unsigned long long lastLongScanContext;
@property (nonatomic) unsigned long long extraFoundHELECount;
@property (nonatomic) unsigned long long extraFoundNonHELECount;
@property (retain, nonatomic) NSDate *lastExtraHELEFoundTime;
@property (retain, nonatomic) NSDate *lastExtraNonHELEFoundTime;
@property (retain, nonatomic) NSUUID *scheduledAlarmForUpdateNotWithYouForCompanionPhone;
@property (retain, nonatomic) NSUUID *companionPhoneWithPendingUpdate;

/* class methods */
+ (id)convertSAWithYouStatusToString:(unsigned long long)string;
+ (id)convertSAWithYouLongScanContextToString:(unsigned long long)string;

/* instance methods */
- (id)initWithBluetoothScanner:(id)scanner locationRequester:(id)requester deviceRecord:(id)record clock:(id)clock analytics:(id)analytics;
- (void)sendScanContextToCoreAnalytics:(unsigned long long)analytics isPartOfLongScan:(BOOL)scan scanDuration:(double)duration relevantOnlyScanDuration:(double)duration foundExtraHELECount:(unsigned long long)helecount extraHELEScanDuration:(double)duration foundExtraNonHELECount:(unsigned long long)helecount extraNonHELEScanDuration:(double)duration longScanContext:(unsigned long long)context;
- (BOOL)allRelevantDevicesToFindAreFound;
- (BOOL)allSAEnabledDevicesAreFound;
- (void)forceUpdateWithYouStatus;
- (void)forceUpdateWithYouStatusToFindDevices:(id)devices withContext:(unsigned long long)context;
- (void)forceUpdateWithYouStatusWithShortScan:(BOOL)scan;
- (BOOL)_isOnlyMonitoringLeashOnlyDevices;
- (void)resetAllWithYouStatusAndScanStates;
- (unsigned long long)statusForDeviceWithUUID:(id)uuid;
- (BOOL)isPeriodicScansAllowed;
- (void)resumePeriodicScan;
- (void)pausePeriodicScan;
- (void)addClient:(id)client;
- (void)removeClient:(id)client;
- (void)_notifyAllClientsOfWithYouStatusUpdate:(unsigned long long)update forDeviceWithUUID:(id)uuid;
- (void)_updateWithYouStatusIfNecessaryOnConnectionEvent:(id)event;
- (double)_maxAgeOfWithYouAdvertisementForDeviceUUID:(id)uuid;
- (void)_updateLastWithYouDateAndLocation:(id)location forCurrentDate:(id)date;
- (BOOL)_isRecentEnoughAdvertisement:(id)advertisement forCurrentDate:(id)date;
- (BOOL)isExtraDeviceFound:(id)found onDate:(id)date;
- (void)updateExtraDeviceInformation:(id)information;
- (void)_deviceWithUUID:(id)uuid isWithYouDuringLongScanOnAdvertisement:(id)advertisement;
- (void)_updateWithYouStatusIfNecessaryOnAdvertisement:(id)advertisement;
- (void)_updateWithYouStatusOfRelatedDevices:(id)devices;
- (BOOL)_isValidPartID:(long long)id;
- (BOOL)_isStatusBitSetForRelatedDeviceWithShiftIndex:(unsigned long long)index fromAdvertisement:(id)advertisement;
- (unsigned long long)_finalizeToBeVerifiedStatus:(unsigned long long)status;
- (BOOL)_enoughTimeHasPassedSinceInitializationToMarkNotWithYouForDeviceUUID:(id)uuid;
- (void)_updateAllWithYouStatusOnScanEndedEvent:(id)event;
- (void)_updateWithYouStatusOnAdvBufferEmptyEvent:(id)event;
- (void)_scheduleNextAlarmForScanAfterDate:(id)date;
- (void)ingestTAEvent:(id)taevent;
- (void)requestScanIfNeeded;
- (void)alarmFiredForUUID:(id)uuid;
- (BOOL)_deviceIsWatch:(id)watch;
- (BOOL)_deviceIsCompanionPhone:(id)phone;
- (void)didChangeTravelTypeFrom:(unsigned long long)from to:(unsigned long long)to hints:(unsigned long long)hints;
@end

#endif /* SAWithYouDetector_h */