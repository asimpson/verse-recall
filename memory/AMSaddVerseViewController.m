//
//  AMSaddVerseViewController.m
//  memory
//
//  Created by Adam Simpson on 12/12/13.
//  Copyright (c) 2013 Adam Simpson. All rights reserved.
//

#import "AMSaddVerseViewController.h"
#import "AMSViewController.h"
#import "AMSVerseAPI.h"


@implementation AMSaddVerseViewController
- (void)viewDidLoad
{
  [super viewDidLoad];
  [self registerForKeyboardNotifications];
  self.AMSVerseAPI = [[AMSVerseAPI alloc] init];
  self.booksOfTheBible  = @[@"Genesis",@"Exodus",@"Leviticus",@"Numbers",@"Deuteronomy",@"Joshua", @"Judges", @"Ruth", @"1 Samuel", @"2 Samuel", @"1 Kings", @"2 Kings", @"1 Chronicles", @"2 Chronicles", @"Ezra", @"Nehemiah", @"Esther", @"Job", @"Psalms", @"Proverbs", @"Ecclesiastes", @"Song of Solomon", @"Isaiah", @"Jeremiah", @"Lamentations", @"Ezekiel", @"Daniel", @"Hosea", @"Joel", @"Amos", @"Obadiah", @"Jonah", @"Micah", @"Nahum", @"Habakkuk", @"Zephaniah", @"Haggai", @"Zechariah", @"Malachi", @"Matthew", @"Mark", @"Luke", @"John", @"Acts", @"Romans", @"1 Corinthians", @"2 Corinthians", @"Galatians", @"Ephesians", @"Philippians", @"Colossians", @"1 Thessalonians", @"2 Thessalonians", @"1 Timothy", @"2 Timothy", @"Titus", @"Philemon", @"Hebrews", @"James", @"1 Peter", @"2 Peter", @"1 John", @"2 John", @"3 John", @"Jude", @"Revelation"];
  self.chapterAndVerse.delegate = self;
}

- (void)registerForKeyboardNotifications
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];

}

- (void)keyboardWasShown:(NSNotification*)aNotification {
  
  //20 isn't magic down below, just moves it from butting against the top bar
  
  NSDictionary* info = [aNotification userInfo];
  CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  CGRect bkgndRect = self.chapterAndVerse.superview.frame;
  bkgndRect.size.height += kbSize.height;
  [self.chapterAndVerse.superview setFrame:bkgndRect];
  [self.addScrollView setContentOffset:CGPointMake(0.0, self.chapterAndVerse.frame.origin.y-(kbSize.height+20)) animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  if ([self.chapterAndVerse.text length] > 0){
    [self createReferenceForLookup];
  }
  [self dismissViewControllerAnimated:YES completion:nil];
  return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if (sender != self.GetVerseButton) return;
  [self.chapterAndVerse resignFirstResponder];
  if ([self.chapterAndVerse.text length] > 0){
    [self createReferenceForLookup];
  }
}

- (void) createReferenceForLookup {
  NSLog(@"create");
  self.selectedReference = self.chapterAndVerse.text;
  self.fullReference = [NSString stringWithFormat:@"%@ %@", self.selectedBook, self.selectedReference];
  [self.AMSVerseAPI fetchVerse:(NSString *)self.fullReference];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
  return 66;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  return [self.booksOfTheBible objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  self.selectedBook = self.booksOfTheBible[row];
}

@end
