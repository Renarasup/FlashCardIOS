//
//  SettingTable.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/15/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBAccess.h"
#import "SettingDTO.h"
@interface SettingTable :DBAccess{
    sqlite3_stmt *stm;
}
-(SettingDTO*) getSetting;
@end
