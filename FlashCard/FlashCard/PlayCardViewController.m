//
//  PlayCardViewController.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "PlayCardViewController.h"
#import "LanguageTable.h"
#import "SettingTable.h"
#import "DataLanguageDTO.h"
#import "UserDefault.h"
#import "SettingViewController.h"
@interface PlayCardViewController (){
    SettingTable *settingTable;
    LanguageTable *languageTable;
    SettingDTO *dtoSetting;
    UserDefault *userDefault;
    NSMutableArray *arrData;
    int curIndex;
    UIPopoverController *popover;
    
}

@end

@implementation PlayCardViewController
@synthesize audioPlayer,nameImage,viewImageName,imageCard;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;

}
-(void)viewWillAppear:(BOOL)animated{
    //SettingDTO *dto;
    dtoSetting = [userDefault getUserDefault];
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    userDefault = [[UserDefault alloc]init];
    settingTable = [[SettingTable alloc]init];
    languageTable = [[LanguageTable alloc]init];
    arrData= [[NSMutableArray alloc]init];
    curIndex = 0;
    dtoSetting = [userDefault getUserDefault];
    arrData = [languageTable getDataLanguage:1];
    
    
    [self settingControll:dtoSetting.swipe];
    [self loadCard:curIndex];
}
-(void) settingControll:(int) swipe{
    [self.navigationController.navigationBar setHidden:NO];
    //[self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:99/255.f green:184/255.f blue:255/255.f alpha:1]];
     //[[UINavigationBar appearance] setTintColor:[UIColor greenColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tab_up.png"] forBarMetrics:UIBarMetricsDefault];
//    if(IOS7){
//        
//        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
//    }
//    else{ [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
//        //CGRect f=self.imageCard.frame;
//       // f.origin.x = 0;
//        //f.origin.y =0;
//        //self.imageCard.frame = f;
//    }
    UIGraphicsBeginImageContext(self.viewImageName.frame.size);
    [[UIImage imageNamed:@"tab_select.png"] drawInRect:self.viewImageName.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.viewImageName.backgroundColor = [UIColor colorWithPatternImage:image];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_pg.png"]];
//    UIGraphicsBeginImageContext(_viewImage.frame.size);
//    [imageView drawInRect:_viewImage.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
   // _viewImage.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UITapGestureRecognizer *viewClickSound = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSoundName:)];
    [self.viewImageName addGestureRecognizer:viewClickSound];

    if(swipe==1){
        [imageCard setUserInteractionEnabled:YES];
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Adding the swipe gesture on image view
        [imageCard addGestureRecognizer:swipeLeft];
        [imageCard addGestureRecognizer:swipeRight];
    }
    
    UIImage *addImage = [UIImage imageNamed:@"button_back.png"];
    //UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[addButton setFrame:CGRectMake(0, 0, addImage.size.width, addImage.size.height)];
    //[addButton setBackgroundImage:addImage forState:UIControlStateNormal];
    //UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    //[self.navigationItem setRightBarButtonItem:barButtonItem];
    
    UIButton *backbt= [UIButton buttonWithType:UIButtonTypeCustom];
    backbt.frame = CGRectMake(0, 0, addImage.size.width, addImage.size.height);
    [backbt addTarget:self action:@selector(gotoBack:) forControlEvents:UIControlEventTouchUpInside];
    [backbt setImage:[UIImage imageNamed:@"button_back.png"] forState:UIControlStateNormal];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backbt];
    self.navigationItem.leftBarButtonItem = back;
    
//    UIButton *settingbt= [UIButton buttonWithType:UIButtonTypeCustom];
//    settingbt.frame = CGRectMake(0, 0, 45, 45);
//    [settingbt addTarget:self action:@selector(gotoSetting:) forControlEvents:UIControlEventTouchUpInside];
//    [settingbt setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
//    UIBarButtonItem *setting = [[UIBarButtonItem alloc] initWithCustomView:settingbt];
//    self.navigationItem.rightBarButtonItem = setting;
    
    
}
-(void)clickSoundName:(UITapGestureRecognizer *)sender {
    
    DataLanguageDTO *dto = [arrData objectAtIndex:curIndex];
    [self playAudio:dto.sound];
    //NSLog(@"click sound name image");
    //here you can use sender.view to get the touched view
    
}

-(void) gotoBack:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void) gotoSetting:(id) sender{
//    SettingViewController *setting=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingView"];
//   //UIBarButtonItem * btnSetting = (UIBarButtonItem *) sender;
//    if(IPAD){
//        UIView *anchor = sender;
//        UIViewController *viewControllerForPopover =
//        [self.storyboard instantiateViewControllerWithIdentifier:@"SettingView"];
//        
//        popover = [[UIPopoverController alloc]
//                   initWithContentViewController:viewControllerForPopover];
//        [popover presentPopoverFromRect:anchor.frame
//                                 inView:anchor.superview
//               permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//        
//    }else {[self.navigationController pushViewController:setting animated:YES];}
//}
-(void) loadCard:(int) index{
    DataLanguageDTO *dto = [arrData objectAtIndex:index];
    [self.nameImage setText:dto.name];
    
    UIImage *image= [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",dto.imageName]];
    if(IOS7){
    imageCard.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageCard.contentMode = UIViewContentModeScaleAspectFill;}
    imageCard.image = image;
    [self playAudio:dto.sound];
}
-(void) playAudio:(NSString *) sound{
    NSURL *url = [[NSBundle mainBundle] URLForResource:sound withExtension:@"mp3"];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc]
                   initWithContentsOfURL:url
                   error:&error];
    [audioPlayer setVolume:dtoSetting.volume/100.0];
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@",
              [error localizedDescription]);
    } else {
        audioPlayer.delegate = self;
        [audioPlayer prepareToPlay];
    }
    [audioPlayer play];
}
- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {

    if(dtoSetting.swipe == 1){
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        if(curIndex >= arrData.count-1) {curIndex = arrData.count -1;}
        else { curIndex ++;
            [self loadCard:curIndex]; }
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        if(curIndex <= 0) {curIndex = 0;}
            else {curIndex --;
                [self loadCard:curIndex];}
    }
    }
    
}
- (IBAction)btnPrevious:(id)sender{
    if(curIndex <= 0) curIndex = 0;
    else {curIndex --;
        [self loadCard:curIndex];}
    //curIndex --;
    //[self loadCard:curIndex];
}

- (IBAction)btnReplay:(id)sender {
    DataLanguageDTO *dto = [arrData objectAtIndex:curIndex];
    [self playAudio:dto.sound];
}

- (IBAction)btnNext:(id)sender {
    //curIndex ++;
    //[self loadCard:curIndex];
    if(curIndex >= arrData.count-1) curIndex = arrData.count -1;
    else { curIndex ++;
        [self loadCard:curIndex]; }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
