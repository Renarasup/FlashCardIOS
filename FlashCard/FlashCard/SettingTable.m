//
//  SettingTable.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/15/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "SettingTable.h"

@implementation SettingTable
-(SettingDTO*) getSetting{
    SettingDTO *dto= [[SettingDTO alloc]init];
    NSString *dbPath = [self getDBPath];
    NSString *sqlile = [NSString stringWithFormat:@"select * from Setting"];
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        if (sqlite3_prepare_v2(database, [sqlile UTF8String], -1, &stm, NULL) == SQLITE_OK) {
            while (sqlite3_step(stm) == SQLITE_ROW) {
                dto.idSetting = sqlite3_column_int(stm, 0);
                dto.language = sqlite3_column_int(stm, 1);
                dto.volume = sqlite3_column_int(stm, 2);
                dto.swipe = sqlite3_column_int(stm, 3);
               
            }
        }
    }
    return dto;
}
@end
