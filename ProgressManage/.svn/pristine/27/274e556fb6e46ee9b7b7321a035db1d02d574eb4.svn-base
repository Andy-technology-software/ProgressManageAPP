//
//  IncreaseViewController.m
//  ProgressManage
//
//  Created by Gem on 2017/5/26.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "IncreaseViewController.h"
#import "ValuePickerView.h"
#import "UITextView+placeholder.h"
#import "FilterModel.h"
@interface IncreaseViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>{
    NSMutableArray *titleArr;
    NSMutableArray *palceArr;
    NSInteger indexs;
    
}
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic, strong) ValuePickerView *pickerView;
@property (nonatomic,strong) NSMutableArray *titleSource;
@property (nonatomic,strong) NSMutableArray *stageSource;
@property (nonatomic,strong) NSMutableArray *typeSource;

@end

@implementation IncreaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerView = [[ValuePickerView alloc]init];
    self.pickerView.pickerTitle = @"";
    self.view.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    self.stageSource = [NSMutableArray array];
    self.typeSource = [NSMutableArray array];
    NSString *btnName = @"保存";
    if (!self.dataSource.count) {
        btnName = @"提交";
        self.dataSource = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];
    }
    self.titleSource = [NSMutableArray arrayWithObjects:@"主题",@"客户",@"金额",@"类型",@"阶段",@"备注", nil];
    [self createTableView];
    UIButton *submitBtn = [MyController createButtonWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40) ImageName:nil Target:self Action:@selector(submitAction:) Title:btnName];
    submitBtn.backgroundColor = [MyController colorWithHexString:@"4c89f0"];
    [self.view addSubview:submitBtn];
    [self getSearchConRequest];
}
#pragma mark - 提交审核
- (void)submitAction:(UIButton *)btn{
    for (int i = 0; i < self.dataSource.count; i ++) {
        if ([self.dataSource[i] isEqualToString:@""]) {
            [HUD warning:[NSString stringWithFormat:@"请编辑%@",self.titleSource[i]]];
            return;
        }
    }
    [self getIncreaseRequest];
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
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 1) {
        NSMutableArray *temp = [NSMutableArray array];
        for (FilterModel *model in self.customerSource) {
            [temp addObject:model.name];
        }
        self.pickerView.dataSource= [NSArray arrayWithArray:temp];
    }else if (indexPath.row == 3){
        NSMutableArray *temp = [NSMutableArray array];
        for (FilterModel *model in self.typeSource) {
            [temp addObject:model.name];
        }
        self.pickerView.dataSource= [NSArray arrayWithArray:temp];
        
    }else if (indexPath.row == 4){
        NSMutableArray *temp = [NSMutableArray array];
        for (FilterModel *model in self.stageSource) {
            [temp addObject:model.name];
        }
        self.pickerView.dataSource= [NSArray arrayWithArray:temp];
    }
    self.pickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        [weakSelf.dataSource replaceObjectAtIndex:indexPath.row withObject:stateArr[0]];
        [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    [self.pickerView show];

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
    titlelabel.frame = CGRectMake(15, 0, 40, 44);
    titlelabel.numberOfLines = 2;
    [bgView addSubview:titlelabel];
    if (indexPath.row == 0 || indexPath.row == 2) {
        UITextField *tf = [MyController createTextFieldWithFrame:CGRectMake(CGRectGetMaxX(titlelabel.frame) + 15 ,  0, [MyController getScreenWidth] - 110, 44) placeholder:@"请填写" passWord:NO leftImageView:nil rightImageView:nil Font:13];
        tf.text = self.dataSource[indexPath.row];
        tf.tag = 100 + indexPath.row;
        tf.delegate = self;
        [bgView addSubview:tf];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 44-0.5, [MyController getScreenWidth] - 60, 0.5)];
        line.backgroundColor = [MyController colorWithHexString:@"e8e8e8"];
        [bgView addSubview:line];

    }else if (indexPath.row == 5){
        
        UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titlelabel.frame) + 10,6, [MyController getScreenWidth] - 110, 154)];
        tv.font = [UIFont systemFontOfSize:13];
        tv.text = self.dataSource[indexPath.row];
        if (!tv.text.length) {
            tv.placeholder = @"请填写";
        }
        tv.delegate = self;
        tv.tag = 100 + indexPath.row;
        [bgView addSubview:tv];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 160 - 0.5, [MyController getScreenWidth] - 60, 0.5)];
        line.backgroundColor = [MyController colorWithHexString:@"e8e8e8"];
        [bgView addSubview:line];
        bgView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 160);
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
    if (indexPath.row == 5) {
        return 200;
    }
    return 44;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSInteger index = textView.tag - 100;
    [self.dataSource replaceObjectAtIndex:index withObject:textView.text];
  
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger index = textField.tag - 100;
    [self.dataSource replaceObjectAtIndex:index withObject:textField.text];
}

#pragma mark - 新增筛选字段请求
- (void)getSearchConRequest{
    [HUD loading];
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        
        NSString* requestAddress = SearchCon;
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
        [manager POST:requestAddress parameters:@{
                                                  @"token":[MyController returnStr:souDic[@"token"]],
                                                  @"cname":[MyController getCName],
                                                  }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"新增筛选字段求----%@",responseObject);
                  NSLog(@"新增筛选字段data----%@",[responseObject objectForKey:@"data"]);
                  if ([[responseObject objectForKey:@"result"] intValue]) {
                      [HUD hide];
                      NSDictionary *dic = [MyController dictionaryWithJsonString:[responseObject objectForKey:@"data"]];
                      NSLog(@"%@",dic);
                      NSArray *state = dic[@"stage"];
                      NSArray *type = dic[@"type"];
                      for (NSDictionary *dic in state) {
                          FilterModel *model = [[FilterModel alloc] init];
                          model.filterId = dic[@"type"];
                          model.name = dic[@"name"];
                          [self.stageSource addObject:model];
                      }
                      for (NSDictionary *dic in type) {
                          FilterModel *model = [[FilterModel alloc] init];
                          model.filterId = dic[@"type"];
                          model.name = dic[@"name"];
                          [self.typeSource addObject:model];
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

#pragma mark - 新增请求
- (void)getIncreaseRequest{
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        NSString *customer = @"";
        NSString *type = @"";
        NSString *stage = @"";
        for (FilterModel *model in self.customerSource) {
            if ([model.name isEqualToString:self.dataSource[1]]) {
                customer = model.filterId;
            }
        }
        for (FilterModel *model in self.typeSource) {
            if ([model.name isEqualToString:self.dataSource[3]]) {
                type = model.filterId;
            }
        }
        for (FilterModel *model in self.stageSource) {
            if ([model.name isEqualToString:self.dataSource[4]]) {
                stage = model.filterId;
            }
        }
        [HUD loading];
        NSLog(@"%@",[MyController getCName]);
        NSString* requestAddress = Increase;
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
        [manager POST:requestAddress parameters:@{
                                                  @"token":[MyController returnStr:souDic[@"token"]],
                                                  @"cname":[MyController getCName],
                                                  @"theme":[MyController returnStr:self.dataSource[0]],
                                                  @"customer":customer,
                                                  @"money":[MyController returnStr:self.dataSource[2]],
                                                  @"type":type,
                                                  @"stage":stage,
                                                  @"remark":[MyController returnStr:self.dataSource[5]],
                                                  @"Id":[MyController returnStr:self.idStr],
                                                  @"userId":[MyController getUserid],
                                                  }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"新增请求----%@",responseObject);
                  NSLog(@"新增请求data----%@",[responseObject objectForKey:@"data"]);
                  if ([[responseObject objectForKey:@"result"] intValue]) {
                      [HUD success:[responseObject objectForKey:@"data"]];
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
