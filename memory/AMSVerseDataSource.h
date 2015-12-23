//
//  AMSVerseDataSource.h
//  memory
//
//  Created by Adam Simpson on 12/12/13.
//  Copyright (c) 2013 Adam Simpson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSVerseDetailViewController.h"
@class verseModel;
@class AMSVerseFMDB;

@interface AMSVerseDataSource : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) verseModel *verseModel;
@property (strong, nonatomic) AMSVerseFMDB *AMSVerseFMDB;
@property (strong, nonatomic) NSMutableArray *verses;
@property (weak, nonatomic) NSDictionary *verseNotif;

- (IBAction)unwindToVerseList:(UIStoryboardSegue *)segue;
- (void)loadInitialData;
- (void)removeLocalNotification:(verseModel *)verse;
@end
