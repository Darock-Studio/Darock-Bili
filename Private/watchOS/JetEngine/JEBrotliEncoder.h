//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7.2.9.0.0
//
#ifndef JEBrotliEncoder_h
#define JEBrotliEncoder_h
@import Foundation;

@interface JEBrotliEncoder : NSObject

@property (readonly, nonatomic) struct BrotliEncoderStateStruct * encoder;
@property (nonatomic) unsigned int quality;
@property (nonatomic) unsigned int sizeHint;
@property (readonly, nonatomic) BOOL isFinished;

/* instance methods */
- (id)init;
- (void)dealloc;
- (BOOL)compressStreamWithOperation:(long long)operation availableIn:(unsigned long long *)in nextIn:(const char * *)in availableOut:(unsigned long long *)out nextOut:(char * *)out;
@end

#endif /* JEBrotliEncoder_h */