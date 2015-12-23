//
//  AMSVerseDataSource.m
//  memory
//
//  Created by Adam Simpson on 12/12/13.
//  Copyright (c) 2013 Adam Simpson. All rights reserved.
//

#import "AMSVerseDataSource.h"
#import "verseModel.h"
#import "AMSVerseFMDB.h"
#import "AMSVerseDetailViewController.h"

@interface AMSVerseDataSource ()

@end

@implementation AMSVerseDataSource

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // fix for separators bug in iOS 7
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
  
  self.verseModel = [[verseModel alloc] init];
  self.AMSVerseFMDB = [[AMSVerseFMDB alloc] init];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableData:) name:@"Verse Saved" object:nil];
  
  [self loadInitialData];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToDetailFromNotif:) name:@"verseNotif" object:nil];
  }
  return self;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (IBAction)unwindToVerseList:(UIStoryboardSegue *)segue {
}

- (IBAction)unwindToMainFromInfo:(UIStoryboardSegue *)segue{
}

- (void) reloadTableData: (NSNotification *)notification {
  if ([[notification name] isEqualToString:@"Verse Saved"]) {
    self.verses = [self.AMSVerseFMDB getVerses];
    [self.tableView reloadData];
  }
}

- (void) goToDetailFromNotif: (NSNotification *)notification {
  if ([[notification name] isEqualToString:@"verseNotif"]) {
    self.verseNotif = notification.userInfo;
    [self performSegueWithIdentifier:@"openToVerse" sender:self];
  }
}

- (void)loadInitialData {
  self.verses = [self.AMSVerseFMDB getVerses];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.verses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"VersePrototypeCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
  verseModel *verse = [self.verses objectAtIndex:indexPath.row];
  cell.textLabel.text = verse.reference;
  
  return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([[segue identifier] isEqualToString:@"verseDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    verseModel *verse = [self.verses objectAtIndex:indexPath.row];
    [[segue destinationViewController] setVerseText:verse];
  }
  
  if ([[segue identifier] isEqualToString:@"openToVerse"]) {
    [[segue destinationViewController] setVerseText:self.verseNotif];
  }
}

-(void)removeLocalNotification:(verseModel *)verse {
  NSArray *arrayOfLocalNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
  for (UILocalNotification *localNotification in arrayOfLocalNotifications) {
    if ([localNotification.alertAction isEqualToString:verse.reference]) {
      [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
    }
  }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  verseModel *verse = [self.verses objectAtIndex:indexPath.row];
  [self.verses removeObjectAtIndex:indexPath.row];
  [self removeLocalNotification:verse];
  [self.AMSVerseFMDB removeVerse:verse];
  [self.tableView reloadData];
}

@end
