//
//  SaleDetailViewController.m
//  ProgressManage
//
//  Created by Gem on 2017/5/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SaleDetailViewController.h"
#import "CCZSpreadButton.h"
#import "SalesMessageModel.h"
#import "SalesMessagesTableViewCell.h"
#import "FollowRecordViewController.h"
#import "IncreaseViewController.h"
#import "IncreasePayManageViewController.h"
#import "IncreasePrepaymentRecordViewController.h"
#import "OpportunityDetailsViewController.h"

#import "OpportunityDetailsModel.h"
#import "OpportunityDetailsTableViewCell.h"
#import "IncreaseViewController.h"
#import "HeadTitleModel.h"
#import "IncreaseOpportunnityViewController.h"
#import "IncreaseContractViewController.h"
#import "IncreaseInvoiceViewController.h"
#import "IncreaseReceivePaymentViewController.h"
@interface SaleDetailViewController ()<CCZSpreadButtonDelegate,UITableViewDataSource,UITableViewDelegate,salesMessageDelegate>{
    NSMutableArray *titleArr;
    NSMutableArray *palceArr;
    NSInteger indexs;
    NSArray *sectionTitle;
    UIView *maskView;
    NSInteger selectIndex;
    NSArray *menueArr;
    NSInteger deleteIndex;
}
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSMutableArray *titleSource;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *dataSource2;
@property (nonatomic,strong) NSMutableArray *dataSource3;

@property (nonatomic, strong) CCZSpreadButton *com;
@property (nonatomic, assign) CGRect         screenRect;
@property (nonatomic, strong) UIWindow       *window;
@property (nonatomic, strong) UIView         *dimBackground;

@property (nonatomic,strong) NSMutableArray *headTitleSource;

@end

@implementation SaleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"销售详情";
    sectionTitle = [NSArray arrayWithObjects:@"基本信息",@"销售信息", nil];
    menueArr = @[@"机会",@"跟进",@"合同",@"交付",@"预收款",@"回款",@"开票"];
    self.view.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    self.dataSource = [NSMutableArray arrayWithObjects:@"",self.model.customer,self.model.money,self.model.state,self.model.remark,@"", nil];
    self.titleSource = [NSMutableArray arrayWithObjects:@"客户名称",@"金额",@"阶段",@"备注", nil];
    self.dataSource2 = [NSMutableArray array];
    self.dataSource3 = [NSMutableArray arrayWithObjects:@[],@[],@[],@[],@[],@[],@[], nil];
    [self createTableView];
//    for (int i = 0; i < 5; i ++) {
//        SalesMessageModel *model = [[SalesMessageModel alloc] init];
//        model.dates = @"2017-10-24";
//        model.time = @"10:30";
//        model.titel = @"如果你操作的是字符串的话，那你可以使用NSString的length方法，得到其位数，如果缺少的话，在其后stringWithFormat：在其后添加几个0就可以了";
//        model.money = @"¥10000万";
//        model.remarks = @"你觉得呢版本";
//        [self.dataSource2 addObject:model];
//    }
    
    NSArray *tempTitle = [NSArray arrayWithObjects:@"",@"",@"机会识别",@"需求分析",@"方案谈判",@"价格谈判",@"合同签订", nil];
    self.headTitleSource = [NSMutableArray array];
    for (int i = 0; i < tempTitle.count; i ++) {
        HeadTitleModel *model = [[HeadTitleModel alloc] init];
        model.title = tempTitle[i];
        model.expanded = NO;
        [self.headTitleSource addObject:model];
    }
//    for (int i = 0; i < 3; i ++) {
//        OpportunityDetailsModel *model = [[OpportunityDetailsModel alloc] init];
//        model.title = @"如果你操作";
//        model.content = @"的是字符串的话，那你可以使用NSString的length方法，得到其位数，如果缺少的话，在其后stringWithFormat：在其后添加几个0就可以了";
//        [self.dataSource3 addObject:model];
//    }
//    [self detailRequest];
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
    if (selectIndex == 0) {
        if (section > 0) {
            
            if (![self isExpanded:section]) {
                //若本节是“折叠”的，其行数返回为0
                return 0;
            }
            return [self.dataSource3[section] count];
        }else{
            return self.titleSource.count + 1;
        }
    }
    else{
        if (section == 0) {
            
            return self.titleSource.count  + 1;
        }else{
            return  self.dataSource2.count;
        }
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (selectIndex == 0) {
        return  self.headTitleSource.count;
    }else{
        return 2;
    }
}
#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            UILabel *title = [MyController createLabelWithFrame:CGRectMake(15, 0, 100, 40) Font:13 Text:sectionTitle[0]];
            title.textColor = [MyController colorWithHexString:@"81889d"];
            [cell addSubview:title];
            return cell;
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIView *bgView = [UIView new];
            bgView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 44);
            bgView.backgroundColor = [UIColor whiteColor];
            [cell addSubview:bgView];
            UILabel *titlelabel = [UILabel new];
            titlelabel.font = [UIFont systemFontOfSize:14];
            titlelabel.textColor = [MyController colorWithHexString:@"81889d"];
            titlelabel.text = [NSString stringWithFormat:@"%@",self.titleSource[indexPath.row - 1]];
            titlelabel.frame = CGRectMake(10, 0, 80, 44);
            titlelabel.numberOfLines = 2;
            [bgView addSubview:titlelabel];
            UILabel *selectLabel = [MyController createLabelWithFrame:CGRectMake(CGRectGetMaxX(titlelabel.frame) + 15, 0, [MyController getScreenWidth] - 110, 44) Font:13 Text:nil];
            if ([self.dataSource[indexPath.row] length]) {
                selectLabel.text = self.dataSource[indexPath.row];
                selectLabel.textColor = [MyController colorWithHexString:@"d3d3d8"];
            }
            [bgView addSubview:selectLabel];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15,44-0.5 , [MyController getScreenWidth] - 60, 0.5)];
            line.backgroundColor = [MyController colorWithHexString:@"e8e8e8"];
            [bgView addSubview:line];
            return cell;
        }
    }else{
        if (selectIndex == 0) {
            OpportunityDetailsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
            if (!cell) {
                cell = [[OpportunityDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            OpportunityDetailsModel* model = self.dataSource3[indexPath.section][indexPath.row];
            [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
            [cell setModel:model];
            return cell;
        }else{

            SalesMessagesTableViewCell *cell = [[SalesMessagesTableViewCell alloc] init];
//                SalesMessagesTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
//                if (!cell) {
//                    cell = [[SalesMessagesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID1"];
//                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                SalesMessageModel* model = self.dataSource2[indexPath.row];
//                [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
                cell.index = indexPath.row;
                cell.delegate = self;
                [cell setModel:model];
                return cell;
            }

    }
}
#pragma mark - 删除记录 Cell代理
- (void)removeCurrentRecord:(NSInteger)index{
    deleteIndex = index;
    UIAlertView* al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否删除当前跟进记录" delegate:self cancelButtonTitle:@"取消"  otherButtonTitles:@"确定", nil];
    [al show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self otherdDetailDeleateRequestWith:deleteIndex];
    }
}
#pragma mark - 弹出菜单
- (void)MenueAction:(UIButton *)btn{
    //获取触摸点的集合，可以判断多点触摸事
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[btn convertRect: btn.bounds toView:window];
    NSLog(@"before:%f---%f--%f--%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    if (rect.origin.y < 150) {
        [UIView animateWithDuration:0.5 animations:^{
            [_tableView setContentOffset:CGPointMake(0, 150) animated:YES];
            [_tableView reloadData];
        } completion:^(BOOL finished) {
            
            UIWindow * window1=[[[UIApplication sharedApplication] delegate] window];
            CGRect rect1=[btn convertRect: btn.bounds toView:window1];
            NSLog(@"after:%f---%f--%f--%f",rect1.origin.x,rect1.origin.y,rect1.size.width,rect1.size.height);

            float tempY = rect.origin.y + 135 - [MyController isIOS7];
//            float tempY = rect1.origin.y;

            [self createPopViewWith:CGRectMake(20,tempY, 40, 40)];
        }];
    }else{
        
        [self createPopViewWith:rect];
    }
}

#pragma mark - 添加按钮
- (void)addSalesAction:(UIButton *)btn{
    NSString *type;
    if (selectIndex == 1) {
        type = @"1";
    }else if(selectIndex > 1 ){
        type = [NSString stringWithFormat:@"%ld",selectIndex - 1];
    }
    if (selectIndex == 0) {
        IncreaseOpportunnityViewController *vc = [[IncreaseOpportunnityViewController alloc] init];
        vc.title = @"新增机会明细";
        vc.account_id = self.model.account_id;
        vc.idStr = self.model.idStr;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (selectIndex == 1){
        IncreaseOpportunnityViewController *vc = [[IncreaseOpportunnityViewController alloc] init];
        vc.title = @"新增跟进记录";
        vc.account_id = self.model.account_id;
        vc.recordType = type;
        vc.idStr = self.model.idStr;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (selectIndex == 2){
        IncreaseContractViewController *vc= [[IncreaseContractViewController alloc] init];
        vc.account_id = self.model.account_id;
        vc.recordType = type;
        [self.navigationController pushViewController:[[IncreasePayManageViewController alloc] init] animated:YES];
    }else if (selectIndex == 3){
        IncreasePayManageViewController *vc= [[IncreasePayManageViewController alloc] init];
        vc.account_id = self.model.account_id;
        vc.recordType = type;
        [self.navigationController pushViewController:[[IncreasePayManageViewController alloc] init] animated:YES];
    }else if (selectIndex == 4){
        IncreasePrepaymentRecordViewController *vc = [[IncreasePrepaymentRecordViewController alloc] init];
        vc.account_id = self.model.account_id;
        vc.recordType = type;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (selectIndex == 5){
        IncreaseReceivePaymentViewController *vc = [[IncreaseReceivePaymentViewController alloc] init];
        vc.account_id = self.model.account_id;
        vc.recordType = type;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (selectIndex == 6){
        IncreaseInvoiceViewController *vc = [[IncreaseInvoiceViewController alloc] init];
        vc.account_id = self.model.account_id;
        vc.recordType = type;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (selectIndex == 0) {
        if (indexPath.section == 0) {
            return 44;
        }else{
            id model = self.dataSource3[indexPath.section][indexPath.row];
            float heigh = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OpportunityDetailsTableViewCell class] contentViewWidth:[self cellContentViewWith]];
            NSLog(@"heigh = %f",heigh);
            return heigh;
        }
    }else{
        if (indexPath.section == 0) {
            return 44;
        }else{
                id model = self.dataSource2[indexPath.row];
                float heigh = [_tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SalesMessagesTableViewCell class] contentViewWidth:[self cellContentViewWith]];
                NSLog(@"heigh = %f",heigh);
                return heigh;
        }
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

// 设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 80;
    }else{
        if (selectIndex == 0) {
            return 40;
        }else{
            
            return 0;
        }
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *hView;
    if (section == 0) {
        hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        return hView;
    }else if (section == 1){
        hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        hView.backgroundColor = [UIColor whiteColor];
        UILabel *title = [MyController createLabelWithFrame:CGRectMake(15, 0, 100, 40) Font:12 Text:sectionTitle[1]];
        title.textColor = [MyController colorWithHexString:@"81889d"];
        [hView addSubview:title];
        
        UIButton *menueBan = [MyController createButtonWithFrame:CGRectMake(20, 40, 40, 40) ImageName:nil Target:self Action:@selector(MenueAction:) Title:nil];
        NSString *tempTitle = [NSString stringWithFormat:@"%@\n...",menueArr[selectIndex]];
        [menueBan setTitle:tempTitle forState:UIControlStateNormal];
        menueBan.titleLabel.numberOfLines = 0;
        menueBan.titleLabel.textAlignment = NSTextAlignmentCenter;
        menueBan.tag = 100;
        [menueBan.titleLabel sizeToFit];
        menueBan.backgroundColor = [MyController colorWithHexString:@"4c89f0"];
        menueBan.titleLabel.font = [UIFont systemFontOfSize:11];
        menueBan.layer.cornerRadius = 20;
        menueBan.clipsToBounds = YES;
        [hView addSubview:menueBan];
        UIButton *addSalesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addSalesBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 50, 20, 20);
        [addSalesBtn addTarget:self action:@selector(addSalesAction:) forControlEvents:UIControlEventTouchUpInside];
        [addSalesBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
        [addSalesBtn setImage:[UIImage imageNamed:@"添加-触发"] forState:UIControlStateHighlighted];
        [addSalesBtn sizeToFit];
        [hView addSubview:addSalesBtn];
        return hView;
        
    }else{
        if (selectIndex != 0) {
            hView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
            return hView;
        }else{
            
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
    }
}

#pragma mark Table view data source


//对指定的节进行“展开/折叠”操作
-(void)collapseOrExpand:(NSInteger)section{
    HeadTitleModel* d=[self.headTitleSource objectAtIndex:section];
    d.expanded = !d.expanded;
    
}


//返回指定节的“expanded”值
-(Boolean)isExpanded:(NSInteger)section{
    HeadTitleModel* d=[self.headTitleSource objectAtIndex:section];
    return d.expanded;
}


//按钮被点击时触发
-(void)expandButtonClicked:(id)sender{
    UIButton* btn= (UIButton*)sender;
    NSInteger section= btn.tag; //取得tag知道点击对应哪个块
    if ([self isExpanded:section]) {
        [self collapseOrExpand:section];
        //刷新tableview
        [_tableView reloadData];
    }else{
        [self detailRequestWith:section];
    }
    
}

#pragma mark - 创建弹出视图
- (void)createPopViewWith:(CGRect )rect{
    
    self.dimBackground = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, [MyController getScreenWidth], [MyController getScreenHeight])];
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_dimBackground addGestureRecognizer:gr];
//    CGRect rectInTableView = [_tableView rectForHeaderInSection:section];//获取cell在tableView中的位置
//    CGRect rectInSuperview = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
    
    self.com  = [[CCZSpreadButton alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, 40, 40)];
    self.com.selected = selectIndex;
    self.com.itemsNum = 7;
    self.com.normalImage = [UIImage imageNamed:@"销售详情-关闭2"];
    self.com.selImage = [UIImage imageNamed:@"销售详情-关闭2"];
    self.com.images = @[@"机会",@"跟进",@"合同",@"交付",@"预收款",@"回款",@"开票"];
    self.com.autoAdjustToFitSubItemsPosition = NO;
    self.com.spreadDis = 95;
    [self.com spreadButtonDidClickItemAtIndex:^(NSUInteger index) {
        NSLog(@"%ld",index);
        selectIndex = index;
        if (selectIndex != 0 && selectIndex != 2) {
            [self otherdDetailRequestWith:selectIndex];
        }
        [_tableView reloadData];
        [self dismiss];
    }];
    [self.com spreadWithHandle:NULL];
    maskView = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x -120, rect.origin.y - 105, 280, 280)];
    maskView.layer.cornerRadius = 140;
    maskView.clipsToBounds = YES;
    maskView.hidden = !self.com.isSpreading;
    maskView.backgroundColor = [UIColor colorWithWhite:0.99 alpha:0.9];
    [_dimBackground addSubview:maskView];
    [_dimBackground addSubview:self.com];
    
    [self.com addObserver:self forKeyPath:@"isSpreading" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    if (self.window == nil) {
        [self show];
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (!self.com.isSpreading) {
        [self dismiss];
    }
}
#pragma mark - 显示遮盖视图
- (void)show {
    self.window = [[UIWindow alloc] initWithFrame:self.view.frame];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.backgroundColor = [UIColor clearColor];
    self.window.rootViewController = [UIViewController new];
    self.window.rootViewController.view.backgroundColor = [UIColor clearColor];
    [self.window.rootViewController.view addSubview:self.dimBackground];
    self.window.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        //        self.dimBackground.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    } completion:^(BOOL finished) {
        //
    }];
}
#pragma mark - 移除遮盖视图
- (void)dismiss {
    [_tableView reloadData];
    [self.com removeObserver:self forKeyPath:@"isSpreading" context:nil];
    [UIView animateWithDuration:0.2 animations:^{
        self.dimBackground.backgroundColor = [UIColor clearColor];
        [self.dimBackground.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    } completion:^(BOOL finished) {
        self.window = nil;
    }];
}
#pragma mark - 机会识别详情请求
- (void)detailRequestWith:(NSInteger)stage{
    [HUD loading];
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        
        NSString* requestAddress = Saledetail;
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
        [manager POST:requestAddress parameters:@{
                                                  @"token":[MyController returnStr:souDic[@"token"]],
                                                  @"cname":[MyController getCName],
                                                  @"saleId":[MyController returnStr:self.model.idStr],
                                                  @"stageId":[NSString stringWithFormat:@"%ld",stage - 2],

                                                  }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"机会识别详情请求----%@",responseObject);
                  NSLog(@"机会识别详情详情data----%@",[responseObject objectForKey:@"data"]);
                  if ([[responseObject objectForKey:@"result"] intValue]) {
                      [HUD hide];
                      NSArray *array = [MyController arraryWithJsonString:[responseObject objectForKey:@"data"]];
                      NSLog(@"%@",array);
                      if (array.count) {
                          NSMutableArray *sorce = [NSMutableArray array];
                          NSArray *temp = @[@"主题：",@"费用：",@"备注："];
                          for (NSDictionary *dic in array) {
                              NSArray *content = @[dic[@"theme"],dic[@"actualCost"],dic[@"description"]];
                              for (int i = 0; i < temp.count; i ++) {
                                  OpportunityDetailsModel *model = [[OpportunityDetailsModel alloc] init];
                                  model.title = temp[i];
                                  model.content = [MyController returnStr:content[i]];
                                  [sorce addObject:model];
                              }
                          }
                          NSLog(@"-----%@",self.dataSource3);
                          [self.dataSource3 replaceObjectAtIndex:stage withObject:sorce];
                          NSLog(@"+++++%@",self.dataSource3);
                      }
                      [self collapseOrExpand:stage];
                      //刷新tableview
                      [_tableView reloadData];
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

#pragma mark - 销售其他详情请求
- (void)otherdDetailRequestWith:(NSInteger)index{
    NSInteger type;
    if (index == 1) {
        type = index;
    }else{
        type = index - 1;
    }
    [HUD loading];
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        NSLog(@"souDic----%@",souDic);
        NSLog(@"token=%@\ncname=%@\nsaleId=%@\nrecordType=%@",[MyController returnStr:souDic[@"token"]],[MyController getCName],[MyController returnStr:self.model.idStr],[NSString stringWithFormat:@"%ld",type]);
        NSString* requestAddress = ActRecords;
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
        [manager POST:requestAddress parameters:@{
                                                  @"token":[MyController returnStr:souDic[@"token"]],
                                                  @"cname":[MyController getCName],
                                                  @"saleId":[MyController returnStr:self.model.idStr],
                                                  @"recordType":[NSString stringWithFormat:@"%ld",type],
                                                  }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"销售其他详情请求----%@",responseObject);
                  NSLog(@"销售其他详情详情data----%@",[responseObject objectForKey:@"data"]);
                  if ([[responseObject objectForKey:@"result"] intValue]) {
                      [HUD hide];
                       [self.dataSource2 removeAllObjects];
                      NSArray *array = [MyController arraryWithJsonString:[responseObject objectForKey:@"data"]];
                      NSLog(@"%@",array);
                      if (type == 1) {
                          for (NSDictionary *dic in array) {
                              SalesMessageModel *model = [[SalesMessageModel alloc] init];
                              NSString *dateStr = dic[@"planStartTime"];
                              if (dateStr.length > 10) {
                                  model.dates = [dateStr substringToIndex:dateStr.length - 5];
                                  model.time = [dateStr substringFromIndex:dateStr.length - 5];
                              }
                              model.idStr = [MyController returnStr:dic[@"id"]];
                              model.titel = [NSString stringWithFormat:@"%@(%@):%@",[MyController returnStr:dic[@"userName"]],[MyController returnStr:dic[@"stage"]],[MyController getCName]];
                              model.money = [NSString stringWithFormat:@"费用：¥%@",[MyController returnStr:dic[@"actualCost"]]];
                              model.remarks = [NSString stringWithFormat:@"备注：%@",[MyController returnStr:dic[@"description"]]];;
                              [self.dataSource2 addObject:model];
                          }
                      }else if (type == 2){
                          for (NSDictionary *dic in array) {
                              SalesMessageModel *model = [[SalesMessageModel alloc] init];
                              NSString *dateStr = dic[@"createDate"];
                              if (dateStr.length > 10) {
                                  model.dates = [dateStr substringToIndex:dateStr.length - 5];
                                  model.time = [dateStr substringFromIndex:dateStr.length - 5];
                              }
                              model.idStr = [MyController returnStr:dic[@"id"]];
                              model.titel = [NSString stringWithFormat:@"主题:%@",[MyController returnStr:dic[@"theme"]]];
                              model.money = [NSString stringWithFormat:@"交付状态：%@",[MyController returnStr:dic[@"recordstate"]]];
                              model.sub1 = [NSString stringWithFormat:@"交付百分比：%@",[MyController returnStr:dic[@"deliveryEvolve"]]];
                              model.sub2 = [NSString stringWithFormat:@"交付日期：%@",[MyController returnStr:dic[@"deliveryDate"]]];
                              model.remarks = [NSString stringWithFormat:@"备注：%@",[MyController returnStr:dic[@"remark"]]];
                              [self.dataSource2 addObject:model];
                          }
                      }else if (type == 3){
                          for (NSDictionary *dic in array) {
                              SalesMessageModel *model = [[SalesMessageModel alloc] init];
                              NSString *dateStr = dic[@"createDate"];
                              if (dateStr.length > 10) {
                                  model.dates = [dateStr substringToIndex:dateStr.length - 5];
                                  model.time = [dateStr substringFromIndex:dateStr.length - 5];
                              }
                              model.idStr = [MyController returnStr:dic[@"id"]];
                              model.titel = [NSString stringWithFormat:@"收款金额:¥%@",[MyController returnStr:dic[@"amount"]]];
                              model.money = [NSString stringWithFormat:@"收款方式：%@",[MyController returnStr:dic[@"payType"]]];
                              model.sub1 = [NSString stringWithFormat:@"收款状态：%@",[MyController returnStr:dic[@"recordstate"]]];
                              model.remarks = [NSString stringWithFormat:@"备注：%@",[MyController returnStr:dic[@"description"]]];
                              model.imageUrl =[MyController returnStr:dic[@"img"]];
                              [self.dataSource2 addObject:model];
                          }
                      }else if (type == 4){
                          for (NSDictionary *dic in array) {
                              SalesMessageModel *model = [[SalesMessageModel alloc] init];
                              NSString *dateStr = dic[@"createDate"];
                              if (dateStr.length > 10) {
                                  model.dates = [dateStr substringToIndex:dateStr.length - 5];
                                  model.time = [dateStr substringFromIndex:dateStr.length - 5];
                              }
                              model.idStr = [MyController returnStr:dic[@"id"]];
                              model.titel = [NSString stringWithFormat:@"回款金额:¥%@",[MyController returnStr:dic[@"money"]]];
                              model.money = [NSString stringWithFormat:@"回款方式：%@",[MyController returnStr:dic[@"payType"]]];
                              model.sub1 = [NSString stringWithFormat:@"回款状态：%@",[MyController returnStr:dic[@"recordstate"]]];
                              model.sub2 = [NSString stringWithFormat:@"回款日期：%@",[MyController returnStr:dic[@"recordTime"]]];
                              model.remarks = [NSString stringWithFormat:@"备注：%@",[MyController returnStr:dic[@"remark"]]];
                              model.imageUrl =[MyController returnStr:dic[@"img"]];
                              [self.dataSource2 addObject:model];
                          }
                      }else if (type == 5 ){
                          for (NSDictionary *dic in array) {
                              SalesMessageModel *model = [[SalesMessageModel alloc] init];
                              NSString *dateStr = dic[@"createDate"];
                              if (dateStr.length > 10) {
                                  model.dates = [dateStr substringToIndex:dateStr.length - 5];
                                  model.time = [dateStr substringFromIndex:dateStr.length - 5];
                              }
                              model.idStr = [MyController returnStr:dic[@"id"]];
                              model.titel = [NSString stringWithFormat:@"主题:%@",[MyController returnStr:dic[@"theme"]]];
                              model.money = [NSString stringWithFormat:@"金额：¥ %@",[MyController returnStr:dic[@"money"]]];
                              model.remarks = [NSString stringWithFormat:@"备注：%@",[MyController returnStr:dic[@"description"]]];
                              model.imageUrl =[MyController returnStr:dic[@"img"]];
                              [self.dataSource2 addObject:model];
                          }
                      }
                      //刷新tableview
                      [_tableView reloadData];

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
#pragma mark - 销售其他详情删除请求
- (void)otherdDetailDeleateRequestWith:(NSInteger)index{
    SalesMessageModel *model = self.dataSource2[index];
    NSString *type = @"";
    if (selectIndex == 1) {
        type = @"1";
    }else if(selectIndex > 1 ){
        type = [NSString stringWithFormat:@"%ld",selectIndex - 1];
    }
    [HUD loading];
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        NSLog(@"souDic----%@",souDic);
        NSLog(@"token=%@\ncname=%@\nsaleId=%@\nrecordType=%@",[MyController returnStr:souDic[@"token"]],[MyController getCName],[MyController returnStr:self.model.idStr],[NSString stringWithFormat:@"%ld",type]);
        NSString* requestAddress = ActRecords;
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
        [manager POST:requestAddress parameters:@{
                                                  @"token":[MyController returnStr:souDic[@"token"]],
                                                  @"cname":[MyController getCName],
                                                  @"id":[MyController returnStr:model.idStr],
                                                  @"recordType":[MyController returnStr:type],
                                                  }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"销售其他详情删除请求----%@",responseObject);
                  NSLog(@"销售其他详情删除请求data----%@",[responseObject objectForKey:@"data"]);
                  if ([[responseObject objectForKey:@"result"] intValue]) {
                      [HUD success:[responseObject objectForKey:@"data"]];
                      [self.dataSource2 removeObjectAtIndex:index];
                      //刷新tableview
                      [_tableView reloadData];
                      
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
