//
//  DriveGroup.m
//  TelenavNavigator
//
//  Created by gyhuang on 13-7-3.
//  Copyright (c) 2013年 Telenav, Inc. All rights reserved.
//

#import "CustomizedEvent.h"
@interface CustomizedEvent()

-(BOOL)alreadyJoined:(NSString*) userId;
@end

@implementation CustomizedEvent
@synthesize eventId;
@synthesize eventPin;
@synthesize eventTitle;

@synthesize eventLocation;
@synthesize organizer;

@synthesize createDate;
@synthesize startDate;
@synthesize endDate;
-(id)init
{
    if(self = [super init]){
        _participants = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}
-(void)dealloc
{
    [_participants removeAllObjects];
    _participants = nil;
    self.eventId = nil;
    self.eventPin = nil;
    self.eventTitle = nil;
    self.eventLocation = nil;
    self.organizer= nil;
    self.createDate = nil;
    self.startDate = nil;
    self.endDate = nil;
}
-(void)addParticipant:(EventParticipant*) participant
{
    if(nil == participant || [self alreadyJoined:[participant id]])
        return;
    
    [_participants addObject:participant];
}
-(void)setOrganizer:(EventParticipant *)org
{
    if(nil == org)
        return;
    organizer = org;
    if([self alreadyJoined:[org id]])
        return;
    else
        [_participants addObject:org];
}

-(NSMutableArray*)getAllParticipant
{
    return _participants;
}
-(void)removeParticipant:(NSString*) userId
{
    NSUInteger i = 0;
    for(EventParticipant* ep in _participants)
    {
        if([ep.id isEqualToString:userId])
            [_participants removeObjectAtIndex:i];
        i++;
    }
}
-(BOOL)alreadyJoined:(NSString*) userId
{
    if(userId == nil || [userId length] == 0)
        return false;
    for(EventParticipant* ep in _participants)
    {
        if([ep.id isEqualToString:userId])
            return YES;
    }
    return NO;
}
@end
