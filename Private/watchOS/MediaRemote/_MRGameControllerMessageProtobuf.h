//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4023.330.1.0.0
//
#ifndef _MRGameControllerMessageProtobuf_h
#define _MRGameControllerMessageProtobuf_h
@import Foundation;

#include "PBCodable.h"
#include "NSCopying-Protocol.h"
#include "_MRGameControllerButtonsProtobuf.h"
#include "_MRGameControllerDigitizerProtobuf.h"
#include "_MRGameControllerMotionProtobuf.h"

@interface _MRGameControllerMessageProtobuf : PBCodable<NSCopying> {
  /* instance variables */
  struct { unsigned int x :1 controllerID; } _has;
}

@property (nonatomic) BOOL hasControllerID;
@property (nonatomic) unsigned long long controllerID;
@property (readonly, nonatomic) BOOL hasMotion;
@property (retain, nonatomic) _MRGameControllerMotionProtobuf *motion;
@property (readonly, nonatomic) BOOL hasButtons;
@property (retain, nonatomic) _MRGameControllerButtonsProtobuf *buttons;
@property (readonly, nonatomic) BOOL hasDigitizer;
@property (retain, nonatomic) _MRGameControllerDigitizerProtobuf *digitizer;

/* instance methods */
- (id)description;
- (id)dictionaryRepresentation;
- (BOOL)readFrom:(id)from;
- (void)writeTo:(id)to;
- (void)copyTo:(id)to;
- (id)copyWithZone:(struct _NSZone *)zone;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (void)mergeFrom:(id)from;
@end

#endif /* _MRGameControllerMessageProtobuf_h */