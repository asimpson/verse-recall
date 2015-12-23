//
//  AMSinfoScreen.m
//  Verse Recall
//
//  Created by Adam Simpson on 2/22/14.
//  Copyright (c) 2014 Adam Simpson. All rights reserved.
//

#import "AMSinfoScreen.h"

@implementation AMSinfoScreen

- (void) viewDidLoad {
  [super viewDidLoad];
  
  NSString *termsPath = [[NSBundle mainBundle] pathForResource:@"terms" ofType:@"html"];
  NSString *termsHTML = [NSString stringWithContentsOfFile:termsPath encoding:NSUTF8StringEncoding error:nil];
  NSAttributedString *attributedHTML = [[NSAttributedString alloc] initWithData:[termsHTML dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: [NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:nil error:nil];
  
  UIFont *fontFace = [UIFont fontWithName:@"Avenir Next" size:14];
  
  self.termsTextView.attributedText = attributedHTML;
  
  self.termsTextView.font = fontFace;
}

@end
