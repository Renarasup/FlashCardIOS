//
//  ButtonQues.h
//  FlashCard
//
//  Created by Maxmalla - MAC2 on 6/10/14.
//  Copyright (c) 2014 Maxmalla - MAC2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonQues : NSObject
@property(assign,nonatomic) int tagButton;
@property(strong,nonatomic) UIButton *buttonQ;
@property(strong,nonatomic) NSString *strQ;
@property(assign,nonatomic) int indexKey;
@end
