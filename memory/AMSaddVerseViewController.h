//
//  AMSaddVerseViewController.h
//  memory
//
//  Created by Adam Simpson on 12/12/13.
//  Copyright (c) 2013 Adam Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSViewController.h"
@class AMSVerseAPI;

@interface AMSaddVerseViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *GetVerseButton;
@property (strong, nonatomic) AMSVerseAPI *AMSVerseAPI;
@property (weak, nonatomic) IBOutlet UIPickerView *bookPickerView;
@property (strong, nonatomic) NSArray *booksOfTheBible;
@property (strong, nonatomic) NSString *selectedBook;
@property (strong, nonatomic) NSString *selectedReference;
@property (strong, nonatomic) NSString *fullReference;
@property (weak, nonatomic) IBOutlet UITextField *chapterAndVerse;
@property (weak, nonatomic) IBOutlet UIScrollView *addScrollView;

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (void) createReferenceForLookup;
@end
