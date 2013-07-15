//
//  GatherFriendsViewController.h
//  TelenavNavigator
//
//  Created by gyhuang on 13-6-28.
//  Copyright (c) 2013年 Telenav, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AddressSelectorDelegate.h"
#import "AddressBookBridgeDelegate.h"
#import "DWFDateChangeDelegate.h"
@interface DriveWithFriendsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate,AddressSelectorDelegate, AddressBookBridgeDelegate,DWFDateChangeDelegate>{
   AddressBookBridge* addressBookBridge;
}
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (strong, nonatomic) IBOutlet UITableView *FriendsTableView;
@property (strong, nonatomic) IBOutlet UIView *dateView;
@property (strong, nonatomic) IBOutlet UIScrollView *friendsScrollView;
@property (strong, nonatomic) IBOutlet UIView *locationView;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;
@property (strong, nonatomic) IBOutlet UIButton *addContactButton;
@property (strong, nonatomic) Entity* location;
- (void) handleSingleTap:(UIGestureRecognizer *)gestureRecognizer;
@end
