//
//  ListImageViewController.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 6/5/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "ListImageViewController.h"
#import "SettingDTO.h"
#import "DataLanguageDTO.h"
#import "LanguageTable.h"
#import "SettingTable.h"
#import "UserDefault.h"
#import "SettingViewController.h"
@interface ListImageViewController (){
    SettingTable *settingTable;
    LanguageTable *languageTable;
    SettingDTO *dtoSetting;
    UserDefault *userDefault;
    NSMutableArray *arrData;
    int curIndex;
    BOOL bFill;
}

@end

@implementation ListImageViewController
@synthesize tableview;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self settingControl];
    userDefault = [[UserDefault alloc]init];
    settingTable = [[SettingTable alloc]init];
    languageTable = [[LanguageTable alloc]init];
    arrData= [[NSMutableArray alloc]init];
    curIndex = 0;
    dtoSetting = [userDefault getUserDefault];
    arrData = [languageTable getDataLanguage:dtoSetting.language];

    NSLog(@"bool %hhd",bFill);
    // Do any additional setup after loading the view.
}
-(void) settingControl{
    //[self.navigationController.navigationBar setHidden:YES];
    //[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    if(IOS7)
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    else [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    [self.navigationItem setTitle:@"Image"];
    UIButton *closebt = [UIButton buttonWithType:UIButtonTypeCustom];
    closebt.frame = CGRectMake(0, 0, 35, 35);
    [closebt setImage:[UIImage imageNamed:@"closebt.png"] forState:UIControlStateNormal];
    [closebt addTarget:self action:@selector(gotoView) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *closeButtonBar= [[UIBarButtonItem alloc] initWithCustomView:closebt];
    self.navigationItem.rightBarButtonItem = closeButtonBar;

}
-(void) setBoolFill:(BOOL) flag{
    bFill = flag;
}
-(void)gotoView{
    
   [self dismissViewControllerAnimated:YES completion:Nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return arrData.count;
}

- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self tableview] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top.png"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"cell_middle.png"];
    }
    
    return background;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe in the table cell
    DataLanguageDTO *dto = [arrData objectAtIndex:indexPath.row];
    UIImageView *checkImage= (UIImageView *)[cell viewWithTag:100];
    if(!bFill){
    if(dto.finishedPuzzle == 0){
        checkImage.image = [UIImage imageNamed:@"uncheck.png"];
        
        }
        else{
            checkImage.image = [UIImage imageNamed:@"check.png"];
        }
    }
    else {
        if(dto.finishedFill == 0){
            checkImage.image = [UIImage imageNamed:@"uncheck.png"];
            
        }
        else{
            checkImage.image = [UIImage imageNamed:@"check.png"];
        }
    }
    UIImageView *imageView= (UIImageView *)[cell viewWithTag:101];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",dto.imageName]];
    
    UILabel *stepsLabel = (UILabel *)[cell viewWithTag:102];
    if(!bFill)
        stepsLabel.text =[NSString stringWithFormat:@"move: %d", dto.movePuzzle];
    else stepsLabel.text =[NSString stringWithFormat:@"times: %@ s", dto.timeFill];
    
    // Assign our own background image for the cell
    UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    cellBackgroundView.image = background;
    cell.backgroundView = cellBackgroundView;
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // NSLog(@"abc//");
    [self.delegate didSelectWith:self index:[[arrData objectAtIndex:indexPath.row] idLanguage]];
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
