//
//  LanguageTable.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/15/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBAccess.h"
#import "DataLanguageDTO.h"
@interface LanguageTable : DBAccess{
    sqlite3_stmt * stm;
}
-(NSMutableArray *) getDataLanguage:(int) language;
-(void) updateCardFinishedPuzzle:(int) idCard withmove:(int) move;
-(void) updateCardFinishedFill:(int) idCard withTime:(NSString *) time;
@end
