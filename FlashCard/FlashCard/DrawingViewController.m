//
//  DrawingViewController.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "DrawingViewController.h"
#import "popOverSliderIphoneViewController.h"
#import "BrushViewController.h"
#import "RGBViewController.h"
@interface DrawingViewController ()

@end
int r,g,b,brush;
BOOL boolErease;
@implementation DrawingViewController
@synthesize popOver;

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
    
    red = 255.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    
    self.scratchPad.drawColor =[UIColor colorWithRed:red green:green blue:blue alpha:1];
    self.scratchPad.drawWidth = brush;
}
-(void) gotoBack:(id) sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingControl];
}

-(IBAction)colorPressed:(id)sender{
    UIButton * ColorButton = (UIButton*)sender;
    switch (ColorButton.tag) {
        case 1:
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 2:
            red = 102.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        case 3:
            red = 102.0/255.0;
            green = 204.0/255.0;
            blue = 0.0/255.0;
            break;
        case 4:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case 5:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            break;
        case 6:
            red = 255.0/255.0;
            green = 102.0/255.0;
            blue = 0.0/255.0;
            break;
        case 7:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
            
        default:
            break;
    }
    self.scratchPad.drawColor =[UIColor colorWithRed:red green:green blue:blue alpha:1];
    self.scratchPad.drawWidth = brush;

}
-(IBAction)eraserPressed:(id)sender{
    redE = 255.0/255.0;
    greenE = 255.0/255.0;
    blueE = 255.0/255.0;
    [self popover:sender];
    self.scratchPad.drawColor =[UIColor colorWithRed:redE green:greenE blue:blueE alpha:1];
    self.scratchPad.drawWidth = brush;
    boolErease = TRUE;
    
}
-(IBAction)save:(id)sender{
    UIImage *image = [self.scratchPad getImage];
    
    UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in photoalbum"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    }
}
-(IBAction)newImage:(id)sender{
    [self.scratchPad clearToColor:[UIColor clearColor]];
}
-(IBAction)advanceColor:(id)sender{
    [self popoverRGB:sender];
    self.scratchPad.drawColor =[UIColor colorWithRed:red green:green blue:blue alpha:1];
    self.scratchPad.drawWidth = brush;

}
-(IBAction)penPressed:(id)sender{
    [self popover:sender];
    boolErease = FALSE;
    self.scratchPad.drawColor =[UIColor colorWithRed:red green:green blue:blue alpha:1];
    self.scratchPad.drawWidth = brush;

}
- (void) sliderHandler: (UISlider *)sender {
    int x = sender.value;
    NSLog(@"Volume: %d", x);
}
-(void) selectedValueBrush:(NSUInteger)value{
    NSLog(@"value %d",value);
    brush = value;
    if (boolErease) {
        self.scratchPad.drawColor =[UIColor colorWithRed:redE green:greenE blue:blueE alpha:1];
    }
    else  self.scratchPad.drawColor =[UIColor colorWithRed:red green:green blue:blue alpha:1];
    self.scratchPad.drawWidth = brush;

}
-(void)selectedvalueRGB:(int) r green:(int) g blue:(int) b{
     NSLog(@"value %d %d %d",r,g,b);
    red = r/255.0;
    green = g/255.0;
    blue = b/255.0;
    self.scratchPad.drawColor =[UIColor colorWithRed:red green:green blue:blue alpha:1];
    self.scratchPad.drawWidth = brush;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)popover:(id)sender
{
    //the controller we want to present as a popover
    BrushViewController *controller = [[BrushViewController alloc] init];
    controller.delegate = self;
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.tint = FPPopoverDefaultTint;
    
    
    popover.contentSize = CGSizeMake(200, 80);
    popover.arrowDirection = FPPopoverArrowDirectionAny;
   // popover.arrowDirection = FPPopoverArrowDirectionRight;
//
    [popover presentPopoverFromView:sender];
    
}
-(void)popoverRGB:(id)sender
{
    //the controller we want to present as a popover
    RGBViewController *controller = [[RGBViewController alloc] init];
    controller.delegate = self;
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.tint = FPPopoverLightGrayTint;
    
    
    popover.contentSize = CGSizeMake(260, 170);
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    // popover.arrowDirection = FPPopoverArrowDirectionRight;
    //
    [popover presentPopoverFromView:sender];
    
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
