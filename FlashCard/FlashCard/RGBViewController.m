//
//  RGBViewController.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 6/16/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "RGBViewController.h"
#import "DrawingViewController.h"
@interface RGBViewController ()

@end
UISlider *redControl;
UISlider *greenControl;
UISlider *blueControl;
UILabel *redLabel;
UILabel *greenLabel;
UILabel *blueLabel;
UIImageView *colorRGB;
int r,g,b;
@implementation RGBViewController
@synthesize red;
@synthesize green;
@synthesize blue;
@synthesize delegate=_delegate;

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
    // Do any additional setup after loading the view.
    [self initControl];
}
-(void) initControl{
    
    colorRGB = [[UIImageView alloc]initWithFrame:CGRectMake(10.0, 100.0, 220.0, 20.0)];
    [colorRGB setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:colorRGB];
    CGRect frameR = CGRectMake(5.0, 10.0, 140.0, 15.0);
    UISlider *sliderR = [[UISlider alloc] initWithFrame:frameR];
    [sliderR addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [sliderR setBackgroundColor:[UIColor clearColor]];
    sliderR.minimumValue = 0.0;
    sliderR.maximumValue = 255.0;
    sliderR.continuous = YES;
    sliderR.value = 0.0;
    sliderR.tag = 1;
    [self.view addSubview:sliderR];
    
    //CGRect frameLB = CGRectMake(5.0, 10.0, 150.0, 15.0);
    redLabel =[[UILabel alloc] initWithFrame:CGRectMake(150.0, 10.0, 100.0, 15.0)];
    [redLabel setBackgroundColor:[UIColor clearColor]];
    [redLabel setTextColor:[UIColor redColor]];
    [redLabel setText:[NSString stringWithFormat:@"Red: %d",0]];
    [self.view addSubview:redLabel];
    
    CGRect frameG = CGRectMake(5.0, 40.0, 140.0, 15.0);
    UISlider *sliderG = [[UISlider alloc] initWithFrame:frameG];
    [sliderG addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [sliderG setBackgroundColor:[UIColor clearColor]];
    sliderG.minimumValue = 0.0;
    sliderG.maximumValue = 255.0;
    sliderG.continuous = YES;
    sliderG.value = 0.0;
    sliderG.tag =2;
    [self.view addSubview:sliderG];
    
    //CGRect frameLB = CGRectMake(5.0, 10.0, 150.0, 15.0);
    greenLabel =[[UILabel alloc] initWithFrame:CGRectMake(150.0, 40.0, 100.0, 15.0)];
    [greenLabel setBackgroundColor:[UIColor clearColor]];
    [greenLabel setTextColor:[UIColor greenColor]];
    [greenLabel setText:[NSString stringWithFormat:@"Green: %d",0]];
    [self.view addSubview:greenLabel];
    
    CGRect frameB = CGRectMake(5.0, 70.0, 140.0, 15.0);
    UISlider *sliderB = [[UISlider alloc] initWithFrame:frameB];
    [sliderB addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [sliderB setBackgroundColor:[UIColor clearColor]];
    sliderB.minimumValue = 0.0;
    sliderB.maximumValue = 255.0;
    sliderB.continuous = YES;
    sliderB.value = 0.0;
    sliderB.tag = 3;
    [self.view addSubview:sliderB];
    
    //CGRect frameLB = CGRectMake(5.0, 10.0, 150.0, 15.0);
    blueLabel =[[UILabel alloc] initWithFrame:CGRectMake(150.0, 70.0, 100.0, 15.0)];
    [blueLabel setBackgroundColor:[UIColor clearColor]];
    [blueLabel setTextColor:[UIColor blueColor]];
    [blueLabel setText:[NSString stringWithFormat:@"Blue: %d",0]];
    [self.view addSubview:blueLabel];
    

}
-(void)sliderAction:(id)sender
{    UISlider * changedSlider = (UISlider*)sender;
    
    if(changedSlider.tag == 1) {
        
        red = changedSlider.value/255.0;
        r = (int)changedSlider.value;
        redLabel.text = [NSString stringWithFormat:@"Red: %d", (int)changedSlider.value];
        
    } else if(changedSlider.tag == 2){
        
        green = changedSlider.value/255.0;
        g = (int)changedSlider.value;
        greenLabel.text = [NSString stringWithFormat:@"Green: %d", (int)changedSlider.value];
    } else if (changedSlider.tag == 3){
        
        blue = changedSlider.value/255.0;
        b = (int)changedSlider.value;
        blueLabel.text = [NSString stringWithFormat:@"Blue: %d", (int)changedSlider.value];
        
    }
   
    [colorRGB setBackgroundColor:
     [UIColor colorWithRed:r/255.0f
                     green:g/255.0f
                      blue:b/255.0f
                     alpha:1.0f]];
    if([self.delegate respondsToSelector:@selector(selectedvalueRGB:green:blue:)])
    {
        [self.delegate selectedvalueRGB:(int) r green:(int)g blue:(int)b];
    }
    
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
