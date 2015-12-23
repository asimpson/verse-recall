//
//  AMSVerseDetailViewController.m
//  memory
//
//  Created by Adam Simpson on 12/13/13.
//  Copyright (c) 2013 Adam Simpson. All rights reserved.
//

#import "AMSsetReminderViewController.h"
#import "AMSVerseDetailViewController.h"
#import "AMSFormatHTMLEntities.h"

@implementation AMSVerseDetailViewController
- (void)viewDidLoad {
  [super viewDidLoad];

  [self configureView];
}

- (void)setVerseText:(id)newVerseText {
  if (_verseText != newVerseText) {
    _verseText = newVerseText;
    
    // Update the view.
    [self configureView];
  }
}

- (void)configureView {
  // Update the user interface for the detail item.
  if (self.verseText) {
    NSString *unformattedText = [self.verseText valueForKey:@"verse"];
    NSString *text = [[AMSFormatHTMLEntities alloc] format:unformattedText];
    NSString *title = [self.verseText valueForKey:@"reference"];
    self.verseView.text = text;
    self.title = title;
  }
}

- (IBAction)unwindToDetail:(UIStoryboardSegue *)segue {
}

- (IBAction)setAlarmButton:(id)sender {
  [self performSegueWithIdentifier: @"setAlarmSegue" sender: self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"setAlarmSegue"]) {
    AMSsetReminderViewController *reminder = [[[segue destinationViewController] viewControllers] objectAtIndex:0];
    [reminder setAlarm:self.verseText];
//    [self.AMSsetReminderViewController setAlarm:self.verseText];
  }
}
@end
