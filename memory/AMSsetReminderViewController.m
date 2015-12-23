//
//  AMSsetReminderViewController.m
//  
//
//  Created by Adam Simpson on 12/19/13.
//
//

#import "AMSsetReminderViewController.h"

@interface AMSsetReminderViewController ()
- (NSDate *) scheduleNotificationFor: (NSInteger) hour : (NSInteger) minute;
@end

@implementation AMSsetReminderViewController

- (void) viewDidLoad {
  [super viewDidLoad];
}

- (void) setAlarm:(id)verseInfo{
  if (_verse != verseInfo) {
    _verse = verseInfo;
    
    // Update the view.
    [self configureView];
  }
}

- (void) configureView {
  NSArray *arrayOfLocalNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];

  if (self.verse) {
    self.reference = [self.verse valueForKey:@"reference"];
    self.verseText = [self.verse valueForKey:@"verse"];
  }
  
  for (UILocalNotification *localNotification in arrayOfLocalNotifications) {
    if ([localNotification.alertAction isEqualToString:self.reference]) {
      self.verseLocalNotification = localNotification;
    }
  }
}

- (IBAction)saveNewReminder:(id)sender {
  self.reminder = [[UILocalNotification alloc] init];
  NSDate *time = self.timeForReminder.date;
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:time];
  NSInteger hour = [components hour];
  NSInteger minute = [components minute];
  NSDate *fireDate = [self scheduleNotificationFor:hour:minute];
  NSDictionary *verseObject = [NSDictionary dictionaryWithObjectsAndKeys:[self.verse valueForKey:@"reference"], @"reference", [self.verse valueForKey:@"verse"], @"verse", nil];
  
  self.reminder.fireDate = fireDate;
  self.reminder.alertAction = self.reference;
  self.reminder.alertBody = self.verseText;
  self.reminder.repeatInterval = NSDayCalendarUnit;
  self.reminder.timeZone = [NSTimeZone defaultTimeZone];
  self.reminder.applicationIconBadgeNumber = 0;
  self.reminder.userInfo = verseObject;
  [[UIApplication sharedApplication] scheduleLocalNotification:self.reminder];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSDate *) scheduleNotificationFor: (NSInteger)hour : (NSInteger)minute {
  NSCalendar *calendar = [NSCalendar currentCalendar];
  
  NSDateComponents *components = [[NSDateComponents alloc] init];
  [components setHour: hour];
  [components setMinute: minute];
  [components setSecond: 0];
  
  return [calendar dateFromComponents:components];
}

- (IBAction) cancelReminderAndReturnToDetail:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)deleteAllRemindersForVerse:(id)sender {
  if (self.verseLocalNotification) {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Delete Reminders" message:@"Are you sure you want to delete the reminder for this verse?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    [message show];
  }
  else {
   UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Delete Reminders" message:@"No Reminders are set for this verse." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [message show];
  }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
  
    if ([title isEqualToString:@"Delete"]) {
      [[UIApplication sharedApplication] cancelLocalNotification:self.verseLocalNotification];
    }
}

@end