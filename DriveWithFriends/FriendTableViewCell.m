//
//  FriendTableViewCell.m
//  TelenavNavigator
//
//  Created by gyhuang on 13-6-28.
//  Copyright (c) 2013年 Telenav, Inc. All rights reserved.
//

#import "FriendTableViewCell.h"

@implementation FriendTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    // ignore the style argument, use our own to override
    self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier];
    if (self) {
        // If you need any further customization
    }
    return self;
}
@end
