//
//  GatherFriendsViewController.m
//  TelenavNavigator
//
//  Created by gyhuang on 13-6-28.
//  Copyright (c) 2013年 Telenav, Inc. All rights reserved.
//

#import "DriveWithFriendsViewController.h"
#import "FriendTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+plist.h"
#import "UIKit/UIGestureRecognizer.h"
#import "DWFDatePickerViewController.h"
#import "AddressBookBridge.h"
#import "CustomizedEvent.h"
#import "EventParticipant.h"

#define kContactNameKey @"key_contact_name"
#define kPhoneNumberKey @"key_phonenum"
@interface DriveWithFriendsViewController()
{
    
@private
    NSMutableArray* _friends;
    NSDate* _eventStartDate;
    NSDate* _eventEndDate;
}
@end

@implementation DriveWithFriendsViewController
@synthesize locationLabel;
@synthesize startTimeLabel;
@synthesize endTimeLabel;
@synthesize FriendsTableView;
@synthesize dateView;
@synthesize friendsScrollView;
@synthesize locationView;
@synthesize doneButton;
@synthesize addContactButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.FriendsTableView registerClass:[FriendTableViewCell class] forCellReuseIdentifier:@"FriendCellIdentifier"];
    
    [self.dateView.layer setCornerRadius:6.0];
    [self.dateView.layer setMasksToBounds:YES];
    
    [self.locationView.layer setCornerRadius:6.0];
    [self.locationView.layer setMasksToBounds:YES];
    
    [self.FriendsTableView.layer setCornerRadius:6.0];
    [self.FriendsTableView.layer setMasksToBounds:YES];
    
    [self.friendsScrollView.layer setCornerRadius:9.0];
    [self.friendsScrollView.layer setMasksToBounds:YES];
    
    [self.doneButton addTarget:self action:@selector(doneButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.addContactButton addTarget:self action:@selector(addContact:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer* singleFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.dateView addGestureRecognizer:singleFingerTapRecognizer];
    
    _friends = [NSMutableArray arrayWithCapacity:10];
    self.view.backgroundColor = [UIColor tableViewBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.dateView setBackgroundColor:[UIColor whiteColor]];
    [self.startTimeLabel setTextColor:[UIColor colorWithRed:0.219608f green:0.329412f blue:0.529412f alpha:1.0f]];
    [self.endTimeLabel setTextColor:[UIColor colorWithRed:0.219608f green:0.329412f blue:0.529412f alpha:1.0f]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.title = @"Creat Event";
    if(self.location == nil)
        return;
    else if(self.location.name != nil)
        self.locationLabel.text = self.location.name;
    else
        self.locationLabel.text = self.location.displayAddress.formattedAddress;
}
- (void)viewDidUnload {
    [self setLocationLabel:nil];
    [self setStartTimeLabel:nil];
    [self setEndTimeLabel:nil];
    [self setFriendsTableView:nil];
    [self setDateView:nil];
    [self setFriendsScrollView:nil];
    [self setLocationView:nil];
    [self setDoneButton:nil];
    [self setAddContactButton:nil];
    [_friends removeAllObjects];
    [super viewDidUnload];
}

- (void)addContact:(id)sender{
    if(!addressBookBridge){
        addressBookBridge = [[AddressBookBridge alloc] init];
        addressBookBridge.delegate = self;
        addressBookBridge.selectionType = AddressBookBridgeContactSelectionTypePhoneNumber;
    }
    [self.navigationController presentModalViewController:[addressBookBridge getViewForContacts] animated:YES];
}

-(void) handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    DLog(@"handleSingleTap");
    [self.dateView setBackgroundColor:[UIColor blueColor]];
    [self.startTimeLabel setTextColor:[UIColor whiteColor]];
    [self.endTimeLabel setTextColor:[UIColor whiteColor]];
    DWFDatePickerViewController* tmpdateView = [[DWFDatePickerViewController alloc] initWithNibName:@"DWFDatePickerViewController" bundle:nil];
    [self.navigationController pushViewController:tmpdateView animated:YES];
    [tmpdateView setDateChangeDelegate:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"FriendCellIdentifier";
    FriendTableViewCell *cell = (FriendTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[FriendTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:MyIdentifier];
    }
    NSDictionary* contact = _friends[indexPath.row];
    if(contact != nil)
    {
        cell.textLabel.text = contact[kContactNameKey];
        cell.detailTextLabel.text = contact[kPhoneNumberKey];
    }
    //cell.textLabel.text = @"name";
    //cell.detailTextLabel.text = @"(012)345678";
	return cell;
}

#pragma mark - UITableViewDelegate

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - done Button
-(void) doneButtonTapped:(id)sender
{
    CustomizedEvent* CEvent = [[CustomizedEvent alloc] init];
    CEvent.startDate = _eventStartDate;
    CEvent.endDate = _eventEndDate;
    CEvent.eventLocation = self.location;
    CEvent.eventTitle = @"test";
    
}
#pragma mark - Address book bridge delegate
-(bool)userSelectPhoneNumber:(NSString *)phoneNumber forContact:(NSString *)contactName fromAddressBook:(AddressBookBridge *)addressBook{
    [self.navigationController dismissViewControllerAnimated:YES completion:^(){}];
    
    // check if this number has already been added

    for(NSDictionary* contact in _friends){
        if([contact[kContactNameKey] isEqualToString:contactName] && [contact[kPhoneNumberKey] isEqualToString:phoneNumber])
            return NO;
    }
    NSDictionary* dict = @{kContactNameKey: contactName,
                           kPhoneNumberKey: phoneNumber};
    [_friends addObject:dict];
    [self.FriendsTableView reloadData];
    return NO; // we handle it so OS doesn't need to handle this selection
}

-(void)cancelAddressBook:(AddressBookBridge *)addressBook{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
- (void)addressSelector:(id)addressSelector didSelectPointInterest:(Entity*)poiValue{
}
-(void) userSelectAddress:(NSString *) address cityState:(NSString*)cityState countryCode:(NSString*)countrycode fromAddressBook:(AddressBookBridge *) addressBook{
}
- (void)dwfDateChanged:(NSDate*)startDate end:(NSDate*)endDate;
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = kCFDateFormatterFullStyle;
    formatter.timeStyle = kCFDateFormatterShortStyle;
    [formatter setWeekdaySymbols:[formatter shortWeekdaySymbols]];
    [formatter setMonthSymbols:[formatter shortMonthSymbols]];
    
    _eventStartDate = startDate;
    _eventEndDate = endDate;
    
    NSString* startDateString = [formatter stringFromDate:startDate];
    NSString* endDateString = [formatter stringFromDate:endDate];
    
    startTimeLabel.text = startDateString;
    endTimeLabel.text = endDateString;
}
@end

