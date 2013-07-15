//
//  DatePickDelegate.h
//  TelenavNavigator
//
//  Created by gyhuang on 13-7-2.
//  Copyright (c) 2013年 Telenav, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DWFDateChangeDelegate <NSObject>
@optional
- (void)dwfDateChanged:(NSDate*)startDate end:(NSDate*)endDate;
@end
