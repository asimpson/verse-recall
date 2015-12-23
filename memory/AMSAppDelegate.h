//
//  AMSAppDelegate.h
//  memory
//
//  Created by Adam Simpson on 12/1/13.
//  Copyright (c) 2013 Adam Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) NSDictionary *verse;
-(void) createTable;
- (void) deleteAllNotificationsIfFirstLaunch;
-(void) openToDetailNotification:(UILocalNotification *)localNotif;
@end
