//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef _CPLResourcesMutableArray_h
#define _CPLResourcesMutableArray_h
@import Foundation;

@class NSMutableDictionary;

@interface _CPLResourcesMutableArray : NSObject {
  /* instance variables */
  NSMutableDictionary *_resourcesPerType;
  NSMutableDictionary *_updatedResourcesPerType;
}

/* instance methods */
- (id)initWithResources:(id)resources;
- (void)addResource:(id)resource;
- (id)allResources;
- (id)reallyUpdatedResources;
@end

#endif /* _CPLResourcesMutableArray_h */