//
//  ViewController.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    [self settingControls];
}

-(void) settingControls{
    [self.bt_home_play setBackgroundImage:[UIImage imageNamed:@"button_home_01.png"] forState:UIControlStateNormal];
     [self.bt_home_find setBackgroundImage:[UIImage imageNamed:@"button_home_02.png"] forState:UIControlStateNormal];
     [self.bt_home_fill setBackgroundImage:[UIImage imageNamed:@"button_home_03.png"] forState:UIControlStateNormal];
     [self.bt_home_puzzle setBackgroundImage:[UIImage imageNamed:@"button_home_04.png"] forState:UIControlStateNormal];
     [self.bt_home_draw setBackgroundImage:[UIImage imageNamed:@"button_home_05.png"] forState:UIControlStateNormal];
     [self.bt_home_setting setBackgroundImage:[UIImage imageNamed:@"button_home_06.png"] forState:UIControlStateNormal];

    
    
}
-(IBAction) changeButtonImage:(id) sender{
    [self.bt_home_play setBackgroundImage:[UIImage imageNamed:@"button_home_01.png"] forState:UIControlStateNormal];
    [self.bt_home_find setBackgroundImage:[UIImage imageNamed:@"button_home_02.png"] forState:UIControlStateNormal];
    [self.bt_home_fill setBackgroundImage:[UIImage imageNamed:@"button_home_03.png"] forState:UIControlStateNormal];
    [self.bt_home_puzzle setBackgroundImage:[UIImage imageNamed:@"button_home_04.png"] forState:UIControlStateNormal];
    [self.bt_home_draw setBackgroundImage:[UIImage imageNamed:@"button_home_05.png"] forState:UIControlStateNormal];
    [self.bt_home_setting setBackgroundImage:[UIImage imageNamed:@"button_home_06.png"] forState:UIControlStateNormal];
    
    UIButton *button = sender;
    
    switch (button.tag) {
        case 0:
            [self.bt_home_play setBackgroundImage:[UIImage imageNamed:@"button_home_click_01.png"] forState:UIControlStateNormal];
            break;
        case 1:
            [self.bt_home_find setBackgroundImage:[UIImage imageNamed:@"button_home_click_02.png"] forState:UIControlStateNormal];
            break;

        case 2:
             [self.bt_home_fill setBackgroundImage:[UIImage imageNamed:@"button_home_click_03.png"] forState:UIControlStateNormal];
            break;
        case 3:
             [self.bt_home_puzzle setBackgroundImage:[UIImage imageNamed:@"button_home_click_04.png"] forState:UIControlStateNormal];
            break;
        case 4:
            [self.bt_home_draw setBackgroundImage:[UIImage imageNamed:@"button_home_click_05.png"] forState:UIControlStateNormal];
            break;

        default:
            [self.bt_home_setting setBackgroundImage:[UIImage imageNamed:@"button_home_click_06.png"] forState:UIControlStateNormal];
            break;
    }
   
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
