//
//  DefinedGlobal.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/15/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#ifndef FlashCard_DefinedGlobal_h
#define FlashCard_DefinedGlobal_h

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)?YES:NO

#endif
