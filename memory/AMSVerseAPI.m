//
//  AMSVerseAPI.m
//  memory
//
//  Created by Adam Simpson on 12/17/13.
//  Copyright (c) 2013 Adam Simpson. All rights reserved.
//

#import "AMSVerseAPI.h"
#import "AMSVerseFMDB.h"
#import "AMSFormatHTMLEntities.h"

@implementation AMSVerseAPI
- (void)fetchVerse:(NSString *)verse {
  self.AMSVerseFMDB = [[AMSVerseFMDB alloc] init];
  NSString *fullUrl = [NSString stringWithFormat:@"http://labs.bible.org/api/?passage=%@&type=json&formatting=plain", verse];
  
  NSString *encoded = [fullUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
  
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:encoded]];
  
  AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
  
  operation.responseSerializer =[AFJSONResponseSerializer serializer];
  
  operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-javascript"];
  
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSString *book = [responseObject[0] valueForKey:@"bookname"];
    NSString *returnedText = [[responseObject valueForKey:@"text"] componentsJoinedByString:@" "];
    NSString *text = [[AMSFormatHTMLEntities alloc] format:returnedText];
    NSArray *chaptersArray = [responseObject valueForKey:@"chapter"];
    NSArray *versesArray = [responseObject valueForKey:@"verse"];
    
    if ([chaptersArray count] > 1 && chaptersArray[0] != [chaptersArray lastObject]){
      self.complete_reference = [NSString stringWithFormat:@"%@ %@:%@-%@:%@", book, chaptersArray[0], versesArray[0], [chaptersArray lastObject], [versesArray lastObject]];
    }
    else if ([chaptersArray count] > 1 && chaptersArray[0] == [chaptersArray lastObject]){
      self.complete_reference = [NSString stringWithFormat:@"%@ %@:%@-%@", book, chaptersArray[0], versesArray[0], [versesArray lastObject]];
    } else {
      self.complete_reference = [NSString stringWithFormat:@"%@ %@:%@", book, chaptersArray[0], versesArray[0]];
    }
    
    NSMutableDictionary *verseObject = [NSMutableDictionary dictionaryWithObject:text forKey:@"verse"];
    
    [verseObject setObject:self.complete_reference forKey:@"reference"];
    
    [self.AMSVerseFMDB saveVerse:verseObject];
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    NSLog(@"%@", error.localizedDescription);
    
  }];
  
  [operation start];
  
}

@end
