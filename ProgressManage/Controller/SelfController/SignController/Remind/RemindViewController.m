//
//  RemindViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "RemindViewController.h"

#import "RemindModel.h"

#import "RemindTableViewCell.h"

#import "Remind1Model.h"

#import "Remind1TableViewCell.h"
@interface RemindViewController ()<UITableViewDataSource,UITableViewDelegate,AdvancedExpandableTableViewDelegate,Remind1TableViewCellDelegate>{
    UITableView* _tableView;
    CGFloat textCellHeight;
}
@property(nonatomic,strong)NSMutableArray* dataSourceArr;
@property(nonatomic,strong)NSMutableArray* dataSourceArr1;

@end

@implementation RemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSourceArr = [[NSMutableArray alloc] init];
    self.dataSourceArr1 = [[NSMutableArray alloc] init];
    
    Remind1Model* mo = [[Remind1Model alloc] init];
    mo.nameArr = [[NSMutableArray alloc] initWithObjects:@"皮卡丘",@"皮卡丘",@"皮卡丘",@"皮卡丘",@"皮卡丘",@"皮卡丘",@"皮卡丘", nil];
    mo.type = 0;
    [self.dataSourceArr1 addObject:mo];
    
    [self createTableView];
    
    [self makeSendbtn];
}

- (void)makeSendbtn{
    UIButton* sendBtn = [MyController createButtonWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 50) ImageName:nil Target:self Action:@selector(sendBtn) Title:@"发 送"];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:[MyController colorWithHexString:@"4c89f0"]];
    [self.view addSubview:sendBtn];
}
- (void)sendBtn{
    NSLog(@"提交");
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, [MyController getScreenHeight] - [MyController isIOS7] - 50) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        RemindTableViewCell *textCell = [tableView advancedExpandableTextCellWithIdRemind:@"RemindTableViewCell"];
        textCell.placeholder = @"到哪了签个到吧~";
        textCell.selectionStyle = UITableViewCellSelectionStyleNone;
        textCell.maxCharacter = 1000;
        
        return textCell;
    }
    
//    NSString *cellIdentifier = @"Remind1TableViewCell";
//    Remind1TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!celll) {
//        celll = [[Remind1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    Remind1TableViewCell *celll = [[Remind1TableViewCell alloc] init];
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    Remind1Model* model = self.dataSourceArr1[indexPath.row];
    celll.Remind1TableViewCellDelegate = self;
    [celll configCellWithModel:model];
    return celll;
}

#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return MAX(150, textCellHeight);
    }
    
    Remind1Model *model = nil;
    if (indexPath.row < self.dataSourceArr1.count) {
        model = [self.dataSourceArr1 objectAtIndex:indexPath.row];
    }
    
    return [Remind1TableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        Remind1TableViewCell *cell = (Remind1TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}

- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath{
    textCellHeight = height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (2 == indexPath.section) {
        NSLog(@"================");
    }
}

- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"debug : updatedText\n%@", text);
}

- (void)sendIndex:(NSInteger)selectIndex{
    Remind1Model* m = [self.dataSourceArr1 lastObject];
    m.type = selectIndex;
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
