//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 908.2.0.0.0
//
#ifndef NSConcreteTextStorage_h
#define NSConcreteTextStorage_h
@import Foundation;

#include "NSTextStorage.h"
#include "NSConcreteNotifyingMutableAttributedString.h"

@interface NSConcreteTextStorage : NSTextStorage {
  /* instance variables */
  NSConcreteNotifyingMutableAttributedString *_contents;
  struct _opaque_pthread_rwlock_t { long long __sig; char x[192] __opaque; } _lock;
  struct { unsigned int x :1 _forceFixAttributes; unsigned int x :1 _needLock; unsigned int x :1 _lockInitialized; unsigned int x :1 _inFixingAttributes; unsigned int x :28 _reserved; } _pFlags;
}

/* class methods */
+ (unsigned long long)_writerCountTSDKey;

/* instance methods */
- (Class)classForCoder;
- (BOOL)_lockForReading;
- (BOOL)_lockForWritingWithExceptionHandler:(BOOL)handler;
- (void)_unlock;
- (void)_initLocks;
- (id)initWithAttributedString:(id)string;
- (id)initWithString:(id)string;
- (id)initWithString:(id)string attributes:(id)attributes;
- (id)init;
- (void)dealloc;
- (BOOL)fixesAttributesLazily;
- (unsigned long long)length;
- (id)string;
- (void)_setForceFixAttributes:(BOOL)attributes;
- (BOOL)_forceFixAttributes;
- (BOOL)_attributeFixingInProgress;
- (void)_setAttributeFixingInProgress:(BOOL)progress;
- (id)attributesAtIndex:(unsigned long long)index effectiveRange:(struct _NSRange { unsigned long long x0; unsigned long long x1; } *)range;
- (id)attributesAtIndex:(unsigned long long)index longestEffectiveRange:(struct _NSRange { unsigned long long x0; unsigned long long x1; } *)range inRange:(struct _NSRange { unsigned long long x0; unsigned long long x1; })range;
- (id)attribute:(id)attribute atIndex:(unsigned long long)index effectiveRange:(struct _NSRange { unsigned long long x0; unsigned long long x1; } *)range;
- (id)attribute:(id)attribute atIndex:(unsigned long long)index longestEffectiveRange:(struct _NSRange { unsigned long long x0; unsigned long long x1; } *)range inRange:(struct _NSRange { unsigned long long x0; unsigned long long x1; })range;
- (void)replaceCharactersInRange:(struct _NSRange { unsigned long long x0; unsigned long long x1; })range withString:(id)string;
- (void)setAttributes:(id)attributes range:(struct _NSRange { unsigned long long x0; unsigned long long x1; })range;
- (void)replaceCharactersInRange:(struct _NSRange { unsigned long long x0; unsigned long long x1; })range withAttributedString:(id)string;
- (void)addAttribute:(id)attribute value:(id)value range:(struct _NSRange { unsigned long long x0; unsigned long long x1; })range;
- (void)removeAttribute:(id)attribute range:(struct _NSRange { unsigned long long x0; unsigned long long x1; })range;
- (void)addAttributes:(id)attributes range:(struct _NSRange { unsigned long long x0; unsigned long long x1; })range;
- (void)_markIntentsResolved;
- (BOOL)_mayRequireIntentResolution;
@end

#endif /* NSConcreteTextStorage_h */