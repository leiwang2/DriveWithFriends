//
//  GroupMember.h
//  TelenavNavigator
//
//  Created by gyhuang on 13-7-3.
//  Copyright (c) 2013年 Telenav, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventParticipant : NSObject
@property(strong, nonatomic)NSString* name;
@property(strong, nonatomic)NSString* id;
@property(strong, nonatomic)NSDate* joinDate;
@end
