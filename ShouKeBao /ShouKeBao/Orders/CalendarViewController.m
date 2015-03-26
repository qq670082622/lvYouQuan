//
//  CalendarViewController.m
//  ShouKeBao
//
//  Created by Chard on 15/3/26.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "CalendarViewController.h"
#import "JTCalendar.h"

@interface CalendarViewController ()<JTCalendarDataSource>

@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) JTCalendarContentView *calendarContentView;

@property (weak, nonatomic) NSLayoutConstraint *calendarContentViewHeight;

@property (strong, nonatomic) JTCalendar *calendar;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.calendarMenuView];
    [self.view addSubview:self.calendarContentView];
    self.calendar = [JTCalendar new];
    
    //
    self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
    self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
    self.calendar.calendarAppearance.ratioContentMenu = 1.;
    
    //
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

#pragma mark - getter
- (JTCalendarMenuView *)calendarMenuView
{
    if (!_calendarMenuView) {
        _calendarMenuView = [[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    }
    return _calendarMenuView;
}

- (JTCalendarContentView *)calendarContentView
{
    if (!_calendarContentView) {
        _calendarContentView = [[JTCalendarContentView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50)];
    }
    return _calendarContentView;
}

#pragma mark - JTCalendarDataSource
- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return (rand() % 10) == 1;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"Date: %@", date);
}

@end
