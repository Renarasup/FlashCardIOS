//
//  FillBlankCardViewController.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "FillBlankCardViewController.h"
#import "LanguageTable.h"
#import "DataLanguageDTO.h"
#import "ButtonQues.h"
#import "LanguageTable.h"
#import "SettingTable.h"
#import "DataLanguageDTO.h"

#import "UserDefault.h"
#define BUTTON_WIDTH  18
#define BUTTON_HEIGHT 18
#define BUTTON_PADDING 2
#define BUTTON_WIDTH_IPAD  50
#define BUTTON_HEIGHT_IPAD 50
#define BUTTON_PADDING_IPAD 5
#define BUTTON_WIDTH_ANS (IPAD) ? 60 : 28
#define BUTTON_HEIGHT_ANS (IPAD) ? 60 : 28
#define BUTTON_PADDING_ANS (IPAD) ? 20 : 5
#define IMAGE_WIDTH_QUES (IPAD)? 90 : ((IS_IPHONE5) ? 60 : 40)
#define IMAGE_HEIGHT_QUES (IPAD) ? 90 : ((IS_IPHONE5) ? 60 : 40)
#define IMAGE_PADDING_QUES 1
@interface FillBlankCardViewController (){
    int timeSec ;
    int timeMin ;
    NSTimer *timer;

    NSMutableArray *arrQues;
    NSMutableArray *arrButtonQues;
    NSMutableArray *arrImageQues;
    NSMutableArray *arrButtonAns;
    int curIndex;
    int indexQues;
    
    SettingTable *settingTable;
    LanguageTable *languageTable;
    SettingDTO *dtoSetting;
    UserDefault *userDefault;
    NSMutableArray *arrData;
    
    BOOL help;
    UINavigationController *naviList;
}

@end
UIBarButtonItem *buttonListImg;
UIButton *myListImg;
@implementation FillBlankCardViewController
@synthesize audioPlayer,audioTouch,audioFinishFill;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    userDefault = [[UserDefault alloc]init];
    languageTable = [[LanguageTable alloc]init];
    arrData= [[NSMutableArray alloc]init];
    dtoSetting = [userDefault getUserDefault];
    arrData = [languageTable getDataLanguage:1];
     curIndex = arc4random() % arrData.count;
    [self settingControl];
    
}
-(void) settingControl{
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    if(IOS7)
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    else [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    UIButton *backbt= [UIButton buttonWithType:UIButtonTypeCustom];
    backbt.frame = CGRectMake(0, 0, 45, 45);
    [backbt addTarget:self action:@selector(gotoBack:) forControlEvents:UIControlEventTouchUpInside];
    [backbt setImage:[UIImage imageNamed:@"button_back_k.png"] forState:UIControlStateNormal];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backbt];
    self.navigationItem.leftBarButtonItem = back;
    
    myListImg= [UIButton buttonWithType:UIButtonTypeCustom];
    myListImg.frame = CGRectMake(0 , 0, 40, 40);
    [myListImg addTarget:self action:@selector(showListImage:) forControlEvents:UIControlEventTouchUpInside];
    [myListImg setImage:[UIImage imageNamed:@"button_list.png"] forState:UIControlStateNormal];
    buttonListImg  =[[UIBarButtonItem alloc]initWithCustomView:myListImg]  ;
    self.navigationItem.rightBarButtonItem = buttonListImg;
    
    _viewQuestion.layer.cornerRadius = 5.0;
    _viewQuestion.layer.borderColor = [[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1] CGColor];
    _viewQuestion.layer.borderWidth = 2.0;
   // _viewQuestion.layer.masksToBounds = YES;
    
    _viewAns.layer.cornerRadius = 5.0;
    _viewAns.layer.borderColor = [[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1] CGColor];
    _viewAns.layer.borderWidth = 2.0;
    
    //create clock time
    timeMin = 0;
    timeSec = 0;
    [self StartTimer];
    
    
    //create View with button Ques and Ans
    
    [self startQues];
}
-(void) showListImage:(id) sender{
    
    ListImageViewController *listView=[self.storyboard instantiateViewControllerWithIdentifier:@"ListImageViewController"];
    [listView setBoolFill:TRUE];
    listView.delegate = self;
    naviList = [[UINavigationController alloc] initWithRootViewController:listView];
    [self presentViewController:naviList animated:YES completion:Nil];
    
}
-(void) startQues{
    help= false;
    timeSec = 0;
    timeMin = 0;
    arrQues = nil;
    arrButtonQues= nil;
    arrImageQues = nil;
     [_btnHelp setImage:[UIImage imageNamed:@"help.png"] forState:UIControlStateNormal];
    [self removeSubviews];
    indexQues= 0;
    DataLanguageDTO *dto = [arrData objectAtIndex:curIndex];
    [self createButtonQues:_viewQuestion with:dto.name];
    [self createButtonAns:_viewAns];
    ///set background to image question view
    UIImage *image =[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",dto.name]];
    [self setBackgroundImage:image];
    
    //Create imageView Ques with hiden image
    //[self createImageQues:_viewImage];
    int i = 0;
    ButtonQues *btQ = [arrButtonQues objectAtIndex:i];
    while(btQ.tagButton == 1000){
        i++;
        btQ  = [arrButtonQues objectAtIndex:i];
    }
    indexQues = i;
    [self startShake:btQ.buttonQ];
}
-(void) nextQues{
   
//    for(UIImageView *v in _viewImage.subviews)
//    {
//        v.hidden = YES;
//    }
    curIndex ++;
    if(curIndex >= arrData.count) curIndex = 0;
     [self playSoundFinish];
    [self performSelector:@selector(startQues) withObject:nil afterDelay:4.0];
    //[self startQues];
}
-(void) removeSubviews{
    for(UIView *v in _viewImage.subviews){
        [v removeFromSuperview];
    }
    for(UIView *v in _viewAns.subviews){
        [v removeFromSuperview];
    }
    for(UIView *v in _viewQuestion.subviews){
        [v removeFromSuperview];
    }
}
-(void) setBackgroundImage:(UIImage *)imageView{
    _viewImage.layer.cornerRadius = 5.0;
    _viewImage.layer.borderColor = [[UIColor blueColor] CGColor];
    _viewImage.layer.borderWidth = 2.0;
    _viewImage.layer.masksToBounds = YES;
    
    
    UIGraphicsBeginImageContext(_viewImage.frame.size);
    [imageView drawInRect:_viewImage.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _viewImage.backgroundColor = [UIColor colorWithPatternImage:image];

}

-(void) createImageQues:(UIView *)view{
    arrImageQues = [[NSMutableArray alloc]init];
    int xQues= 0.5;
    int yQues= 0.5;
    int iRandom = arc4random() % 9;
    
   
    for(int i= 0; i<9; i++)
    {
        UIImageView *image= [[UIImageView alloc]init];
        image.image = [UIImage imageNamed:@"square.png"];
        image.frame = CGRectMake(xQues, yQues, IMAGE_WIDTH_QUES, IMAGE_HEIGHT_QUES);
        [view addSubview:image];
        if(i== iRandom) {image.hidden = YES;
            image.tag = -1;
        }
        else image.tag = i;
        xQues+= IMAGE_WIDTH_QUES+IMAGE_PADDING_QUES;
        if((i+1)%3 ==0){
            xQues = 0.5;
            yQues+= IMAGE_HEIGHT_QUES+0.5;
        }
        
        [arrImageQues addObject:image];
    }
    
}
-(int) getIndexRandom:(NSString *) strName{
    int i = arc4random() % strName.length;
    while([[strName substringWithRange:NSMakeRange(i, 1)] isEqualToString:@" "]){
        i = arc4random() % strName.length;
    }
    return i;
}
-(void) createButtonQues:(UIView *) view with:(NSString *) strName{
    arrQues =[[NSMutableArray alloc]init];
    arrButtonQues =[[NSMutableArray alloc]init];
    int length = strName.length;
    int indexKey = [self getIndexRandom:strName];
    int paddingQues= ((_viewQuestion.frame.size.width)-((((IPAD) ? BUTTON_WIDTH_IPAD : BUTTON_WIDTH) * length) + ((((IPAD) ? BUTTON_PADDING_IPAD : BUTTON_PADDING) * (length - 1)))))/2;
    for (int i = 0; i < length; i++) {
        NSString * newString = [strName substringWithRange:NSMakeRange(i, 1)];
        [arrQues addObject:newString];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        
        if(i== indexKey) {[btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@l.png",newString]] forState:UIControlStateNormal];
            btn.tag = 1000;
        }
        else {
            
        [btn setImage:[UIImage imageNamed:@"ques.png"] forState:UIControlStateNormal];
            int ASCIINumber = [[newString lowercaseString] characterAtIndex:0];
            btn.tag = ASCIINumber;
        }
        btn.frame = CGRectMake(paddingQues +(i * (((IPAD) ? BUTTON_WIDTH_IPAD : BUTTON_WIDTH )+ ((IPAD) ? BUTTON_PADDING_IPAD : BUTTON_PADDING))), (_viewQuestion.frame.size.height/2 - ((IPAD)  ? BUTTON_HEIGHT_IPAD : BUTTON_HEIGHT)/2), (IPAD) ? BUTTON_WIDTH_IPAD : BUTTON_WIDTH, (IPAD) ? BUTTON_HEIGHT_IPAD : BUTTON_HEIGHT);
        
        

        if([newString isEqualToString:@" "])
            btn.hidden=YES;
        ButtonQues *bt= [[ButtonQues alloc]init];
        bt.tagButton = btn.tag;
        bt.strQ = newString;
        bt.buttonQ = btn;
        [arrButtonQues addObject:bt];
        [view addSubview:btn];
    }
    
}
-(void) createButtonAns:(UIView *) viewAns {
    arrButtonAns = [[NSMutableArray alloc]init];
    NSArray * array = [NSArray arrayWithObjects:@"a", @"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    //int j = 0;
    int paddingY = _viewAns.frame.size.height/3;
    int xAns= 0;
    int yAns= (paddingY/2) - (BUTTON_HEIGHT_ANS)/2;
    for(int i= 1; i <= 26; i++){
        NSString *str = array[i-1];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@l.png",str]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(xAns, yAns, BUTTON_WIDTH_ANS, BUTTON_HEIGHT_ANS);
        int ASCIINumber = [[str lowercaseString] characterAtIndex:0];
        btn.tag = ASCIINumber;
        [viewAns addSubview:btn];
        xAns+= (BUTTON_WIDTH_ANS)+(BUTTON_PADDING_ANS);
        if(i%9 ==0){
            xAns = 0;
            yAns+= paddingY;
        }
        [arrButtonAns addObject:btn];
    }
}
-(void) buttonPressed:(id) sender{
    UIButton *button=(UIButton*)sender;
    ButtonQues *btQ =[arrButtonQues objectAtIndex:indexQues];
    
    if(button.tag == btQ.buttonQ.tag){
        [self playTouchChar:true];
        if(help){
            [button.layer removeAllAnimations];
        }
//        int i= arc4random() % 9;
//        while([[arrImageQues objectAtIndex:i] tag ]== -1){
//            i= arc4random() % 9;
//        }
//        [[arrImageQues objectAtIndex:i] setHidden:YES];
//        [[arrImageQues objectAtIndex:i] setTag:-1];
        [btQ.buttonQ setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@l.png",[btQ.strQ lowercaseString]]] forState:UIControlStateNormal];
        indexQues ++;
        
        if(indexQues < arrButtonQues.count){
            if([[arrButtonQues objectAtIndex:indexQues] tagButton]==32 || ([[arrButtonQues objectAtIndex:indexQues] tagButton]==1000 & indexQues <= arrButtonQues.count-1)) {indexQues ++;}
             [self startShake:[[arrButtonQues objectAtIndex:indexQues] buttonQ]];
        }
        else{
            //check finish here
            NSLog(@"finished");
            [self nextQues];
        }
        [btQ.buttonQ.layer removeAllAnimations];
        
    
    }
    else {
        [self playTouchChar:false];
        [self startShakeFail:button];
    }
}
- (void) startShake:(UIView*)view
{
    CGAffineTransform leftShake = CGAffineTransformMakeTranslation(0, -5);
    CGAffineTransform rightShake = CGAffineTransformMakeTranslation(0, 0);
    view.transform = leftShake;  // starting point
    
    [UIView beginAnimations:@"shake_button" context:(__bridge void *)(view)];
    [UIView setAnimationRepeatAutoreverses:YES]; // important
    [UIView setAnimationRepeatCount:1000];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(shakeEnded:finished:context:)];
    
    view.transform = rightShake; // end here & auto-reverse
    
    [UIView commitAnimations];
}
- (void) startShakeFail:(UIView*)view
{
    CGAffineTransform leftShake = CGAffineTransformMakeTranslation(-5, 0);
    CGAffineTransform rightShake = CGAffineTransformMakeTranslation(5, 0);
    view.transform = leftShake;  // starting point
    
    [UIView beginAnimations:@"shake_button" context:(__bridge void *)(view)];
    [UIView setAnimationRepeatAutoreverses:YES]; // important
    [UIView setAnimationRepeatCount:3];
    [UIView setAnimationDuration:0.06];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(shakeEnded:finished:context:)];
    
    view.transform = rightShake; // end here & auto-reverse
    
    [UIView commitAnimations];
}


- (void) shakeEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([finished boolValue]) {
        UIView* item = (__bridge UIView *)context;
        item.transform = CGAffineTransformIdentity;
    }
}

-(void) restart{
    
}
-(void) gotoBack:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) StartTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

//Event called every time the NSTimer ticks.
- (void)timerTick:(NSTimer *)timer
{
    timeSec++;
    if (timeSec == 60)
    {
        timeSec = 0;
        timeMin++;
    }
    //Format the string 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    //Display on your label
    //[timeLabel setStringValue:timeNow];
    _lbTimer.text= timeNow;
}

//Call this to stop the timer event(could use as a 'Pause' or 'Reset')
- (void) StopTimer
{
    [timer invalidate];
    timeSec = 0;
    timeMin = 0;
    //Since we reset here, and timerTick won't update your label again, we need to refresh it again.
    //Format the string in 00:00
    NSString* timeNow = [NSString stringWithFormat:@"%02d:%02d", timeMin, timeSec];
    //Display on your label
    // [timeLabel setStringValue:timeNow];
    _lbTimer.text= timeNow;
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
-(void) playTouchChar:(BOOL) touch{
    NSURL *url = [[NSBundle mainBundle] URLForResource:(touch ? @"right":@"wrong") withExtension:@"mp3"];
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
-(void) playSoundFinish{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"clapping" withExtension:@"wav"];
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
- (IBAction)btnPlaySound:(id)sender {
    DataLanguageDTO *dto= [arrData objectAtIndex:curIndex];
    [self playAudio:dto.sound];
}


- (IBAction)btnHelp:(id)sender {
    if(!help){
        [_btnHelp setImage:[UIImage imageNamed:@"nohelp.png"] forState:UIControlStateNormal];
        ButtonQues *bt= [arrButtonQues objectAtIndex:indexQues];
        for(UIButton *btA in arrButtonAns){
            if(btA.tag == bt.tagButton){
                [self startShake:btA];
            }
        }
        help = true;
    }
    
}

-(void) didSelectWith:(ListImageViewController *)controller index:(NSInteger)index{
    [controller dismissViewControllerAnimated:YES completion:nil];
    //curIndex = index-1;
    //[self restart:nil];
    //NSLog(@"index %d",index);
}
@end
