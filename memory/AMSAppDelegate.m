//
//  AMSAppDelegate.m
//  memory
//
//  Created by Adam Simpson on 12/1/13.
//  Copyright (c) 2013 Adam Simpson. All rights reserved.
//

#import "AMSAppDelegate.h"
#import "AFNetworkActivityIndicatorManager.h"
#import <Crashlytics/Crashlytics.h>

@implementation AMSAppDelegate
{
  BOOL passNotificationFlag;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
  [self createTable];
  [Crashlytics startWithAPIKey:@""];
  
  if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
    [self application:application didReceiveLocalNotification:launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]];
  }
  
  [self deleteAllNotificationsIfFirstLaunch];
  
  return YES;
}

- (void) deleteAllNotificationsIfFirstLaunch {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  //If a boolean value is associated with defaultName in the user defaults, that value is returned. Otherwise, NO is returned.
  
  if (![defaults boolForKey:@"removeAllNotifications"]) {
    [defaults setBool:(TRUE) forKey:@"removeAllNotifications"];
    [defaults synchronize];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
  }
}

-(void) createTable {
  NSString *fileName = @"memory.db";
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *dbFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
  FMDatabase *db = [FMDatabase databaseWithPath:dbFileName];
  
  [db open];
  
  [db executeUpdate:@"CREATE TABLE if not exists verses (id INTEGER PRIMARY KEY, reference TEXT, verse TEXT, date_created DATETIME);"];
  
  [db close];
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    app.applicationIconBadgeNumber = 1;
    app.applicationIconBadgeNumber = 0;
    [self openToDetailNotification:notif];
}

-(void) openToDetailNotification:(UILocalNotification *)localNotif {
  self.verse = localNotif.userInfo;
  [[NSNotificationCenter defaultCenter] postNotificationName:@"verseNotif" object:self userInfo:self.verse];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
