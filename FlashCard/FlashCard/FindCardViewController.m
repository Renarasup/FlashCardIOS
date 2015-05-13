//
//  FindCardViewController.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "FindCardViewController.h"
#import "SettingDTO.h"
#import "DataLanguageDTO.h"
#import "LanguageTable.h"
#import "SettingTable.h"
#import "UserDefault.h"
#import "SettingViewController.h"
@interface FindCardViewController (){
    SettingTable *settingTable;
    LanguageTable *languageTable;
    NSMutableArray * arrData;
    UserDefault *userDefault;
    NSMutableArray *arrAns;
    int curIndex;
    NSMutableArray *arrImageAns;
    SettingDTO *dtoSetting;
}

@end

@implementation FindCardViewController
@synthesize imageName,image1,image2,image3,image4,viewImageName,audioPlayer,audioTouch;
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
    arrData = [[NSMutableArray alloc]init];
    arrImageAns =[[NSMutableArray alloc]init];
    settingTable = [[SettingTable alloc]init];
    languageTable =[[LanguageTable alloc]init];
    userDefault = [[UserDefault alloc]init];
    
    dtoSetting =[userDefault getUserDefault];
    arrData= [languageTable  getDataLanguage:1];
    
    
    curIndex = arc4random() % arrData.count;
  
    
    [self settingControlls];
    [self loadQues];

}
-(void) settingControlls{
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    if(IOS7)
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    else [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    //[[UINavigationBar appearance] setTintColor:[UIColor greenColor]];
    UIGraphicsBeginImageContext(self.viewImageName.frame.size);
    [[UIImage imageNamed:@"tab_select.png"] drawInRect:self.viewImageName.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.viewImageName.backgroundColor = [UIColor colorWithPatternImage:image];
    
    UITapGestureRecognizer *viewClickSound = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSoundName:)];
    [self.viewImageName addGestureRecognizer:viewClickSound];
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage:)];
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage:)];
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage:)];
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage:)];
    
    singleTap1.numberOfTapsRequired = 1;
    singleTap2.numberOfTapsRequired = 1;
    singleTap3.numberOfTapsRequired = 1;
    singleTap4.numberOfTapsRequired = 1;
    
    image1.userInteractionEnabled = YES;
    image2.userInteractionEnabled = YES;
    image3.userInteractionEnabled = YES;
    image4.userInteractionEnabled = YES;
    
    [self setBorderImage:image1];
    [self setBorderImage:image2];
    [self setBorderImage:image3];
    [self setBorderImage:image4];
    
    [image1 addGestureRecognizer:singleTap1];
    [image2 addGestureRecognizer:singleTap2];
    [image3 addGestureRecognizer:singleTap3];
    [image4 addGestureRecognizer:singleTap4];
    
    
    [arrImageAns addObject:image1];
    [arrImageAns addObject:image2];
    [arrImageAns addObject:image3];
    [arrImageAns addObject:image4];
    
    UIButton *backbt= [UIButton buttonWithType:UIButtonTypeCustom];
    backbt.frame = CGRectMake(0, 0, 45, 45);
    [backbt addTarget:self action:@selector(gotoBack:) forControlEvents:UIControlEventTouchUpInside];
    [backbt setImage:[UIImage imageNamed:@"button_back_k.png"] forState:UIControlStateNormal];
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
    NSLog(@"findviewcontroller ");
    //here you can use sender.view to get the touched view
    
}

-(void) setBorderImage:(UIImageView *)image{
    image.layer.cornerRadius = 5.0;
    image.layer.borderColor = [[UIColor blueColor] CGColor];
    image.layer.borderWidth = 2.0;
    image.layer.masksToBounds = YES;
}
-(void) gotoBack:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void) gotoSetting:(id) sender{
//    SettingViewController *setting=[self.storyboard instantiateViewControllerWithIdentifier:@"SettingView"];
//    [self.navigationController pushViewController:setting animated:YES];
//}

-(void) selectImage:(UIGestureRecognizer *)sender
{
    UIImageView *myImg  = (UIImageView*)sender.view;
    int tag= myImg.tag;
   [self checkAns:tag with:myImg];
    NSLog(@"test");
    
}

-(void) loadQues{
    image1.hidden = NO;
    image2.hidden = NO;
    image3.hidden = NO;
    image4.hidden = NO;
    
    if( curIndex >= arrData.count) { curIndex = 0 ;curIndex = 0;}
    // arrAns= [[NSMutableArray alloc]init];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    [arr addObject:[NSNumber numberWithInt:curIndex]];
    int indexAns = arc4random() % 4;
    for(int i= 0;i < 4; i++){
        DataLanguageDTO *dto = [[DataLanguageDTO alloc]init];
        if(i == indexAns){
            dto = [arrData objectAtIndex:curIndex];
           // [arrAns addObject:dto];
            [self setImageAns: [arrImageAns objectAtIndex:i] withLanguageDTO:dto];
        }
        else {
            int indexAns = [self getIndexAns:arr];
            dto = [arrData objectAtIndex:indexAns];
            //[arrAns addObject:dto];
            [self setImageAns: [arrImageAns objectAtIndex:i] withLanguageDTO:dto];
            [arr addObject:[NSNumber numberWithInt:indexAns]];
        }
    }
    [self loadNameAndAudio:curIndex];
}

-(int) getIndexAns:(NSMutableArray *) arr{
    int number = arc4random() % arrData.count;
    while ([arr containsObject:[NSNumber numberWithInt:number]]) {
        number = arc4random() % arrData.count;
    }
    return number;
}
-(void) setImageAns:(UIImageView *) imageCard withLanguageDTO:(DataLanguageDTO *) dto{
    UIImage *image= [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",dto.imageName]];
    imageCard.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageCard.contentMode = UIViewContentModeScaleAspectFill;
    imageCard.image = image;
    imageCard.tag = dto.idLanguage;
}

-(void) loadNameAndAudio:(int) index{
    DataLanguageDTO *dto =[arrData objectAtIndex:index];
    imageName.text =  dto.name;
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
-(void) playTouch:(BOOL) touch{
    NSURL *url = [[NSBundle mainBundle] URLForResource:(touch ? @"right" : @"wrong") withExtension:@"mp3"];
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
-(void) checkAns:(int) tag with:(UIImageView *) image{
    DataLanguageDTO *dto= [arrData objectAtIndex:curIndex];
    if(tag== dto.idLanguage){
        
        curIndex ++;
        [self finishOneFind:tag];
        //[self loadQues:curIndex];
    }
    else {
        [self playTouch:false];
        [self bounce:2.0f withImage:image];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)finishOneFind:(int) tagView{
    for(UIView *v in self.view.subviews){
        if(v.tag >= 0 && v.tag != tagView){
            v.hidden = YES;
        }
    }
    [self playTouch:true];
    [self performSelector:@selector(loadQues) withObject:nil afterDelay:2.0];
}
//[self performSelector:@selector(startQues) withObject:nil afterDelay:2.0];
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
+ (CAKeyframeAnimation*)dockBounceAnimationWithViewHeight:(CGFloat)viewHeight
{
    NSUInteger const kNumFactors    = 22;
    CGFloat const kFactorsPerSec    = 30.0f;
    CGFloat const kFactorsMaxValue  = 128.0f;
    CGFloat factors[kNumFactors]    = {0,  60, 83, 100, 114, 124, 128, 128, 124, 114, 100, 83, 60, 32, 0, 0, 18, 28, 32, 28, 18, 0};
    
    NSMutableArray* transforms = [NSMutableArray array];
    
    for(NSUInteger i = 0; i < kNumFactors; i++)
    {
        CGFloat positionOffset  = factors[i] / kFactorsMaxValue * viewHeight;
        CATransform3D transform = CATransform3DMakeTranslation(0.0f, -positionOffset, 0.0f);
        
        [transforms addObject:[NSValue valueWithCATransform3D:transform]];
    }
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.repeatCount           = 1;
    animation.duration              = kNumFactors * 1.0f/kFactorsPerSec;
    animation.fillMode              = kCAFillModeForwards;
    animation.values                = transforms;
    animation.removedOnCompletion   = YES; // final stage is equal to starting stage
    animation.autoreverses          = NO;
    
    return animation;
}

- (void)bounce:(float)bounceFactor withImage:(UIImageView*) img
{
    CGFloat midHeight = img.frame.size.height * bounceFactor;
    CAKeyframeAnimation* animation = [[self class] dockBounceAnimationWithViewHeight:midHeight];
    [img.layer addAnimation:animation forKey:@"bouncing"];
}
@end
