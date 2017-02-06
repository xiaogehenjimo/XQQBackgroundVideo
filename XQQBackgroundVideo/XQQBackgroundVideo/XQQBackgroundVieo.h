//
//  XQQBackgroundVieo.h
//  XQQBackgroundVideo
//
//  Created by XQQ on 16/8/15.
//  Copyright © 2016年 UIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface XQQBackgroundVieo : NSObject
{
    NSURL * videoURL;
    UIViewController * viewController;
}
/**
 *  播放器
 */
@property(nonatomic, strong)  AVPlayer  *  backgroundPlayer;

- (id)initOnViewController:(UIViewController*)onViewController withURL:(NSString*)url;

- (void)setBackground;

- (void)pause;

- (void)play;



@end
