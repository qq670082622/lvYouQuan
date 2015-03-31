//
//  Me.m
//  ShouKeBao
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "Me.h"
#import "MeHeader.h"
#import "MeButtonView.h"
#import "PersonSettingViewController.h"
#import "OrgSettingViewController.h"

@interface Me () <MeHeaderDelegate,MeButtonViewDelegate>

@property (nonatomic,strong) MeHeader *meheader;

@property (nonatomic,strong) MeButtonView *buttonView;

@property (nonatomic,strong) NSArray *desArr;

@property (nonatomic,assign) BOOL isPerson;//是否个人

@end

@implementation Me

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(136, 0, 0, 0);
    self.tableView.tableHeaderView = self.buttonView;
    self.tableView.rowHeight = 50;
    
    self.desArr = @[@[@"我的旅行社"],@[@"账号安全设置"],@[@"勿扰模式",@"意见反馈",@"关于收客宝",@"评价收客宝"]];
    
    self.isPerson = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar addSubview:self.meheader];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self setNav];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.meheader removeFromSuperview];
    self.navigationController.navigationBar.frame = CGRectMake(0, 20, self.view.frame.size.width, 44);
}

#pragma mark - private
- (void)setNav
{
    self.title = nil;
    
    //修改NavigaionBar的高度
    self.navigationController.navigationBar.frame = CGRectMake(0, 20, self.view.frame.size.width, 180);
}

#pragma mark - getter
- (MeHeader *)meheader
{
    if (!_meheader) {
        _meheader = [[MeHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
        _meheader.delegate = self;
    }
    return _meheader;
}

- (MeButtonView *)buttonView
{
    if (!_buttonView) {
        _buttonView = [[MeButtonView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,60)];
        _buttonView.delegate = self;
    }
    return _buttonView;
}

#pragma mark - MeHeaderDelegate
- (void)didClickSetting
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    if (self.isPerson) {
        PersonSettingViewController *ps = [sb instantiateViewControllerWithIdentifier:@"PersonSetting"];
        [self.navigationController pushViewController:ps animated:YES];
    }else{
        OrgSettingViewController *org = [sb instantiateViewControllerWithIdentifier:@"OrgSetting"];
        [self.navigationController pushViewController:org animated:YES];
    }
}

#pragma mark - MeButtonViewDelegate


#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.desArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.desArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"mecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.desArr[indexPath.section][indexPath.row];
    
    // 前两个单独的行
    if (indexPath.section != 2) {
        if (indexPath.section == 0) {
            cell.imageView.image = [UIImage imageNamed:@"wodelvxingshe"];
        }else{
            cell.imageView.image = [UIImage imageNamed:@"zhanghu-anquan"];
        }
    }
    
    // 第三组的第一行
    if (indexPath.section == 2 && indexPath.row == 0) {
        cell.detailTextLabel.text = @"晚上11点至早上8点将不会有消息推送";
        
        // 添加一个开关
        UISwitch *btn = [[UISwitch alloc] init];
        cell.accessoryView = btn;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

@end
