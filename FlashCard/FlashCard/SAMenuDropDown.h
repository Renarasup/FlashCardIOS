//
//  SAMenuDropDown.h
//  Spads_Schedule
//
//  Created by Maxmalla - MAC2 on 2/7/14.
//  Copyright (c) 2014 Phan. All rights reserved.
//
#import <UIKit/UIKit.h>


typedef enum {
    
    kSAMenuDropAnimationDirectionTop = 0,
    kSAMenuDropAnimationDirectionBottom,
    // kSAMenuDropAnimationDirectionLeft,
    // kSAMenuDropAnimationDirectionRight
    
}SAMenuDropAnimationDirection;





@protocol SAMenuDropDownDelegate;


@interface SAMenuDropDown : UIView <UITableViewDataSource, UITableViewDelegate>
{
    
}
@property (nonatomic, assign) CGFloat rowHeight;


/*
 Delegate
 */
@property (nonatomic, strong) id <SAMenuDropDownDelegate> delegate;


/*
 Animation Directions.
 Animations in a Specific Directions of SADropDownMenu
 */
@property (nonatomic, assign) SAMenuDropAnimationDirection animationDirection;





/* Button Reference which creats menu */
@property (nonatomic, strong) UIButton *sourceButtom;




/* init methods */
- (id)initWithWithSource:(UIButton *)sender menuHeight:(CGFloat)height itemNames:(NSArray *)nameArray  itemImagesName:(NSArray *)imageArray itemSubtitles:(NSArray *)subtitleArray;
- (id)initWithSource:(UIButton *)sender menuHeight:(CGFloat)height itemName:(NSArray *)nameArray;


/* Instance Method to show & hide menu */
- (void)showSADropDownMenuWithAnimation:(SAMenuDropAnimationDirection)animation;
- (void)hideSADropDownMenu;

@end








/*
 Protocols
 */


@protocol SAMenuDropDownDelegate <NSObject>


@required
- (void)saDropMenu:(SAMenuDropDown *)menuSender didClickedAtIndex:(NSInteger)buttonIndex didClickItem:(NSString*) itemName;
//- (void)saDropMenu:(SAMenuDropDown *)menuSender willClickedAtIndex:(NSInteger)buttonIndex;


@optional
//not implemented yet

@end