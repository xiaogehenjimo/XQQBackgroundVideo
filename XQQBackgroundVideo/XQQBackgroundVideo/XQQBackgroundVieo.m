//
//  XQQBackgroundVieo.m
//  XQQBackgroundVideo
//
//  Created by XQQ on 16/8/15.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import "XQQBackgroundVieo.h"

static BOOL haBeenUse = NO;

@implementation XQQBackgroundVieo

- (id)initOnViewController:(UIViewController*)onViewController withURL:(NSString*)url
{
    if (self = [super init]) {
        
        viewController = onViewController;
        //分割字符串
        NSArray * videoNameAndType = [url componentsSeparatedByString:@"."];
        if (videoNameAndType.count == 2) {
            //视频的名字
            __weak NSString * videoName = videoNameAndType[0];
            //视频的类型
            __weak NSString * videoType = videoNameAndType[1];
            //如果工程里面有这个文件
            if ([[NSBundle mainBundle] URLForResource:videoName withExtension:videoType]) {
                //拿到视频路径
                videoURL = [[NSBundle mainBundle] URLForResource:videoName withExtension:videoType];
                //初始化播放器
                self.backgroundPlayer  = [AVPlayer playerWithURL:videoURL];
            }else{
                NSLog(@"无效的文件!");
            }
        }else{
            NSLog(@"视频名字格式错误!");
        }
    }
    return self;
}

- (void)setBackground
{
    self.backgroundPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    self.backgroundPlayer.muted = YES;
    AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.backgroundPlayer];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerLayer.zPosition = -1;
    playerLayer.frame = viewController.view.frame;
    [viewController.view.layer addSublayer:playerLayer];
    //防止视频干扰来自其他应用程序的音频服务
    @try {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception.reason);
    } @finally {
        
    }
    //开始播放
    [self.backgroundPlayer play];
    
    //视频播放结束的时候
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loopVideo)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
    //app进入后台的时候
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loopVideo)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    haBeenUse = YES;
}
/**
 *  暂停
 */
- (void)pause
{
    [self.backgroundPlayer pause];
}
/**
 *  播放
 */
- (void)play
{
    [self.backgroundPlayer play];
}
/**
 *  循环
 */
- (void)loopVideo
{
    [self.backgroundPlayer seekToTime:kCMTimeZero];
    [self.backgroundPlayer play];
}

- (void)dealloc
{
    //移除监听
    if (haBeenUse) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    }
}

@end
