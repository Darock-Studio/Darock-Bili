//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef UIMenuBuilder_Protocol_h
#define UIMenuBuilder_Protocol_h
@import Foundation;

@protocol UIMenuBuilder 

@property (readonly, nonatomic) UIMenuSystem *system;

/* instance methods */
- (id)menuForIdentifier:(id)identifier;
- (id)actionForIdentifier:(id)identifier;
- (id)commandForAction:(SEL)action propertyList:(id)list;
- (void)replaceMenuForIdentifier:(id)identifier withMenu:(id)menu;
- (void)replaceChildrenOfMenuForIdentifier:(id)identifier fromChildrenBlock:(id /* block */)block;
- (void)insertSiblingMenu:(id)menu beforeMenuForIdentifier:(id)identifier;
- (void)insertSiblingMenu:(id)menu afterMenuForIdentifier:(id)identifier;
- (void)insertChildMenu:(id)menu atStartOfMenuForIdentifier:(id)identifier;
- (void)insertChildMenu:(id)menu atEndOfMenuForIdentifier:(id)identifier;
- (void)removeMenuForIdentifier:(id)identifier;
@end

#endif /* UIMenuBuilder_Protocol_h */