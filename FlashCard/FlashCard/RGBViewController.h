//
//  RGBViewController.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 6/16/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DrawingViewController;
@interface RGBViewController : UIViewController
@property (nonatomic,assign) DrawingViewController *delegate;
@property CGFloat brush;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;
@end
