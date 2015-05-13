//
//  FillBlankCardViewController.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "ListImageViewController.h"
@interface FillBlankCardViewController : UIViewController<AVAudioPlayerDelegate,listImageDelegate>
@property (strong, nonatomic) IBOutlet UIView *viewImage;
@property (strong, nonatomic) IBOutlet UIImageView *imageFill;
@property (strong, nonatomic) IBOutlet UIView *viewQuestion;
@property (strong, nonatomic) IBOutlet UIView *viewAns;
@property (strong, nonatomic) IBOutlet UILabel *lbTimer;
@property(nonatomic,strong)  AVAudioPlayer *audioPlayer;
@property(nonatomic, strong) AVAudioPlayer *audioTouch;
@property(nonatomic, strong) AVAudioPlayer *audioFinishFill;
@property (strong, nonatomic) IBOutlet UIButton *btnHelp;
- (IBAction)btnPlaySound:(id)sender;
- (IBAction)btnHelp:(id)sender;

@end
