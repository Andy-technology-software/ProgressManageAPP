//
//  代码地址: https://github.com/iphone5solo/PYSearch
//  代码地址: http://www.code4app.com/thread-11175-1-1.html
//  Created by CoderKo1o.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//

#import "PYSearchSuggestionViewController.h"
#import "PYSearchConst.h"
#import "SalesModel.h"
#import "SalesTableViewCell.h"
#import "SaleDetailViewController.h"
#import "EaseMessageViewController.h"
#import "ContactModel.h"
#import "ContactTableViewCell.h"
@interface PYSearchSuggestionViewController ()

/** 记录消失前的contentInset */
@property (nonatomic, assign) UIEdgeInsets originalContentInset;

@end

@implementation PYSearchSuggestionViewController

+ (instancetype)searchSuggestionViewControllerWithDidSelectCellBlock:(PYSearchSuggestionDidSelectCellBlock)didSelectCellBlock
{
    PYSearchSuggestionViewController *searchSuggestionVC = [[PYSearchSuggestionViewController alloc] init];
    searchSuggestionVC.didSelectCellBlock = didSelectCellBlock;
    searchSuggestionVC.automaticallyAdjustsScrollViewInsets = NO;
    return searchSuggestionVC;
}

/** 视图加载完毕 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 确保iPad中，tableView的正常显示
    if ([self.tableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) { // 为适配iPad
        self.tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboradFrameDidChange:) name:UIKeyboardDidShowNotification object:nil];
}

/** 控制器销毁 */
- (void)dealloc
{
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 视图即将消失 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 记录消失前的tableView.contentInset
    self.originalContentInset = self.tableView.contentInset;
}

/** 键盘frame改变 */
- (void)keyboradFrameDidChange:(NSNotification *)notification
{
    // 刷新
    [self setSearchSuggestions:_searchSuggestions];
}

#pragma mark - setter
- (void)setSearchSuggestions:(NSArray<NSString *> *)searchSuggestions
{
    _searchSuggestions = [searchSuggestions copy];
    
    // 刷新数据
    [self.tableView reloadData];
    
    // 还原contentInset
    if (!UIEdgeInsetsEqualToEdgeInsets(self.originalContentInset, UIEdgeInsetsZero) && !UIEdgeInsetsEqualToEdgeInsets(self.originalContentInset, UIEdgeInsetsMake(-30, 0, 30 - CGRectGetMaxY(self.navigationController.navigationBar.frame), 0))) { // originalContentInset非零 UIEdgeInsetsMake(-30, 0, 30, 0)是当键盘消失后自动调整的内边距
        self.tableView.contentInset =  self.originalContentInset;
    }
    // 滚动到头部
//    self.tableView.contentOffset = CGPointMake(0, -self.tableView.contentInset.top);
    self.tableView.contentOffset = CGPointMake(0, -self.tableView.contentInset.top);
//    self.tableView.frame = CGRectMake(10, [MyController isIOS7], SCREEN_WIDTH - 20, [MyController getScreenHeight] - [MyController isIOS7]);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInSearchSuggestionView:)]) {
        return [self.dataSource numberOfSectionsInSearchSuggestionView:tableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(searchSuggestionView:numberOfRowsInSection:)]) {
        return [self.dataSource searchSuggestionView:tableView numberOfRowsInSection:section];
    }
    return self.searchSuggestions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.searchSuggestions[indexPath.row];
    if ([model isKindOfClass:[SalesModel class]]) {
        SalesTableViewCell *cell = [[SalesTableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        SalesModel *model = self.searchSuggestions[indexPath.row];
        [cell setModel:model];
        return cell;
    }else{
        static NSString *ID = @"Contacts";
        ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[ContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        NSUInteger section = indexPath.section;
        NSUInteger row = indexPath.row;
        cell.model = model;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([self.dataSource respondsToSelector:@selector(searchSuggestionView:heightForRowAtIndexPath:)]) {
//        return [self.dataSource searchSuggestionView:tableView heightForRowAtIndexPath:indexPath];
//    }
    id model = self.searchSuggestions[indexPath.row];
    if ([model isKindOfClass:[SalesModel class]]) {
        return 130;
    }else{
        return 60;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (self.didSelectCellBlock) self.didSelectCellBlock([tableView cellForRowAtIndexPath:indexPath]);
//    SDContactModel *model = self.searchSuggestions[indexPath.row];
//    PersonDetailViewController *vc = [[PersonDetailViewController alloc] init];
//    vc.personId = model.Identity;
//    [self.navigationController pushViewController:vc animated:YES];
    id model = self.searchSuggestions[indexPath.row];
    if ([model isKindOfClass:[SalesModel class]]) {
        SaleDetailViewController *vc = [[SaleDetailViewController alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ContactModel *model = self.searchSuggestions[indexPath.row];
        EaseMessageViewController * chat = [[EaseMessageViewController alloc] initWithConversationChatter:@"18711111111" conversationType:EMConversationTypeChat];
        chat.title = model.name;
        chat.selfHeadImageStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"headImg"];
        chat.friendHeadImageStr = model.headUrl;
        chat.selfNickName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        chat.friendNickName = model.name;
        [self.navigationController pushViewController:chat animated:YES];
    }

}

@end
