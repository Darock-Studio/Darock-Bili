//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 55.4.3.0.0
//
#ifndef IPPBDataReader_h
#define IPPBDataReader_h
@import Foundation;

@class NSData;

@interface IPPBDataReader : NSObject {
  /* instance variables */
  unsigned long long _pos;
  long long _error;
  const char * _bytes;
  NSData *_data;
}

@property (nonatomic) unsigned long long length;
@property (nonatomic) unsigned long long position;

/* instance methods */
- (id)initWithData:(id)data;
- (id)data;
- (BOOL)isAtEnd;
- (BOOL)hasError;
- (BOOL)hasMoreData;
- (unsigned long long)offset;
- (void)updateData:(id)data;
- (BOOL)seekToOffset:(unsigned long long)offset;
- (void)readTag:(unsigned int *)tag type:(char *)type;
- (BOOL)skipValueWithTag:(unsigned int)tag type:(unsigned char)type;
- (void)readTag:(unsigned short *)tag andType:(char *)type;
- (BOOL)skipValueWithTag:(unsigned short)tag andType:(unsigned char)type;
- (unsigned short)readBigEndianFixed16;
- (unsigned int)readBigEndianFixed32;
- (unsigned long long)readBigEndianFixed64;
- (id)readProtoBuffer;
- (char)readInt8;
- (long long)readVarInt;
- (double)readDouble;
- (float)readFloat;
- (int)readInt32;
- (long long)readInt64;
- (unsigned int)readUint32;
- (unsigned long long)readUint64;
- (int)readSint32;
- (long long)readSint64;
- (unsigned int)readFixed32;
- (unsigned long long)readFixed64;
- (int)readSfixed32;
- (long long)readSfixed64;
- (BOOL)readBOOL;
- (id)readString;
- (id)readData;
- (BOOL)mark:(struct { unsigned long long x0; unsigned long long x1; } *)mark;
- (void)recall:(const struct { unsigned long long x0; unsigned long long x1; } *)recall;
- (id)readBytes:(unsigned int)bytes;
- (id)readBigEndianShortThenString;
@end

#endif /* IPPBDataReader_h */