//
//  AMSVerseDetailViewController.h
//  memory
//
//  Created by Adam Simpson on 12/13/13.
//  Copyright (c) 2013 Adam Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMSsetReminderViewController;
@class AMSFormatHTMLEntities;

@interface AMSVerseDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *verseView;
@property (strong, nonatomic) id verseText;

-(void)setVerseText:(id)newVerseText;
- (IBAction)setAlarmButton:(id)sender;
@end
