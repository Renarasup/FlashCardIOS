//
//  UserDefault.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/15/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingDTO.h"
@interface UserDefault : NSObject
-(void) setUserDefault;
-(void) setUserDefault:(int) language withVolume:(int) volume withSwipe:(int) swipe;
-(SettingDTO *) getUserDefault;
@end
