//
//  OpportunityDetailsViewController.m
//  ProgressManage
//
//  Created by Gem on 2017/6/1.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "OpportunityDetailsViewController.h"
#import "OpportunityDetailsModel.h"
#import "OpportunityDetailsTableViewCell.h"
#import "IncreaseViewController.h"
#import "HeadTitleModel.h"
@interface OpportunityDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger indexs;
    
}
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *headTitleSource;

@end

@implementation OpportunityDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"机会明细";
    self.dataSource = [NSMutableArray array];
    [self createTableView];
    NSArray *tempTitle = [NSArray arrayWithObjects:@"机会识别",@"需求分析",@"方案谈判",@"价格谈判",@"合同签订", nil];
    self.headTitleSource = [NSMutableArray array];
    for (int i = 0; i < tempTitle.count; i ++) {
        HeadTitleModel *model = [[HeadTitleModel alloc] init];
        model.title = tempTitle[i];
        model.expanded = NO;
        [self.headTitleSource addObject:model];
    }
    for (int i = 0; i < 3; i ++) {
        OpportunityDetailsModel *model = [[OpportunityDetailsModel alloc] init];
        model.title = @"如果你操作";
        model.content = @"的是字符串的话，那你可以使用NSString的length方法，得到其位数，如果缺少的话，在其后stringWithFormat：在其后添加几个0就可以了";
        [self.dataSource addObject:model];
    }
    [self createRightBtn];
    [self createTableView];
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], SCREEN_WIDTH, SCREEN_HEIGHT - [MyController isIOS7]) style:UITableViewStylePlain];
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
    if (![self isExpanded:section]) {
        //若本节是“折叠”的，其行数返回为0
        return 0;
    }
    return self.dataSource.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.headTitleSource.count;
}
#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    OpportunityDetailsTableViewCell *cell = [[OpportunityDetailsTableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OpportunityDetailsModel* model = self.dataSource[indexPath.row];
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    [cell setModel:model];
    return cell;
    
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    id model = self.dataSource[indexPath.row];
    float heigh = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OpportunityDetailsTableViewCell class] contentViewWidth:[self cellContentViewWith]];
    NSLog(@"heigh = %f",heigh);
    return heigh;
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
// 设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    
    
    UIView *hView;
    hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    hView.backgroundColor = [UIColor clearColor];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    [hView addSubview:bgView];
    UIImageView *flagImag = [MyController createImageViewWithFrame:CGRectMake([MyController getScreenWidth] - 45, 12, 16, 16) ImageName:nil];
    [bgView addSubview:flagImag];
    UIButton* eButton = [[UIButton alloc] init];
    
    //按钮填充整个视图
    eButton.frame = CGRectMake(0, 0.5, [MyController getScreenWidth], 40 - 0.5);
    [eButton addTarget:self action:@selector(expandButtonClicked:)
      forControlEvents:UIControlEventTouchUpInside];
    eButton.tag = section;//把节号保存到按钮tag，以便传递到expandButtonClicked方法
    [eButton setTitleColor:[MyController colorWithHexString:@"a6abb9"] forState:UIControlStateNormal];
    //根据是否展开，切换按钮显示图片
    if ([self isExpanded:section]){
        flagImag.image = [UIImage imageNamed:@"二级下拉"];
        
    }else{
        flagImag.image = [UIImage imageNamed:@"二级下拉"];
        flagImag.transform=CGAffineTransformMakeRotation(M_PI/2 * 3);
        
    }
    //由于按钮的标题，
    //4个参数是上边界，左边界，下边界，右边界。
    eButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [eButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    HeadTitleModel *model = self.headTitleSource[section];
    //设置按钮显示颜色
    eButton.backgroundColor = [UIColor clearColor];
    [eButton setTitle:model.title forState:UIControlStateNormal];
    eButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [bgView addSubview: eButton];
    
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
    line.frame = CGRectMake(10, 39.5, [MyController getScreenWidth] - 40, 0.5);
    [bgView addSubview:line];
    
    return hView;
    
}

#pragma mark Table view data source


//对指定的节进行“展开/折叠”操作
-(void)collapseOrExpand:(int)section{
    HeadTitleModel* d=[self.headTitleSource objectAtIndex:section];
    d.expanded = !d.expanded;
    
}


//返回指定节的“expanded”值
-(Boolean)isExpanded:(int)section{
    HeadTitleModel* d=[self.headTitleSource objectAtIndex:section];
    return d.expanded;
}


//按钮被点击时触发
-(void)expandButtonClicked:(id)sender{
    
    UIButton* btn= (UIButton*)sender;
    NSInteger section= btn.tag; //取得tag知道点击对应哪个块
    [self collapseOrExpand:section];
    //刷新tableview
    [_tableView reloadData];
    
}



@end
