//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 55.4.3.0.0
//
#ifndef BMSystemSettingsPillOutcome_h
#define BMSystemSettingsPillOutcome_h
@import Foundation;

#include "BMEventBase.h"
#include "BMStoreData-Protocol.h"

@class NSString;

@interface BMSystemSettingsPillOutcome : BMEventBase<BMStoreData>

@property (readonly, nonatomic) BOOL childAccount;
@property (nonatomic) BOOL hasChildAccount;
@property (readonly, nonatomic) BOOL firstUpdate;
@property (nonatomic) BOOL hasFirstUpdate;
@property (readonly, nonatomic) BOOL fromPill;
@property (nonatomic) BOOL hasFromPill;
@property (readonly, nonatomic) NSString *gesture;
@property (readonly, nonatomic) BOOL gestureOn;
@property (nonatomic) BOOL hasGestureOn;
@property (readonly, nonatomic) unsigned int dataVersion;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)eventWithData:(id)data dataVersion:(unsigned int)version;
+ (id)columns;
+ (id)validKeyPaths;

/* instance methods */
- (id)initWithChildAccount:(id)account firstUpdate:(id)update fromPill:(id)pill gesture:(id)gesture gestureOn:(id)on;
- (id)initByReadFrom:(id)from;
- (void)writeTo:(id)to;
- (id)serialize;
- (id)initWithJSONDictionary:(id)jsondictionary error:(id *)error;
- (id)jsonDictionary;
- (BOOL)isEqual:(id)equal;
@end

#endif /* BMSystemSettingsPillOutcome_h */