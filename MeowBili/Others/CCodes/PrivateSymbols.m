//
//
//  PrivateSymbols.m
//  DarockBili
//
//  Created by memz233 on 2024/4/19.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
// Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

#import <Foundation/Foundation.h>
#import <dlfcn.h>
#import "PrivateSymbols.h"

@implementation UIImage (SFCoreGlyphBundle)

- (instancetype)initWithPrivateSystemName:(NSString *)name {
    NSBundle *const bundle = [NSClassFromString(@"SFSCoreGlyphsBundle") private];
    Class UIAssetManager_Class = NSClassFromString(@"_UIAssetManager");
    NSObject *assetManager = [UIAssetManager_Class performSelector:NSSelectorFromString(@"assetManagerForBundle:") withObject:bundle];
    UIImage *image = [assetManager performSelector:NSSelectorFromString(@"imageNamed:") withObject:name];
    self = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return self;
}

@end
