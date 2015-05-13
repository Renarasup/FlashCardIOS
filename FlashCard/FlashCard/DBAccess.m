//
//  DBAccess.m
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/15/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import "DBAccess.h"

@implementation DBAccess
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (NSString *) getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"FlashCardDB.sqlite"];
}


-(void)initDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"paths=%@",paths);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath;
    databasePath = [documentsDirectory stringByAppendingPathComponent:@"FlashCardDB.sqlite"];
    BOOL databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:databasePath];
    if (!databaseAlreadyExists)
    {
        NSString *databasePathFromApp;
        databasePathFromApp = [[NSBundle mainBundle] pathForResource:@"FlashCardDB" ofType:@"sqlite"];
        [[NSFileManager defaultManager] copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    }
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        NSLog(@"db opened");
    }
}
@end
