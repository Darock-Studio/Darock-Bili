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
#import "PrivateSymbols.h"

@implementation UIImage (SFCoreGlyphBundle)

- (instancetype)initWithPrivateSystemName:(NSString *)name {
    NSBundle *const bundle = [NSClassFromString(@"SFSCoreGlyphsBundle") private];
    _UIAssetManager *const assetManager = [_UIAssetManager assetManagerForBundle:bundle];
    self = [[assetManager imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return self;
}

@end
