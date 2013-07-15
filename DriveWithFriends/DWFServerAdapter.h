//
//  DWFServerAdapter.h
//  TelenavNavigator
//
//  Created by gyhuang on 13-7-4.
//  Copyright (c) 2013年 Telenav, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DWFServerRequest.h"
#import "CustomizedEvent.h"
#import "EventParticipant.h"

@interface DWFServerAdapter : NSObject
{
    @private
    DWFServerRequest* _server;
}
-(BOOL) createEvent:            (CustomizedEvent*) event;
-(CustomizedEvent*) getEvent:   (NSString*) eventId;
-(BOOL) joinEvent:              (EventParticipant*) user     toEvent:(NSString*) eventId;
-(BOOL) removeParticipant:      (NSString*) userId           fromEvent:(NSString*) eventId;
@end
