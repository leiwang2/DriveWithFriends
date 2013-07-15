//
//  DriveGroup.h
//  TelenavNavigator
//
//  Created by gyhuang on 13-7-3.
//  Copyright (c) 2013年 Telenav, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventParticipant.h"
#import "Entity.h"
@interface CustomizedEvent : NSObject
{
    @private
    NSMutableArray* _participants;
}
@property(strong,nonatomic) NSString* eventId;
@property(strong,nonatomic) NSString* eventPin;
@property(strong,nonatomic) NSString* eventTitle;

@property(strong,nonatomic) Entity* eventLocation;
@property(strong,nonatomic) EventParticipant* organizer;

@property(strong,nonatomic) NSDate* createDate;
@property(strong,nonatomic) NSDate* startDate;
@property(strong,nonatomic) NSDate* endDate;

-(void)addParticipant:(EventParticipant*) participant;
-(void)removeParticipant:(NSString*) userId;
-(NSMutableArray*)getAllParticipant;
@end
