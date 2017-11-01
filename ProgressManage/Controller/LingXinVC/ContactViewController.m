//
//  ContactViewController.m
//  ProgressManage
//
//  Created by Gem on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ContactViewController.h"
#import "PYSearch.h"
#import "ContactModel.h"
#import "ContactTableViewCell.h"
#import "PYSearch.h"
#import "EaseMessageViewController.h"
@interface ContactViewController ()<UISearchBarDelegate,PYSearchViewControllerDelegate>
{
    UIImageView *navBarHairlineImageView;
}

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic,strong) NSMutableArray *sectionArray;

@property (nonatomic, strong) NSMutableArray *sectionTitlesArray;

@end

@implementation ContactViewController
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = [ContactTableViewCell fixedHeight];
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    self.tableView.sectionHeaderHeight = 25;
    [self createContactRequest];
    self.view.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    [self createLeftNvc];
    [self createRightBtn];
    
}
- (void)createRightBtn{
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"搜索-触发"] forState:UIControlStateHighlighted];
    [searchBtn sizeToFit];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem  = searchItem;
}
- (void)createLeftNvc{
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setImage:[UIImage imageNamed:@"返回"]forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"返回"]forState:UIControlStateHighlighted];
    
    [rightButton addTarget:self action:@selector(backBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem= rightItem;
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 搜索
- (void)searchAction:(UIButton *)btn{
    
    // 1. 创建热门搜索
    NSArray *hotSeaches = @[];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"搜索", @"搜索") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        //        [searchViewController.navigationController pushViewController:[[SearchViewController alloc] init] animated:YES];
    }];
    
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格为默认
    
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:NO completion:nil];
    
    
}


#pragma mark - tableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectionArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Contacts";
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    ContactModel *model = self.sectionArray[section][row];
    cell.model = model;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionTitlesArray objectAtIndex:section];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.sectionTitlesArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isFromAndy) {
        ContactModel *model = self.sectionArray[indexPath.section][indexPath.row];
        [self.ContactViewControllerDelegate sendBackName:model.name AndId:model._id];
        NSLog(@"----%@",model._id);
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        ContactModel *model = self.sectionArray[indexPath.section][indexPath.row];
        EaseMessageViewController * chat = [[EaseMessageViewController alloc] initWithConversationChatter:@"18711111111" conversationType:EMConversationTypeChat];
        chat.title = model.name;
        chat.selfHeadImageStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"headImg"];
        chat.friendHeadImageStr = model.headUrl;
        chat.selfNickName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        chat.friendNickName = model.name;
        [self.navigationController pushViewController:chat animated:YES];
    }
}
//
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    // 1. 创建热门搜索
    NSArray *hotSeaches = @[];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"搜索", @"搜索") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        //        [searchViewController.navigationController pushViewController:[[SearchViewController alloc] init] animated:YES];
    }];
    
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格为默认
    
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:NO completion:nil];
    
    
}
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        
        // 显示建议搜索结果
        NSMutableArray *searchSuggestionsM = [NSMutableArray array];
        NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@ ",searchText];
        NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"phone CONTAINS[c] %@ ",searchText];
        
        for (ContactModel *model in self.dataArray) {
            if ([namePredicate evaluateWithObject:model] || [phonePredicate evaluateWithObject:model]) {
                NSLog(@"%@",model.name);
                [searchSuggestionsM addObject:model];
            }
        }
        searchViewController.searchSuggestions = searchSuggestionsM;
        
    }
}
#pragma mark - 通讯录请求
- (void)createContactRequest{
    [HUD loading];
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        
        NSString* requestAddress = Contact;
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
        [manager POST:requestAddress parameters:@{
                                                  @"token":[MyController returnStr:souDic[@"token"]]
                                                  }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"通讯录请求----%@",responseObject);
                  if ([[responseObject objectForKey:@"result"] intValue]) {
                      [HUD hide];
                      NSData *jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                      NSArray *sourceArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                      
                      for (NSDictionary* dic in sourceArr) {
                          ContactModel *model = [ContactModel new];
                          model.name = [MyController returnStr:dic[@"name"]];
                          model.headUrl = [MyController returnStr:dic[@"headImg"]];
                          model.department = [MyController returnStr:dic[@"position"]];
                          model.phone = [MyController returnStr:dic[@"phone"]];
                          model._id = [MyController returnStr:dic[@"id"]];
                          [self.dataArray addObject:model];
                      }
                      UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
                      //create a temp sectionArray
                      NSUInteger numberOfSections = [[collation sectionTitles] count];
                      NSMutableArray *newSectionArray =  [[NSMutableArray alloc]init];
                      for (NSUInteger index = 0; index<numberOfSections; index++) {
                          [newSectionArray addObject:[[NSMutableArray alloc]init]];
                      }
                      
                      // insert Persons info into newSectionArray
                      for (ContactModel *model in self.dataArray) {
                          NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(name)];
                          [newSectionArray[sectionIndex] addObject:model];
                      }
                      
                      //sort the person of each section
                      for (NSUInteger index=0; index<numberOfSections; index++) {
                          NSMutableArray *personsForSection = newSectionArray[index];
                          NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(name)];
                          newSectionArray[index] = sortedPersonsForSection;
                      }
                      NSMutableArray *temp = [NSMutableArray new];
                      self.sectionTitlesArray = [NSMutableArray new];
                      [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
                          if (arr.count == 0) {
                              [temp addObject:arr];
                          } else {
                              [self.sectionTitlesArray addObject:[collation sectionTitles][idx]];
                          }
                      }];
                      
                      [newSectionArray removeObjectsInArray:temp];
                      
                      NSMutableArray *operrationModels = [NSMutableArray new];
                      
                      NSMutableArray *dicts = [NSMutableArray array];
                      for (ContactModel *model in self.dataArray) {
                          [dicts addObject: @{@"name" : model.name,
                                              @"imgUrl" : model.headUrl,
                                              @"position" : model.department,
                                              @"phone" : model.phone,
                                              }];
                      }
                      for (NSDictionary *dict in dicts) {
                          ContactModel *model = [ContactModel new];
                          model.name = [MyController returnStr:dict[@"name"]];
                          model.headUrl = [MyController returnStr:dict[@"imgUrl"]];
                          model.department = [MyController returnStr:dict[@"position"]];
                          model.phone = [MyController returnStr:dict[@"phone"]];
                          model._id = [MyController returnStr:dict[@"id"]];
                          [operrationModels addObject:model];
                      }
                      //                  [newSectionArray insertObject:operrationModels atIndex:0];
                      //                  [self.sectionTitlesArray insertObject:@"" atIndex:0];
                      self.sectionArray = newSectionArray;
                      [self.tableView reloadData];
                  }else{
                      NSString *errStr = [responseObject objectForKey:@"error"];
                      NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                      [HUD error:[dic objectForKey:@"errorInfo"]];
                  }
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"失败");
                  NSLog(@"失败===%@", error);
                  [HUD error:@"请检查网络"];
              }];
    } failure:^(NSError *error) {
        
    }];
}

@end

