//
//  PlayCardViewController.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "FPPopoverController.h"
#import "ARCMacros.h"

@interface PlayCardViewController : UIViewController<AVAudioPlayerDelegate>
   
- (IBAction)btnPrevious:(id)sender;
- (IBAction)btnReplay:(id)sender;
- (IBAction)btnNext:(id)sender;
@property(nonatomic, strong) AVAudioPlayer *audioPlayer;
@property(strong,nonatomic) IBOutlet UIView* viewImageName;
@property(strong,nonatomic) IBOutlet UILabel *nameImage;
@property (strong, nonatomic) IBOutlet UIImageView *imageCard;
@property (strong, nonatomic) IBOutlet UIButton *btnPrevious;
@property (strong, nonatomic) IBOutlet UIButton *btnReplay;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;


@end
