//
//  LanguageTable.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/15/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "LanguageTable.h"

@implementation LanguageTable
-(NSMutableArray *) getDataLanguage:(int) language{
    NSMutableArray *arr= [[NSMutableArray alloc]init];
    NSString *dbPath = [self getDBPath];
    NSString *sqlile = [NSString stringWithFormat:@"select * from DataLanguage"];
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        if (sqlite3_prepare_v2(database, [sqlile UTF8String], -1, &stm, NULL) == SQLITE_OK) {
            while (sqlite3_step(stm) == SQLITE_ROW) {
                DataLanguageDTO *dto= [[DataLanguageDTO alloc]init];
                dto.idLanguage = sqlite3_column_int(stm, 0);
                dto.imageName = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stm, 4)];
                dto.finishedPuzzle = sqlite3_column_int(stm, 9);
                dto.movePuzzle = sqlite3_column_int(stm, 10);
                dto.finishedFill = sqlite3_column_int(stm, 11);
                dto.timeFill =  [NSString stringWithUTF8String:(char*)sqlite3_column_text(stm, 12)];
                if(language==1){
                    dto.name = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stm, 1)];
                    dto.sound = [NSString stringWithUTF8String:(char*)sqlite3_column_text(stm, 6)];
                }
                else if(language==2)
                {
                    dto.name =  [NSString stringWithUTF8String:(char*)sqlite3_column_text(stm, 3)];
                    dto.sound =  [NSString stringWithUTF8String:(char*)sqlite3_column_text(stm, 8)];
                }
                else{
                    dto.name =  [NSString stringWithUTF8String:(char*)sqlite3_column_text(stm, 2)];
                    dto.sound =  [NSString stringWithUTF8String:(char*)sqlite3_column_text(stm, 7)];
                }
                
                [arr addObject:dto];
            }
        }
    }
    return arr;
}
-(void) updateCardFinishedPuzzle:(int) idCard withmove:(int) move{
    NSString *dbPath = [self getDBPath];
    NSString *sql = [NSString stringWithFormat:@"update DataLanguage set finishedpuzzle= 1, movepuzzle ='%d' where id='%d'", move, idCard];
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stm, NULL) == SQLITE_OK) {
            if (SQLITE_DONE == sqlite3_step(stm)) {
                sqlite3_reset(stm);
                NSLog(@"update success Book mark");
            }
            else NSLog(@"error update %s", sqlite3_errmsg(database));
        }
        else NSLog(@"error update table SESSION %s", sqlite3_errmsg(database));
        sqlite3_finalize(stm);
    }
}
-(void) updateCardFinishedFill:(int) idCard withTime:(NSString *) time{
    NSString *dbPath = [self getDBPath];
    NSString *sql = [NSString stringWithFormat:@"update DataLanguage set finishedfill= 1, timefill ='%@' where id='%d'", time, idCard];
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stm, NULL) == SQLITE_OK) {
            if (SQLITE_DONE == sqlite3_step(stm)) {
                sqlite3_reset(stm);
                NSLog(@"update success Book mark");
            }
            else NSLog(@"error update %s", sqlite3_errmsg(database));
        }
        else NSLog(@"error update table SESSION %s", sqlite3_errmsg(database));
        sqlite3_finalize(stm);
    }
}
@end
