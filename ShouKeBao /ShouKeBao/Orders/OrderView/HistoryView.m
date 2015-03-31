//
//  HistoryView.m
//  ShouKeBao
//
//  Created by 金超凡 on 15/3/31.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "HistoryView.h"
#import "WriteFileManager.h"

@interface HistoryView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *TableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,weak) UIButton *clearBtn;

@end

@implementation HistoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.TableView];
        
        UIButton *clear = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _TableView.frame.size.width, 44)];
        clear.backgroundColor = [UIColor whiteColor];
        clear.hidden = YES;
        [clear setTitle:@"清除历史记录" forState:UIControlStateNormal];
        [clear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [clear addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
        self.TableView.tableFooterView = clear;
        self.clearBtn = clear;
    }
    return self;
}

#pragma mark - getter
- (UITableView *)TableView
{
    if (!_TableView) {
        _TableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height - 10) style:UITableViewStyleGrouped];
        _TableView.dataSource = self;
        _TableView.delegate = self;
        _TableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1];
    }
    return _TableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        
        NSArray *tmp = [WriteFileManager readFielWithName:@"historysearch"];
        
        _dataSource = [NSMutableArray arrayWithArray:tmp];
    }
    return _dataSource;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count) {
        self.clearBtn.hidden = NO;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"historycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"historysearch" object:nil userInfo:@{@"historykey":cell.textLabel.text}];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"历史搜索";
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

#pragma mark - private
- (void)clearHistory:(UIButton *)btn
{
    [self.dataSource removeAllObjects];
    [WriteFileManager saveFileWithArray:self.dataSource Name:@"historysearch"];
    [self.TableView reloadData];
    self.clearBtn.hidden = YES;
}

@end
