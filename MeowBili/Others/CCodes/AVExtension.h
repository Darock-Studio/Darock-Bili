//
//
//  AVExtension.h
//  DarockBili
//
//  Created by memz233 on 2024/2/10.
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

#ifndef AVExtension_h
#define AVExtension_h

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AVExtension: NSObject {
    AVPlayer *networkPlayer;
}

- (instancetype) init: (NSString *) playerUrl;

- (AVPlayer *) GetPlayer;
- (CMTime) GetCurrentPlayTime;
- (double) GetCurrentPlayTimeSeconds;
+ (CMTime) GetCurrentPlayTime: (AVPlayer *) player;
+ (double) GetCurrentPlayTimeSeconds: (AVPlayer *) player;

+ (void) AVPlayerPausePlay: (AVPlayer *) player;
+ (void) AVPlayerStartPlay: (AVPlayer *) player;

@end

#endif /* AVExtension_h */
