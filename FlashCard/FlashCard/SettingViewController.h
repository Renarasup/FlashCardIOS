//
//  SettingViewController.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAMenuDropDown.h"

@interface SettingViewController : UIViewController<SAMenuDropDownDelegate>
@property (nonatomic, strong) SAMenuDropDown *menuDrop;
@property (strong, nonatomic) IBOutlet UIButton *btnLanguage;
@property (strong, nonatomic) IBOutlet UISlider *sliderVolume;
@property (strong, nonatomic) IBOutlet UISwitch *switchSwipe;

- (IBAction)changeValueSlider:(id)sender;
- (IBAction)btnSelectLanguage:(id)sender;
- (IBAction)btnSaveSetting:(id)sender;
//@property (weak) UIPopoverController *myPopover;
@end
