//
//  DWFServerAdapter.m
//  TelenavNavigator
//
//  Created by gyhuang on 13-7-4.
//  Copyright (c) 2013年 Telenav, Inc. All rights reserved.
//

#import "DWFServerAdapter.h"

@implementation DWFServerAdapter
-(id) init
{
    self = [super init];
    if(self){
        _server = [[DWFServerRequest alloc] init];
    }
    return self;
}

-(BOOL) createEvent: (CustomizedEvent*) event
{
    return true;
}

-(CustomizedEvent*) getEvent: (NSString*) eventId
{
    CustomizedEvent* event = [[CustomizedEvent alloc] init];
    return event;
}

-(BOOL) joinEvent: (EventParticipant*) user toEvent:(NSString*) eventId
{
    return true;
}

-(BOOL) removeParticipant: (NSString*) userId fromEvent:(NSString*) eventId
{
    return true;
}
@end
