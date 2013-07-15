//
//  SetDateViewController.m
//  TelenavNavigator
//
//  Created by gyhuang on 13-6-28.
//  Copyright (c) 2013年 Telenav, Inc. All rights reserved.
//

#import "DWFDatePickerViewController.h"
#import <UIKit/UIDatePicker.h>
#import <QuartzCore/QuartzCore.h>
#import "UIColor+plist.h"
#import <UIKit/UIColor.h>
#import "TnAlertView.h"

typedef enum _DWFDateType {
    DWFDateTypeStartDate,
    DWFDateTypeEndDate
}DWFDateType;

@interface DWFDatePickerViewController ()
{
@private
    NSDate* _startDate;
    NSDate* _endDate;
    DWFDateType curSettingType;
}
-(void)dateChanged:(id)sender;
-(void)handleSingleTapAtStartTime:(UIGestureRecognizer *)gestureRecognizer;
-(void)handleSingleTapAtEndTime:(UIGestureRecognizer *)gestureRecognizer;
-(NSString*)getDateStringFromDate:(NSDate*)date;
-(BOOL)checkIfDateAvailable;
-(void)doneButtonTapped;
-(void)focuseOnStartLabel;
-(void)focuseOnEndLabel;
@end

@implementation DWFDatePickerViewController
@synthesize startRowView;
@synthesize startStaticLabel;
@synthesize startTimeLabel;
@synthesize endRowView;
@synthesize endStaticLabel;
@synthesize endTimeLabel;
@synthesize timePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)setStartAndEndTime:(NSDate*)startDate endTime:(NSDate*)endDate
{
    startTimeLabel.text = [self getDateStringFromDate:startDate];
    endTimeLabel.text = [self getDateStringFromDate:endDate];
    timePicker.date = startDate;
    _startDate = startDate;
    _endDate = endDate;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [timePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    
    curSettingType = DWFDateTypeStartDate;
    
    [self.startRowView.layer setCornerRadius:6.0];
    [self.startRowView.layer setMasksToBounds:YES];
    
    [self.endRowView.layer setCornerRadius:6.0];
    [self.endRowView.layer setMasksToBounds:YES];
    
    [self.view addSubview:startRowView];
    [self.view addSubview:endRowView];
    
    _startDate = timePicker.date;
    _endDate = [_startDate initWithTimeInterval:3600 sinceDate:_startDate];
    
    self.startTimeLabel.text = [self getDateStringFromDate:_startDate];
    self.endTimeLabel.text = [self getDateStringFromDate:_endDate];
    
    self.view.backgroundColor = [UIColor tableViewBackgroundColor];
    
    UITapGestureRecognizer* singleFingerTapRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapAtStartTime:)];
    [self.startRowView addGestureRecognizer:singleFingerTapRecognizer1];
    
    UITapGestureRecognizer* singleFingerTapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapAtEndTime:)];
    [self.endRowView addGestureRecognizer:singleFingerTapRecognizer2];
    
    UIBarButtonItem * DoneBar = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil)
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(doneButtonTapped)];
    
    self.navigationItem.rightBarButtonItem = DoneBar;
    //*/
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.startRowView setBackgroundColor:[UIColor blueColor]];
    [self.startStaticLabel setTextColor:[UIColor whiteColor]];
    [self.startTimeLabel setTextColor:[UIColor whiteColor]];
    
    [self.endRowView setBackgroundColor:[UIColor whiteColor]];
    [self.endStaticLabel setTextColor:[UIColor colorWithRed:0.219608f green:0.329412f blue:0.529412f alpha:1.0f]];
    [self.endTimeLabel setTextColor:[UIColor colorWithRed:0.219608f green:0.329412f blue:0.529412f alpha:1.0f]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setStartTimeLabel:nil];
    [self setEndTimeLabel:nil];
    [self setTimePicker:nil];
    [self setStartStaticLabel:nil];
    [self setEndStaticLabel:nil];
    [self setStartRowView:nil];
    [self setEndRowView:nil];
    [super viewDidUnload];
}
- (BOOL)checkIfDateAvailable
{
    if(![_startDate isEqualToDate:[_startDate earlierDate:_endDate]])
        return NO;
    return YES;
}

-(NSString*)getDateStringFromDate:(NSDate*)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = kCFDateFormatterFullStyle;
    formatter.timeStyle = kCFDateFormatterShortStyle;
    [formatter setWeekdaySymbols:[formatter shortWeekdaySymbols]];
    [formatter setMonthSymbols:[formatter shortMonthSymbols]];
    
    NSString* strDate = [formatter stringFromDate:date];
    return strDate;
}

-(void)dateChanged:(id)sender{
    if(curSettingType == DWFDateTypeStartDate)
    {
        _startDate = timePicker.date;
        startTimeLabel.text = [self getDateStringFromDate:_startDate];
        
        [self focuseOnStartLabel];
    }
    else if(curSettingType == DWFDateTypeEndDate)
    {
        _endDate = timePicker.date;
        endTimeLabel.text = [self getDateStringFromDate:_endDate];
        
        [self focuseOnEndLabel];
    }
}
-(void)focuseOnStartLabel
{
    if(![self checkIfDateAvailable])
    {
        startTimeLabel.textColor = [UIColor redColor];
        endTimeLabel.textColor = [UIColor redColor];
    }
    else
    {
        startTimeLabel.textColor = [UIColor whiteColor];
        endTimeLabel.textColor = [UIColor colorWithRed:0.219608f green:0.329412f blue:0.529412f alpha:1.0f];
    }

}
-(void)focuseOnEndLabel
{
    if(![self checkIfDateAvailable])
    {
        startTimeLabel.textColor = [UIColor redColor];
        endTimeLabel.textColor = [UIColor redColor];
    }
    else
    {
        startTimeLabel.textColor = [UIColor colorWithRed:0.219608f green:0.329412f blue:0.529412f alpha:1.0f];
        endTimeLabel.textColor = [UIColor whiteColor];
    }

}

-(void)handleSingleTapAtStartTime:(UIGestureRecognizer *)gestureRecognizer
{
    if(_startDate!=nil)
        timePicker.date = _startDate;
    curSettingType = DWFDateTypeStartDate;
    [self focuseOnStartLabel];
    [self.startRowView setBackgroundColor:[UIColor blueColor]];
    [self.startStaticLabel setTextColor:[UIColor whiteColor]];
    
    [self.endRowView setBackgroundColor:[UIColor whiteColor]];
    [self.endStaticLabel setTextColor:[UIColor colorWithRed:0.219608f green:0.329412f blue:0.529412f alpha:1.0f]];
}
-(void)handleSingleTapAtEndTime:(UIGestureRecognizer *)gestureRecognizer
{
    if(_endDate != nil)
        timePicker.date = _endDate;
    curSettingType = DWFDateTypeEndDate;
    [self focuseOnEndLabel];
    [self.endRowView setBackgroundColor:[UIColor blueColor]];
    [self.endStaticLabel setTextColor:[UIColor whiteColor]];
    
    [self.startRowView setBackgroundColor:[UIColor whiteColor]];
    [self.startStaticLabel setTextColor:[UIColor colorWithRed:0.219608f green:0.329412f blue:0.529412f alpha:1.0f]];
    
}
-(void)setDateChangeDelegate:(id<DWFDateChangeDelegate>)delegate
{
    _dwfDateDelegate = delegate;
}
-(void)doneButtonTapped
{
    if(nil == _endDate || nil == _startDate || ![self checkIfDateAvailable]){
        NSString* noMatchFound = [NSString localizedStringWithFormat:@"The start date must before the end date."];
        TnAlertView *message = [[TnAlertView alloc] initWithTitle:@"Can not Save"
                                                          message:noMatchFound
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        return;
    }
    
    if(_dwfDateDelegate && [_dwfDateDelegate respondsToSelector:@selector(dwfDateChanged:end:)]){
        [_dwfDateDelegate dwfDateChanged:_startDate end:_endDate];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
