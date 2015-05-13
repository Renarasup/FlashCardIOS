//
//  DrawingViewController.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import "ARCMacros.h"
#import "DAScratchPadView.h"
#import <QuartzCore/QuartzCore.h>
@interface DrawingViewController : UIViewController <FPPopoverControllerDelegate>{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat redE;
    CGFloat greenE;
    CGFloat blueE;
    CGFloat brush;
    BOOL mouseSwipe;
    FPPopoverController *popover ;
}
@property (unsafe_unretained, nonatomic) IBOutlet DAScratchPadView *scratchPad;

@property (nonatomic,strong) UIPopoverController *popOver;

-(IBAction)penPressed:(UIButton *)sender;
-(IBAction)colorPressed:(id)sender;
-(IBAction)eraserPressed:(id)sender;
-(IBAction)newImage:(id)sender;
-(IBAction)save:(id)sender;
-(IBAction)advanceColor:(id)sender;
-(void)selectedValueBrush:(NSUInteger)value;
-(void)selectedvalueRGB:(int) r green:(int) g blue:(int) b;
@end
