//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 77.0.0.0.0
//
#ifndef CBORValue_h
#define CBORValue_h
@import Foundation;

@interface CBORValue : NSObject

@property (readonly, nonatomic) int fieldType;
@property (readonly, nonatomic) unsigned char fieldValue;

/* instance methods */
- (void)write:(id)write;
- (void)encodeStartItems:(unsigned long long)items output:(id)output;
- (void)setAdditionalInformation:(unsigned char)information item2:(unsigned char)item2 output:(id)output;
- (void)setUint:(unsigned char)uint item2:(unsigned long long)item2 output:(id)output;
- (unsigned long long)getNumUintBytes:(unsigned long long)bytes;
@end

#endif /* CBORValue_h */