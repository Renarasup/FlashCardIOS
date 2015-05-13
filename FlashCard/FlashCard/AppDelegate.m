//
//  AppDelegate.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/14/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "AppDelegate.h"
#import "DBAccess.h"
#import "UserDefault.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"tab_up.png"] forBarMetrics:UIBarMetricsDefault];
    DBAccess *db= [[DBAccess alloc]init];
    [db initDatabase];
    
    UserDefault *userDefault=[[UserDefault alloc]init];
    [userDefault setUserDefault];
    
    //UIImage *navBackgroundImage = [UIImage imageNamed:@"navbar_bg"];
   //[[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:2/255.f green:105/255.f blue:173/255.f alpha:1]];
    UIStoryboard *mainStoryboard = nil;
    
    if(IPAD){
        if(IOS7)
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
        else  mainStoryboard = [UIStoryboard storyboardWithName:@"iPad_IOS6" bundle:nil];
    }
    else {
    if (IOS7) {
        
        if(IS_IPHONE5)
            
            mainStoryboard = [UIStoryboard storyboardWithName:@"iPhone5_IOS7" bundle:nil];
        
        else  mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        
    } else {
        
        if([[UIScreen mainScreen] bounds].size.height >= 568)
            
            mainStoryboard = [UIStoryboard storyboardWithName:@"iPhone5_IOS6" bundle:nil];
        
        else
            
            mainStoryboard = [UIStoryboard storyboardWithName:@"iPhone4_IOS6" bundle:nil];
        
    }
    }
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = [mainStoryboard instantiateInitialViewController];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
