//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2005.6.1.3.2
//
#ifndef VCEmulatedNetworkAlgorithmQueueBandwidth_h
#define VCEmulatedNetworkAlgorithmQueueBandwidth_h
@import Foundation;

#include "VCEmulatedNetworkAlgorithm-Protocol.h"

@class NSDictionary, NSString;

@interface VCEmulatedNetworkAlgorithmQueueBandwidth : NSObject<VCEmulatedNetworkAlgorithm> {
  /* instance variables */
  NSDictionary *_policies;
  unsigned int _networkQueueServiceRate;
  unsigned int _networkQueueServiceRateMean;
  unsigned int _networkQueueServiceRateStdDev;
  unsigned int _networkQueueAQMRate;
  int _currentIndexForServiceRate;
  int _currentIndexForServiceRateDistribution;
  int _currentIndexForAQMRate;
  double _lastNetworkQueueServiceRateLoadTime;
  double _lastNetworkQueueServiceRateDistributionLoadTime;
  double _lastNetworkQueueAQMRateLoadTime;
  double _budgetBufferPktTime[4096];
  double _budgetBufferPktSize[4096];
  int _budgentBufferIndex;
  int _budgetBufferSize;
}

@property (readonly, nonatomic) double expectedProcessEndTime;
@property unsigned int packetCountInNetworkQueue;
@property int packetCountBytesInNetworkQueue;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)init;
- (void)updateSettingsAtTime:(double)time impairments:(id)impairments;
- (double)computeNetworkServiceRate;
- (void)process:(id)process;
- (BOOL)shouldDropPacketWithCurrentAQMBudget:(id)aqmbudget;
- (void)addPacketToBudgetBuffer:(id)buffer;
- (int)getRemainingAQMBudgetWithPacket:(id)packet;
@end

#endif /* VCEmulatedNetworkAlgorithmQueueBandwidth_h */