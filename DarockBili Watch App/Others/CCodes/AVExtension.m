//
//  AVExtension.m
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/26.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AVExtension.h"

@implementation AVExtension

- (instancetype)init: (NSString *) playerUrl {
    self = [super init];
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    [headers setObject:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15" forKey:@"User-Agent"];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL: [[NSURL alloc] initWithString: playerUrl] options: headers];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithAsset: asset];
    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem: item];
    networkPlayer = player;
    return self;
}

- (AVPlayer *) GetPlayer {
    return networkPlayer;
}

- (CMTime) GetCurrentPlayTime {
    AVPlayerItem *currentItem = networkPlayer.currentItem;
    CMTime currentTime = currentItem.currentTime;
    return currentTime;
}
- (double) GetCurrentPlayTimeSeconds {
    AVPlayerItem *currentItem = networkPlayer.currentItem;
    CMTime currentTime = currentItem.currentTime;
    double seconds = CMTimeGetSeconds(currentTime);
    return seconds;
}

+ (CMTime) GetCurrentPlayTime: (AVPlayer *) player {
    AVPlayerItem *currentItem = player.currentItem;
    CMTime currentTime = currentItem.currentTime;
    return currentTime;
}
+ (double) GetCurrentPlayTimeSeconds: (AVPlayer *) player {
    AVPlayerItem *currentItem = player.currentItem;
    CMTime currentTime = currentItem.currentTime;
    double seconds = CMTimeGetSeconds(currentTime);
    return seconds;
}

+ (void) AVPlayerPausePlay: (AVPlayer *) player {
    [player pause];
}
+ (void) AVPlayerStartPlay: (AVPlayer *) player {
    [player play];
}

@end
