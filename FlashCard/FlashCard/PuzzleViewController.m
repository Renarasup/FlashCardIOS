//
//  PuzzleViewController.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "PuzzleViewController.h"
#import "SettingDTO.h"
#import "DataLanguageDTO.h"
#import "LanguageTable.h"
#import "SettingTable.h"
#import "UserDefault.h"
#import "ListImageViewController.h"
#import "IXNTilePuzzle.h"
static const NSTimeInterval AnimationSpeed = 0.2;
@interface PuzzleViewController ()<IXNTileBoardViewDelegate,UIAlertViewDelegate,listImageDelegate>{
    SettingTable *settingTable;
    LanguageTable *languageTable;
    SettingDTO *dtoSetting;
    UserDefault *userDefault;
    NSMutableArray *arrData;
    int curIndex;
     UINavigationController *naviList;
}
@property(weak,nonatomic)IBOutlet UILabel *stepsLabel;
@property(weak,nonatomic) IBOutlet UISegmentedControl *sizeSegmentedControl;
@property(weak,nonatomic) IBOutlet UIButton *myImage;
@property (weak, nonatomic) UIImageView *imageView;
@property(nonatomic,assign,readonly) UIImage *boardImage;
@property(nonatomic,readonly) NSInteger boardSize;
@property(nonatomic) NSInteger steps;

@end

@implementation PuzzleViewController
UIBarButtonItem *buttonListImg;
UIBarButtonItem *buttonRestart ;
UIButton *myListImg;
UIButton *myRestart;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if([segue.identifier isEqualToString:@"MySegueName"]){
        //ListImageViewController *list= [segue destinationViewController];
        //list.delegate = self;
    //}
}
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
    // Do any additional setup after loading the view.
    
    userDefault = [[UserDefault alloc]init];
    settingTable = [[SettingTable alloc]init];
    languageTable = [[LanguageTable alloc]init];
    arrData= [[NSMutableArray alloc]init];
    curIndex = 0;
    dtoSetting = [userDefault getUserDefault];
    arrData = [languageTable getDataLanguage:1];
    
    
    [self settingControll];
    [self restart:nil ];
}
-(void) settingControll{
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    if(IOS7)
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    else [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    UIButton *backbt= [UIButton buttonWithType:UIButtonTypeCustom];
    backbt.frame = CGRectMake(0, 0, 45, 45);
    [backbt addTarget:self action:@selector(gotoBack:) forControlEvents:UIControlEventTouchUpInside];
    [backbt setImage:[UIImage imageNamed:@"button_back_k"] forState:UIControlStateNormal];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backbt];
    self.navigationItem.leftBarButtonItem = back;
    
    
    myListImg= [UIButton buttonWithType:UIButtonTypeCustom];
    myListImg.frame = CGRectMake(0 , 0, 30, 30);
    [myListImg addTarget:self action:@selector(showListImage:) forControlEvents:UIControlEventTouchUpInside];
    [myListImg setImage:[UIImage imageNamed:@"button_list.png"] forState:UIControlStateNormal];
    
    
    myRestart= [UIButton buttonWithType:UIButtonTypeCustom];
     myRestart.frame = CGRectMake(40, 40, 40, 40);
    [myRestart setImage:[UIImage imageNamed:@"button_again.png"] forState:UIControlStateNormal];
    [myRestart addTarget:self action:@selector(restart:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    buttonListImg  =[[UIBarButtonItem alloc]initWithCustomView:myListImg]  ;//initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(nextDay:)];//initWithCustomView:myNextDay]  ;//
    buttonRestart  =[[UIBarButtonItem alloc]initWithCustomView:myRestart] ;//initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(preDay:)];//initWithCustomView:myPreDay] ;//
    
    NSArray *myButtonArray=[[NSArray alloc]initWithObjects:buttonListImg,buttonRestart,nil];
    
    self.navigationItem.rightBarButtonItems = myButtonArray;
}

-(void) gotoBack:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) showListImage:(id) sender{

    ListImageViewController *listView=[self.storyboard instantiateViewControllerWithIdentifier:@"ListImageViewController"];
    [listView setBoolFill:FALSE];
    listView.delegate = self;
    naviList = [[UINavigationController alloc] initWithRootViewController:listView];
    [self presentViewController:naviList animated:YES completion:Nil];
    
    
}
-(void) restart:(id) sender {
    [self.myImage setImage:[self boardImage:curIndex] forState:UIControlStateNormal];
    [self.board playWithImage:[self boardImage:curIndex] size:self.boardSize];
    [self.board shuffleTimes:100];
    self.steps = 0;
    
    [self hideImage];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage*) boardImage:(int) index{
    DataLanguageDTO *dto = [arrData objectAtIndex:index];
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",dto.imageName]];
}
-(NSInteger) boardSize{
    return self.sizeSegmentedControl.selectedSegmentIndex + 3;
}
-(void) setSteps:(NSInteger)steps{
    _steps = steps;
    self.stepsLabel.text = [NSString stringWithFormat:@"%d", self.steps];
}
- (IBAction)buttonTouchDown:(id)sender
{
    [self showImage];
}

- (IBAction)buttonTouchUpInside:(id)sender
{
    [self hideImage];
}

- (IBAction)sizeChanged:(UISegmentedControl *)sender
{
    [self restart:nil ];
}

- (void)showImage
{
    UIImageView *originalImage = [[UIImageView alloc] initWithImage:[self boardImage:curIndex]];
    originalImage.frame = self.board.frame;
    originalImage.alpha = 0.0;
    
    [originalImage.layer setShadowColor:[UIColor blackColor].CGColor];
    [originalImage.layer setShadowOpacity:0.65];
    [originalImage.layer setShadowRadius:1.5];
    [originalImage.layer setShadowOffset:CGSizeMake(1.5, 1.5)];
    [originalImage.layer setShadowPath:[[UIBezierPath bezierPathWithRect:originalImage.layer.bounds] CGPath]];
    
    [self.view addSubview:originalImage];
    
    [UIView animateWithDuration:AnimationSpeed animations:^{
        originalImage.alpha = 1.0;
        self.board.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.imageView = originalImage;
    }];
}

- (void)hideImage
{
    if (!self.imageView) return;
    
    [UIView animateWithDuration:AnimationSpeed animations:^{
        self.imageView.alpha = 0.0;
        self.board.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self.imageView removeFromSuperview];
        self.imageView = nil;
    }];
}



#pragma mark - Tile Board Delegate Method

- (void)tileBoardView:(IXNTileBoardView *)tileBoardView tileDidMove:(CGPoint)position
{
    NSLog(@"tile move : %@", [NSValue valueWithCGPoint:position]);
    self.steps++;
}

- (void)tileBoardViewDidFinished:(IXNTileBoardView *)tileBoardView
{
    [languageTable updateCardFinishedPuzzle:[[arrData objectAtIndex:curIndex] idLanguage] withmove:_steps];
    NSLog(@"tile is completed");
    [self showImage];
    
    NSString *message = [NSString stringWithFormat:@"You've completed a %d x %d puzzle with %d steps. Press restart button to play again or Next to next image.", self.boardSize, self.boardSize, self.steps];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congrats!" message:message delegate:self  cancelButtonTitle:@"Got it" otherButtonTitles:@"Next",nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self restart:nil ];
    }
    else {
        curIndex ++;
        [self restart:nil ];
    }
}
-(void) didSelectWith:(ListImageViewController *)controller index:(NSInteger)index{
    [controller dismissViewControllerAnimated:YES completion:nil];
    curIndex = index-1;
    [self restart:nil];
    NSLog(@"index %d",index);
}

//- See more at: http://getsetgames.com/2009/12/02/iphonedev-advent-tip-2-how-to-show-an-alert-with-uialertview/#sthash.eq6l4pZI.dpuf
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
