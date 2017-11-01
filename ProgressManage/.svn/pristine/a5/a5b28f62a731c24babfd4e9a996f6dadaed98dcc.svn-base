//
//  GuideViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/6/7.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController (){
    UIScrollView* _sv;
}
@property(nonatomic,strong)NSMutableArray* pictureArr;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //数据
    self.pictureArr = [[NSMutableArray alloc] initWithObjects:@"画板 1",@"画板 2",@"画板 3",@"画板 4", nil];
    [self createSC];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
#pragma mark - 创建scrollerView
- (void)createSC{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _sv.backgroundColor = [UIColor colorWithRed:219/255.0 green:225/255.0 blue:230/255.0 alpha:1];
    _sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], self.view.frame.size.height)];
    [self.view addSubview:_sv];
    for (int i = 0; i < self.pictureArr.count; i++) {
        UIImageView* _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [MyController getScreenWidth], 0, [MyController getScreenWidth], self.view.frame.size.height)];
        _imageView.image = [UIImage imageNamed:self.pictureArr[i]];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _imageView.clipsToBounds = YES;
        [_sv addSubview:_imageView];
        
        if (i < 3) {
            UIButton* btn = [MyController createButtonWithFrame:CGRectMake([MyController getScreenWidth] - 110 + ([MyController getScreenWidth] * i), [MyController getScreenHeight] - 50, 90, 40) ImageName:nil Target:self Action:@selector(btnClick) Title:nil];
            [_sv addSubview:btn];
        }else{
            UIButton* btn = [MyController createButtonWithFrame:CGRectMake(([MyController getScreenWidth] - 150)/2 + ([MyController getScreenWidth] * i), [MyController getScreenHeight] - 79, 150, 40) ImageName:nil Target:self Action:@selector(btnClick) Title:nil];
            [_sv addSubview:btn];
        }
        
    }
    _sv.contentSize = CGSizeMake([MyController getScreenWidth] * self.pictureArr.count, self.view.frame.size.height);
    _sv.contentOffset = CGPointMake(0, 0);
    _sv.pagingEnabled = YES;
    _sv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _sv.directionalLockEnabled = YES;
    _sv.bounces = YES;
    _sv.alwaysBounceHorizontal = YES;
    _sv.alwaysBounceVertical = NO;
    _sv.scrollEnabled = YES;
    _sv.showsHorizontalScrollIndicator = NO;
    _sv.showsVerticalScrollIndicator = NO;
    _sv.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _sv.decelerationRate = 0.5;
}

- (void)btnClick{
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"FirstOn"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate setLoginRoot];
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
