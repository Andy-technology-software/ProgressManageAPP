//
//  BaseViewController.m
//  AndyCoder
//
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
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
    // Do any additional setup after loading the view.
    
//    self.navigationController.navigationBar.barTintColor = [MyController colorWithHexString:@"eeeeee"];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
//                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
    
    self.view.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    [self createLeftNvc];
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
