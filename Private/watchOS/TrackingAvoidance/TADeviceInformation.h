//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 104.0.1.0.0
//
#ifndef TADeviceInformation_h
#define TADeviceInformation_h
@import Foundation;

#include "OSLogCoding-Protocol.h"
#include "TAEventProtocol-Protocol.h"
#include "TASPAdvertisement.h"

@class NSDate, NSString;

@interface TADeviceInformation : NSObject<OSLogCoding, TAEventProtocol>

@property (readonly, nonatomic) TASPAdvertisement *advertisement;
@property (readonly, nonatomic) unsigned long long deviceType;
@property (readonly, nonatomic) unsigned long long notificationState;
@property (readonly, nonatomic) NSDate *date;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)deviceTypeToString:(unsigned long long)string;
+ (id)notificationStateToString:(unsigned long long)string;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithTASPAdvertisement:(id)taspadvertisement deviceType:(unsigned long long)type notificationState:(unsigned long long)state date:(id)date;
- (BOOL)isEqual:(id)equal;
- (id)descriptionDictionary;
- (id)copyWithZone:(struct _NSZone *)zone;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (void)encodeWithOSLogCoder:(id)coder options:(unsigned long long)options maxLength:(unsigned long long)length;
- (id)getDate;
@end

#endif /* TADeviceInformation_h */