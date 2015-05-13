//
//  BrushViewController.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 6/16/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "BrushViewController.h"
#import "DrawingViewController.h"
@interface BrushViewController ()

@end
UILabel *valueBrush;
@implementation BrushViewController
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
    CGRect frame = CGRectMake(5.0, 10.0, 140.0, 15.0);
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 0.0;
    slider.maximumValue = 40.0;
    slider.continuous = YES;
    slider.value = 10.0;
    [self.view addSubview:slider];
    
    //CGRect frameLB = CGRectMake(5.0, 10.0, 150.0, 15.0);
    valueBrush =[[UILabel alloc] initWithFrame:CGRectMake(150.0, 10.0, 30.0, 15.0)];
    [valueBrush setBackgroundColor:[UIColor clearColor]];
    
    [valueBrush setTextColor:[UIColor whiteColor]];
    [valueBrush setText:[NSString stringWithFormat:@"%d",10]];
    [self.view addSubview:valueBrush];
    // Do any additional setup after loading the view.
}
-(void)sliderAction:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;
    int valueI = (int)value;
    [valueBrush setText:[NSString stringWithFormat:@"%d",valueI]];
    if([self.delegate respondsToSelector:@selector(selectedValueBrush:)])
    {
        [self.delegate selectedValueBrush:valueI];
    }
    //-- Do further actions
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
