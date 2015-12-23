//
//  AMSVerseFMDB.h
//  memory
//
//  Created by Adam Simpson on 12/17/13.
//  Copyright (c) 2013 Adam Simpson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class verseModel;

@interface AMSVerseFMDB : NSObject
@property (strong, nonatomic) verseModel *verseModel;

-(NSMutableArray *) getVerses;
-(void) saveVerse: (NSMutableDictionary *)verseDict;
-(void) removeVerse: (verseModel *)verse;
@end
