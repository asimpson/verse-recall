//
//  AMSVerseFMDB.m
//  memory
//
//  Created by Adam Simpson on 12/17/13.
//  Copyright (c) 2013 Adam Simpson. All rights reserved.
//

#import "AMSVerseFMDB.h"
#import "verseModel.h"

@interface  AMSVerseFMDB ()
-(NSString *) getDBFileName;
-(NSString *) getCurrentDate;
@end

@implementation AMSVerseFMDB
-(NSMutableArray *) getVerses {
  NSMutableArray *verses = [[NSMutableArray alloc] init];
  NSString *dbFileName = [self getDBFileName];
  
  FMDatabase *db = [FMDatabase databaseWithPath:dbFileName];
  
  [db open];
  
  FMResultSet *results = [db executeQuery:@"SELECT * FROM verses"];
  
  while([results next])
  {
    verseModel *verse = [[verseModel alloc] init];
    
    verse.reference = [results stringForColumn:@"reference"];
    verse.verse = [results stringForColumn:@"verse"];
    verse.date = [results stringForColumn:@"date_created"];
    [verses addObject:verse];
  }
  
  [db close];
  
  return verses;
}

-(void) saveVerse: (NSMutableDictionary *)verseDict {
  NSString *date = [self getCurrentDate];
  NSString *dbFileName = [self getDBFileName];
  FMDatabase *db = [FMDatabase databaseWithPath:dbFileName];
  
  [db open];
  
  [db executeUpdate:@"INSERT INTO verses (verse,reference,date_created) VALUES (?,?,?);", [verseDict valueForKey:@"verse"],[verseDict valueForKey:@"reference"], date];
  
  [db close];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"Verse Saved" object:self userInfo:verseDict];
}

-(void) removeVerse: (verseModel *)verse {
  NSString *dbFileName = [self getDBFileName];
  FMDatabase *db = [FMDatabase databaseWithPath:dbFileName];
  
  [db open];
  
  [db executeUpdate:@"DELETE FROM verses WHERE reference=(?);", [verse valueForKey:@"reference"]];
  
  [db close];
}

-(NSString *) getDBFileName {
  NSString *fileName = @"memory.db";
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *dbFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
  
  return dbFileName;
}

-(NSString *) getCurrentDate {
  NSDate *now = [NSDate date];
  NSDateFormatter *formatNow = [[NSDateFormatter alloc]init];
  
  [formatNow setDateFormat:@"yyyy-mm-dd"];
  NSString *date = [[NSString alloc]initWithString:[formatNow stringFromDate:now]];
  
  return date;
}

@end
