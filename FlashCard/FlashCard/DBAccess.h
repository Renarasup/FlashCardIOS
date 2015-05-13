//
//  DBAccess.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/15/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface DBAccess : NSObject{
    sqlite3 *database;
}
- (NSString *) getDBPath;
-(void)initDatabase;
@end
