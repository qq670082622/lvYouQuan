//
//  HistoryView.m
//  ShouKeBao
//
//  Created by 金超凡 on 15/3/31.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "HistoryView.h"

@interface HistoryView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *TableView;

@end

@implementation HistoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.TableView];
    }
    return self;
}

#pragma mark - getter
- (UITableView *)TableView
{
    if (!_TableView) {
        _TableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _TableView.dataSource = self;
        _TableView.delegate = self;
    }
    return _TableView;
}

@end
