//
//  AMSFormatHTMLEntities.m
//  Verse Recall
//
//  Created by Adam Simpson on 3/18/14.
//  Copyright (c) 2014 Adam Simpson. All rights reserved.
//

#import "AMSFormatHTMLEntities.h"

@implementation AMSFormatHTMLEntities
-(NSString *) format: (NSString *)string {
  NSAttributedString *formattedString = [[NSAttributedString alloc] initWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
  
  return formattedString.string;
}
@end