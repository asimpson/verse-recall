//
//  AMSsetReminderViewController.h
//  
//
//  Created by Adam Simpson on 12/19/13.
//
//

#import <UIKit/UIKit.h>

@interface AMSsetReminderViewController : UIViewController <UIAlertViewDelegate>
@property (strong, nonatomic) id verse;
@property (strong, nonatomic) UILocalNotification *reminder;
@property (strong, nonatomic) UILocalNotification *verseLocalNotification;
@property (strong, nonatomic) NSString *reference;
@property (strong, nonatomic) NSString *verseText;
@property (weak, nonatomic) IBOutlet UIDatePicker *timeForReminder;

- (IBAction) cancelReminderAndReturnToDetail:(id)sender;
- (void) setAlarm:(id)verseInfo;
- (void) configureView;
- (IBAction) saveNewReminder:(id)sender;
- (IBAction) deleteAllRemindersForVerse:(id)sender;
@end