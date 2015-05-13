//
//  DataLanguageDTO.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 4/15/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLanguageDTO : NSObject
@property(assign,nonatomic) int idLanguage;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *imageName;
@property(strong,nonatomic) NSString *sound;
@property(assign,nonatomic) int finishedPuzzle;
@property(assign,nonatomic) int movePuzzle;
@property(assign,nonatomic) int finishedFill;
@property(strong,nonatomic) NSString *timeFill;
@end
