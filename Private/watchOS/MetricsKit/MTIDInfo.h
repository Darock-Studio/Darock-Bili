//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2.8.10.0.0
//
#ifndef MTIDInfo_h
#define MTIDInfo_h
@import Foundation;

#include "MTID-Protocol.h"
#include "MTIDScheme.h"
#include "MTIDSecret.h"

@class NSDate, NSDictionary, NSNumber, NSString;

@interface MTIDInfo : NSObject<MTID>

@property (retain, nonatomic) MTIDScheme *scheme;
@property (retain, nonatomic) MTIDSecret *secret;
@property (copy, nonatomic) NSString *idString;
@property (copy, nonatomic) NSNumber *dsId;
@property (copy, nonatomic) NSDate *effectiveDate;
@property (copy, nonatomic) NSDate *expirationDate;
@property (nonatomic) BOOL isSynchronized;
@property (nonatomic) BOOL shouldGenerateMetricsFields;
@property (retain, nonatomic) NSDate *computedDate;
@property (readonly, copy, nonatomic) NSString *idNamespace;
@property (readonly, nonatomic) long long idType;
@property (readonly, nonatomic) double lifespan;
@property (readonly, copy, nonatomic) NSDictionary *metricsFields;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithScheme:(id)scheme secret:(id)secret idString:(id)string dsId:(id)id effectiveDate:(id)date expirationDate:(id)date;
- (id)initWithScheme:(id)scheme secret:(id)secret idString:(id)string dsId:(id)id effectiveDate:(id)date expirationDate:(id)date shouldGenerateMetricsFields:(BOOL)fields;
- (BOOL)isValueExpired;
- (BOOL)isEqual:(id)equal;
- (id)debugInfo;
@end

#endif /* MTIDInfo_h */