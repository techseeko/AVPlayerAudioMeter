
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class AVAudioMix;
@class AVAssetTrack;
@class AVPlayerItem;


@protocol MYAudioTabProcessorDelegate;

@interface MYAudioTapProcessor : NSObject

// Designated initializer.
- (id)initWithAudioAssetTrack:(AVAssetTrack *)audioAssetTrack;
- (id) initWithAVPlayerItem: (AVPlayerItem *)playerItem;

// Properties
@property (readonly, nonatomic) AVAssetTrack *audioAssetTrack;
@property (readonly, nonatomic) AVAudioMix *audioMix;
@property (weak, nonatomic) id <MYAudioTabProcessorDelegate> delegate;

@property BOOL compressorEnabled;

@end

#pragma mark - Protocols

@protocol MYAudioTabProcessorDelegate <NSObject>

// Add comment…
- (void)audioTabProcessor:(MYAudioTapProcessor *)audioTabProcessor hasNewLeftChannelValue:(float)leftChannelValue rightChannelValue:(float)rightChannelValue;

@end
