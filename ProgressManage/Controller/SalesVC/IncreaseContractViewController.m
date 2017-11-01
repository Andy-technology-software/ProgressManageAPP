

//
//  IncreaseContractViewController.m
//  ProgressManage
//
//  Created by Gem on 2017/10/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "IncreaseContractViewController.h"
#import "CDPDatePicker.h"

@interface IncreaseContractViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,CDPDatePickerDelegate>{
    NSMutableArray *titleArr;
    NSMutableArray *palceArr;
    NSInteger indexs;
    CDPDatePicker *_datePicker;
}
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSMutableArray *titleSource;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation IncreaseContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增合同";
    self.view.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    self.dataSource = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];
    self.titleSource = [NSMutableArray arrayWithObjects:@"订单主题",@"客户",@"订单编号",@"订单日期",@"订单金额",@"订单数量", nil];
    [self createTableView];
    UIButton *submitBtn = [MyController createButtonWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40) ImageName:nil Target:self Action:@selector(submitAction:) Title:@"保存"];
    submitBtn.backgroundColor = [MyController colorWithHexString:@"4c89f0"];
    [self.view addSubview:submitBtn];
    
    _datePicker=[[CDPDatePicker alloc] initWithSelectTitle:@"取消" viewOfDelegate:self.view delegate:self];
    _datePicker.isBeforeTime=YES;//(是否可选择以前时间)
    _datePicker.theTypeOfDatePicker=3;//(datePicker显示类别，只写了三种主流)
    
//    [self getSearchConRequest];
}
#pragma mark 时间选择
-(void)CDPDatePickerDidConfirm:(NSString *)confirmString{
    NSLog(@"%@",confirmString);
    [self.dataSource replaceObjectAtIndex:indexs withObject:[confirmString substringToIndex:16]];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexs inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark - 提交审核
- (void)submitAction:(UIButton *)btn{
    for (int i = 0; i < self.dataSource.count; i ++) {
        if ([self.dataSource[i] isEqualToString:@""]) {
            [HUD warning:[NSString stringWithFormat:@"请编辑%@",self.titleSource[i]]];
            return;
        }
    }
//    [self getIncreaseRequest];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7] + 15, self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 49) style:UITableViewStylePlain];
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
    return self.titleSource.count;
    
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 3){
        indexs = indexPath.row;
        [_datePicker pushDatePicker];
    }
    
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *bgView = [UIView new];
    bgView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 44);
    bgView.backgroundColor = [UIColor whiteColor];
    [cell addSubview:bgView];
    UILabel *titlelabel = [UILabel new];
    titlelabel.font = [UIFont systemFontOfSize:14];
    titlelabel.textColor = [MyController colorWithHexString:@"81889d"];
    titlelabel.text = [NSString stringWithFormat:@"%@",self.titleSource[indexPath.row]];
    titlelabel.frame = CGRectMake(15, 0, 60, 44);
    titlelabel.numberOfLines = 2;
    [bgView addSubview:titlelabel];
    if (indexPath.row != 3 ) {
        UITextField *tf = [MyController createTextFieldWithFrame:CGRectMake(CGRectGetMaxX(titlelabel.frame) + 15 ,  0, [MyController getScreenWidth] - 110, 44) placeholder:@"请填写" passWord:NO leftImageView:nil rightImageView:nil Font:13];
        tf.text = self.dataSource[indexPath.row];
        tf.tag = 100 + indexPath.row;
        tf.delegate = self;
        [bgView addSubview:tf];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 44-0.5, [MyController getScreenWidth] - 60, 0.5)];
        line.backgroundColor = [MyController colorWithHexString:@"e8e8e8"];
        [bgView addSubview:line];
        
    }else{
        UILabel *selectLabel = [MyController createLabelWithFrame:CGRectMake(CGRectGetMaxX(titlelabel.frame) + 15, 0, [MyController getScreenWidth] - 110, 44) Font:13 Text:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if ([self.dataSource[indexPath.row] length]) {
            selectLabel.text = self.dataSource[indexPath.row];
            selectLabel.textColor = [UIColor blackColor];
        }else{
            selectLabel.text = @"请选择";
            selectLabel.textColor = [MyController colorWithHexString:@"d3d3d8"];
        }
        [bgView addSubview:selectLabel];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15,44-0.5 , [MyController getScreenWidth] - 60, 0.5)];
        line.backgroundColor = [MyController colorWithHexString:@"e8e8e8"];
        [bgView addSubview:line];
    }
    return cell;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger index = textField.tag - 100;
    [self.dataSource replaceObjectAtIndex:index withObject:textField.text];
}


#pragma mark - 新增请求
//- (void)getIncreaseRequest{
//
//    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
//        NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
//
//        [HUD loading];
//        NSString* requestAddress = AddAct;
//        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
//        manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
//        [manager POST:requestAddress parameters:@{
//                                                  @"token":[MyController returnStr:souDic[@"token"]],
//                                                  @"cname":[MyController getCName],
//                                                  @"theme":[MyController returnStr:self.dataSource[0]],
//                                                  @"stageId":stage,
//                                                  @"money":[MyController returnStr:self.dataSource[2]],
//                                                  @"stime":[MyController returnStr:self.dataSource[3]],
//                                                  @"etime":[MyController returnStr:self.dataSource[4]],
//                                                  @"remark":[MyController returnStr:self.dataSource[5]],
//                                                  @"saleId":[MyController returnStr:self.idStr],
//                                                  @"userId":[MyController getUserid],
//                                                  }
//              success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                  NSLog(@"新增请求----%@",responseObject);
//                  NSLog(@"新增请求data----%@",[responseObject objectForKey:@"data"]);
//                  if ([[responseObject objectForKey:@"result"] intValue]) {
//                      [HUD success:[responseObject objectForKey:@"data"]];
//                  }else{
//                      NSString *errStr = [responseObject objectForKey:@"error"];
//                      NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
//                      [HUD error:[dic objectForKey:@"errorInfo"]];
//                  }
//              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                  NSLog(@"失败");
//                  NSLog(@"失败===%@", error);
//                  [HUD error:@"请检查网络"];
//              }];
//    } failure:^(NSError *error) {
//
//    }];
//}


@end
