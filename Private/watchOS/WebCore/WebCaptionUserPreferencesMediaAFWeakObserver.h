//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.1.17.12.4
//
#ifndef WebCaptionUserPreferencesMediaAFWeakObserver_h
#define WebCaptionUserPreferencesMediaAFWeakObserver_h
@import Foundation;

@protocol {WeakPtr<WebCore::CaptionUserPreferencesMediaAF, WTF::DefaultWeakPtrImpl>="m_impl"{RefPtr<WTF::DefaultWeakPtrImpl, WTF::RawPtrTraits<WTF::DefaultWeakPtrImpl>, WTF::DefaultRefDerefTraits<WTF::DefaultWeakPtrImpl>>="m_ptr"^{DefaultWeakPtrImpl}}};

@interface WebCaptionUserPreferencesMediaAFWeakObserver : NSObject {
  /* instance variables */
  struct WeakPtr<WebCore::CaptionUserPreferencesMediaAF, WTF::DefaultWeakPtrImpl> { struct RefPtr<WTF::DefaultWeakPtrImpl, WTF::RawPtrTraits<WTF::DefaultWeakPtrImpl>, WTF::DefaultRefDerefTraits<WTF::DefaultWeakPtrImpl>> { struct DefaultWeakPtrImpl *m_ptr; } m_impl; } m_weakPtr;
}

/* instance methods */
- (id)initWithWeakPtr:(void *)ptr;
@end

#endif /* WebCaptionUserPreferencesMediaAFWeakObserver_h */