//
//  FindCardViewController.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface FindCardViewController : UIViewController<UIGestureRecognizerDelegate,AVAudioPlayerDelegate>{
    
}
@property (strong, nonatomic) IBOutlet UIView *viewImageName;
@property (strong, nonatomic) IBOutlet UILabel *imageName;
@property (strong, nonatomic) IBOutlet UIImageView *image1;
@property (strong, nonatomic) IBOutlet UIImageView *image2;
@property (strong, nonatomic) IBOutlet UIImageView *image3;
@property (strong, nonatomic) IBOutlet UIImageView *image4;
@property(nonatomic, strong) AVAudioPlayer *audioPlayer;
@property(nonatomic, strong) AVAudioPlayer *audioTouch;

- (void)bounce:(float)bounceFactor withImage:(UIImageView*) img;


@end
