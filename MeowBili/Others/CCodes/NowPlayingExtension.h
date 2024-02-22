//
//
//  NowPlayingExtension.h
//  DarockBili
//
//  Created by memz233 on 2024/2/14.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
// Copyright (c) 2023 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

#ifndef NowPlayingExtension_h
#define NowPlayingExtension_h

@interface NowPlayingExtension : NSObject

#if !TARGET_OS_MAC

+(void) setPlayingInfoTitle: (NSString *) title artist: (NSString *) artist artwork: (UIImage *) artwork;

#endif

@end

#endif /* NowPlayingExtension_h */
