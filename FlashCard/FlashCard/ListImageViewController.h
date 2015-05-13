//
//  ListImageViewController.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 6/5/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListImageViewController;
@protocol listImageDelegate <NSObject>

-(void) didSelectWith:(ListImageViewController*) controller index:(NSInteger) index;

@end

@interface ListImageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,weak) id<listImageDelegate> delegate;
-(void) setBoolFill:(BOOL) flag;
@end
