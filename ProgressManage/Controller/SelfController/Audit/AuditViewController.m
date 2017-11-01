

//
//  AuditViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/23.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "AuditViewController.h"

#import "AuditListViewController.h"
@interface AuditViewController ()
@property (nonatomic, strong) UISegmentedControl *segment;

@end

@implementation AuditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureNav];
    
    [self configureUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)configureUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    AuditListViewController *daivc = [[AuditListViewController alloc] init];
    [self addChildViewController:daivc];
    [self.view addSubview:daivc.view];
    
//    AuditListViewController *yivc = [[AuditListViewController alloc] init];
//    [self addChildViewController:yivc];
//    [self.view addSubview:yivc.view];
//    yivc.view.hidden = YES;
}
- (void)configureNav {
    self.segment = ({
        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"待审批",@"已审批"]];
        segment.frame = CGRectMake(0, 0, 130, 28);
        segment.selectedSegmentIndex = 0;
        segment.tintColor = [MyController colorWithHexString:@"4c89f0"];
        segment.layer.masksToBounds = YES;
        segment.layer.cornerRadius = 13;
        segment.layer.borderWidth = 1;
        segment.layer.borderColor = [MyController colorWithHexString:@"d2d4dc"].CGColor;
        NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
        attrDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        [segment setTitleTextAttributes:attrDict forState:UIControlStateNormal];
        [segment setContentOffset:CGSizeMake(1, 0) forSegmentAtIndex:0];
        [segment setContentOffset:CGSizeMake(-1, 0) forSegmentAtIndex:1];
        [segment addTarget:self action:@selector(segmentAction:)
          forControlEvents:UIControlEventValueChanged];
        self.navigationItem.titleView = segment;
        segment;
    });
    
}
- (void)segmentAction:(UISegmentedControl *)sender{
//    if (sender.selectedSegmentIndex == 0) {
//        self.childViewControllers[0].view.hidden = NO;
//        self.childViewControllers[1].view.hidden = YES;
//    }else {
//        self.childViewControllers[0].view.hidden = YES;
//        self.childViewControllers[1].view.hidden = NO;
//    }
    //添加 字典，将label的值通过key值设置传递
    NSDictionary* dict =[[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",sender.selectedSegmentIndex + 1],@"state", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"selectAuditState" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
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
