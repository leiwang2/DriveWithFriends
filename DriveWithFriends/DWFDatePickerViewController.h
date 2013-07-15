//
//  SetDateViewController.h
//  TelenavNavigator
//
//  Created by gyhuang on 13-6-28.
//  Copyright (c) 2013年 Telenav, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DWFDateChangeDelegate.h>
@interface DWFDatePickerViewController : UIViewController
{
    id<DWFDateChangeDelegate> __weak _dwfDateDelegate;
}
-(void)setDateChangeDelegate:(id<DWFDateChangeDelegate>)delegate;

@property (strong, nonatomic) IBOutlet UIView *startRowView;
@property (strong, nonatomic) IBOutlet UILabel *startStaticLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;

@property (strong, nonatomic) IBOutlet UIView *endRowView;
@property (strong, nonatomic) IBOutlet UILabel *endStaticLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;

@property (strong, nonatomic) IBOutlet UIDatePicker *timePicker;
@end
