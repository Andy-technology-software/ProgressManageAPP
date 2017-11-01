//
//  FollowRecordViewController.m
//  ProgressManage
//
//  Created by Gem on 2017/5/31.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "FollowRecordViewController.h"
#import "SalesMessageModel.h"
#import "SalesMessagesTableViewCell.h"
#import "IncreaseViewController.h"
@interface FollowRecordViewController ()<UITableViewDataSource,UITableViewDelegate,salesMessageDelegate>{
    NSInteger indexs;
    
}
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSMutableArray *titleSource;
@property (nonatomic,strong) NSMutableArray *dataSource;



@end

@implementation FollowRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"跟进记录";
    self.dataSource = [NSMutableArray array];
    [self createTableView];
    for (int i = 0; i < 5; i ++) {
        SalesMessageModel *model = [[SalesMessageModel alloc] init];
        model.time = @"10:30";
        model.titel = @"如果你操作的是字符串的话，那你可以使用NSString的length方法，得到其位数，如果缺少的话，在其后stringWithFormat：在其后添加几个0就可以了";
        model.money = @"¥10000万";
        model.remarks = @"你觉得呢版本";
        [self.dataSource addObject:model];
    }
    [self createRightBtn];
}
- (void)createRightBtn{
    UIButton *addSalesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addSalesBtn addTarget:self action:@selector(addSalesAction:) forControlEvents:UIControlEventTouchUpInside];
    [addSalesBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [addSalesBtn setImage:[UIImage imageNamed:@"添加-触发"] forState:UIControlStateHighlighted];
    [addSalesBtn sizeToFit];
    UIBarButtonItem *addSalesItem = [[UIBarButtonItem alloc] initWithCustomView:addSalesBtn];
    self.navigationItem.rightBarButtonItem = addSalesItem;
}
#pragma mark - 添加
- (void)addSalesAction:(UIButton *)btn{
    [self.navigationController pushViewController:[[IncreaseViewController alloc] init] animated:YES];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
}
#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count + 1;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor clearColor];
   
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(40 - 1.5, 0, 3, 55)];
        line.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
        [cell addSubview:line];
        
        UILabel *datelabel = [MyController createLabelWithFrame:CGRectMake(15, 15, 95, 25) Font:14 Text:@"2017-05-31"];
        datelabel.textColor = [MyController colorWithHexString:@"81889d"];
        datelabel.backgroundColor = [UIColor whiteColor];
        datelabel.layer.cornerRadius = 25 / 2;
        datelabel.clipsToBounds = YES;
        datelabel.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:datelabel];
        
        return cell;
    }else{
        SalesMessagesTableViewCell *cell = [[SalesMessagesTableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SalesMessageModel* model = self.dataSource[indexPath.row - 1];
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        cell.index = indexPath.row;
        cell.delegate = self;
        [cell setModel:model];
        return cell;
    }
}
- (void)removeCurrentRecord:(NSInteger)index{
    UIAlertView* al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否删除当前跟进记录" delegate:self cancelButtonTitle:@"取消"  otherButtonTitles:@"确定", nil];
    [al show];
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   if (indexPath.row == 0){
        return 55;
    }else{
        id model = self.dataSource[indexPath.row - 1];
        float heigh = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SalesMessagesTableViewCell class] contentViewWidth:[self cellContentViewWith]];
        NSLog(@"heigh = %f",heigh);
        return heigh;
    }
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

@end
