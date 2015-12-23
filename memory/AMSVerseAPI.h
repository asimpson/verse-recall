//
//  AMSVerseAPI.h
//  memory
//
//  Created by Adam Simpson on 12/17/13.
//  Copyright (c) 2013 Adam Simpson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AMSVerseFMDB;
@class AMSFormatHTMLEntities;

@interface AMSVerseAPI : NSObject
@property (strong, nonatomic) AMSVerseFMDB *AMSVerseFMDB;
@property (strong, nonatomic) NSString *complete_reference;
- (void) fetchVerse:(NSString *)verse;
@end
