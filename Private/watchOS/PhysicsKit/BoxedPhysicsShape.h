//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 40.0.3.0.0
//
#ifndef BoxedPhysicsShape_h
#define BoxedPhysicsShape_h
@import Foundation;

@class NSArray;

@interface BoxedPhysicsShape : NSObject {
  /* instance variables */
  int shapeType;
  NSArray *points;
}

/* class methods */
+ (id)boxPhysicsShape:(struct PKPhysicsShape { struct b2FixtureDef { struct b2Shape * x0; void * x1; float x2; float x3; float x4; float x5; float x6; } x0; struct b2Fixture * x1; } *)shape;

/* instance methods */
- (struct PKPhysicsShape { struct b2FixtureDef { struct b2Shape * x0; void * x1; float x2; float x3; float x4; float x5; float x6; } x0; struct b2Fixture * x1; } *)unboxShape;
@end

#endif /* BoxedPhysicsShape_h */