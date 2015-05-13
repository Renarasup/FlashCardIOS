//
//  SettingViewController.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingDTO.h"
#import "SettingTable.h"
#import "UserDefault.h"

@interface SettingViewController (){
    SettingTable *settingTable;
    SettingDTO *dtoSetting;
    UserDefault *userDefault;
    int volume;
    int idLanguage;
    int swipe;
}

@end

@implementation SettingViewController
@synthesize  menuDrop = _menuDrop;
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // if you have multiple segues, check segue.identifier
//    self.myPopover = [(UIStoryboardPopoverSegue *)segue popoverController];
//}
//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
//    if (self.myPopover) {
//        [self.myPopover dismissPopoverAnimated:YES];
//        return NO;
//    } else {
//        return YES;
//    }
//}
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
    userDefault =[[UserDefault alloc]init];
    dtoSetting =[userDefault getUserDefault];
    // Do any additional setup after loading the view.
    [self settingControll];
}
-(void) settingControll{
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
    
    
    NSArray *arrname = [[NSArray alloc] initWithObjects:@"English", @"Japanese", @"Vietnamese",nil] ;
    NSArray *arrTitle = [[NSArray alloc] initWithObjects:@"SAMenuDescription 0", @"SAMenuDescription 1", @"SAMenuDescription 2", nil] ;
    NSArray *arrImg = [[NSArray alloc] initWithObjects:@"10.png", @"11.png", @"12.png",nil] ;
    _menuDrop = [[SAMenuDropDown alloc] initWithWithSource:_btnLanguage menuHeight:150.0 itemNames:arrname itemImagesName:arrImg itemSubtitles:arrTitle];
    _menuDrop.delegate = self;
    
    int index = dtoSetting.language;
    switch (index) {
        case 1:
            [_btnLanguage setTitle: @"English"forState:UIControlStateNormal];
            break;
        case 2:
            [_btnLanguage setTitle: @"Japanese"forState:UIControlStateNormal];
            break;
        case 3:
            [_btnLanguage setTitle: @"Vietnamese"forState:UIControlStateNormal];
            break;
        default:
            //[_btnLanguage setTitle: @"Vietnamese"forState:UIControlStateNormal];
            break;
    }
 
    idLanguage = dtoSetting.language;
    volume = dtoSetting.volume;
    swipe = dtoSetting.swipe;
    [_sliderVolume setValue:(float) volume];
    [_switchSwipe setOn:(swipe ? YES:NO)];
}
-(void) gotoBack:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnSelectLanguage:(id)sender{
    UIButton *button=(UIButton*)sender;
    if(![sender isSelected]) {
        [_menuDrop showSADropDownMenuWithAnimation:kSAMenuDropAnimationDirectionBottom];
        button.selected = YES;
    }
    else {
        [_menuDrop hideSADropDownMenu];
        button.selected = NO;
    }
    if(IPAD)[self btnSaveSetting:nil];
}

- (IBAction)btnSaveSetting:(id)sender {
    if (_switchSwipe.isOn) {
        swipe = 1;
    }
    else swipe =0;
    [userDefault setUserDefault:idLanguage withVolume:volume withSwipe:swipe];
    if(!IPAD) {[self.navigationController popViewControllerAnimated:YES];}
    else {
        //[self dismissViewControllerAnimated:YES completion:Nil];
    }
}
-(IBAction)changeValueSlider:(UISlider *)sender{
   // NSLog(@"float %f",[sender value]);
    volume = (int) [sender value];
   // NSLog(@"itn %d",value);
    //int value = [sender value];
    if(IPAD)[self btnSaveSetting:nil];
    
}
- (IBAction)changeSwitch:(id)sender{
    
    if([sender isOn]){
        swipe = 1;
    } else{
        swipe = 0;
    }
     if(IPAD)[self btnSaveSetting:nil];
}
- (void)saDropMenu:(SAMenuDropDown *)menuSender didClickedAtIndex:(NSInteger)buttonIndex didClickItem:(NSString*) itemName
{
    NSLog(@"\n\n##<<%@>>##", menuSender);
    
    NSLog(@"\n\n\nClicked \n\n<<Button#%i>>", buttonIndex);
    
    [_menuDrop hideSADropDownMenu];
    _btnLanguage.selected = NO;
    // NSLog(@"=======%@", itemName);
    [_btnLanguage setTitle:[NSString stringWithFormat:@"  %@",itemName] forState:UIControlStateNormal];
    idLanguage = buttonIndex + 1;
    switch (buttonIndex) {
        case 0:
            [_btnLanguage setTitle: @"English"forState:UIControlStateNormal];
            break;
        case 1:
            [_btnLanguage setTitle: @"Japanese"forState:UIControlStateNormal];
            break;
        default:
            [_btnLanguage setTitle: @"Vietnamese"forState:UIControlStateNormal];
            break;
    }
    if(IPAD)[self btnSaveSetting:nil];
}
@end
