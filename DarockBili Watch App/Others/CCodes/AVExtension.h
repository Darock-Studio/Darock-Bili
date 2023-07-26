//
//  AVExtension.h
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/26.
//

#ifndef AVExtension_h
#define AVExtension_h

#endif /* AVExtension_h */

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
