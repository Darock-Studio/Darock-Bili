//
//
//  PrivateSymbols.h
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

#ifndef PrivateSymbols_h
#define PrivateSymbols_h

#import<UIKit/UIKit.h>

@interface SFSCoreGlyphsBundle: NSObject
@property (nonatomic, class, readonly) NSBundle *private;
@end

@interface UIImage (SFSCoreGlyphsBundle)

- (instancetype)initWithPrivateSystemName:(NSString *)name;

@end

#endif /* PrivateSymbols_h */
