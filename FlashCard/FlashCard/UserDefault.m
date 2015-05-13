//
//  UserDefault.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/15/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "UserDefault.h"
#import "SettingTable.h"
@implementation UserDefault
-(void) setUserDefault{
    SettingTable *setting =[[SettingTable alloc]init];
    NSUserDefaults *defaultSetting = [NSUserDefaults standardUserDefaults];
    if([defaultSetting integerForKey:@"idSetting"]==0){
        SettingDTO *dto =[setting getSetting];
        [defaultSetting setInteger:dto.idSetting forKey:@"idSetting"];
        [defaultSetting setInteger:1 forKey:@"language"];
        [defaultSetting setInteger:dto.volume forKey:@"volume"];
        [defaultSetting setInteger:dto.swipe forKey:@"swipe"];
        NSLog(@"set default setting complete");
    }
    else{
        NSLog(@"default setting is exits");
    }
}
-(void) setUserDefault:(int) language withVolume:(int) volume withSwipe:(int) swipe{
    NSUserDefaults *defaultSetting = [NSUserDefaults standardUserDefaults];
    [defaultSetting setInteger: 1 forKey:@"idSetting"];
    [defaultSetting setInteger:language forKey:@"language"];
    [defaultSetting setInteger:volume forKey:@"volume"];
    [defaultSetting setInteger:swipe forKey:@"swipe"];
}
-(SettingDTO *) getUserDefault{
    SettingDTO *dto= [[SettingDTO alloc]init];
    NSUserDefaults *defaulSetting= [NSUserDefaults standardUserDefaults];
    dto.idSetting = [defaulSetting integerForKey:@"idSetting"];
    dto.language = [defaulSetting integerForKey:@"language"];
    dto.volume =[defaulSetting integerForKey:@"volume"];
    dto.swipe =[defaulSetting integerForKey:@"swipe"];
    return dto;
}
@end
