//
//  SignIndexViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SignIndexViewController.h"

#import "FootprintViewController.h"

#import "SignInViewController.h"
@interface SignIndexViewController ()<UIScrollViewDelegate>{
    FootprintViewController* footprintViewController;
    SignInViewController* signInViewController;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;

@end

@implementation SignIndexViewController

- (void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"签到";
    
    [self makeSegmentView];
    
    [self createSliderView];
}


/**
 创建segmentedControl
 */
- (void)makeSegmentView{
    NSArray<UIImage *> *images = @[[UIImage imageNamed:@"签到"],
                                   [UIImage imageNamed:@"足记"]
                                   ];
    
    NSArray<UIImage *> *selectedImages = @[[UIImage imageNamed:@"签到-触发"],
                                           [UIImage imageNamed:@"足记-触发"]
                                           ];
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionImages:images sectionSelectedImages:selectedImages];
    self.segmentedControl.frame = CGRectMake(0, [MyController getScreenHeight] - 50, [MyController getScreenWidth], 50);
    self.segmentedControl.selectionIndicatorHeight = 0.0f;
    self.segmentedControl.backgroundColor = [MyController colorWithHexString:@"ffffff"];
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake([MyController getScreenWidth] * index, [MyController isIOS7], [MyController getScreenWidth], [MyController getScreenHeight] - [MyController isIOS7] - 50) animated:YES];
    }];
}

/**
 创建滑动界面
 */
- (void)createSliderView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7] , [MyController getScreenWidth],  [MyController getScreenHeight] - [MyController isIOS7] - 50)];
    self.scrollView.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake([MyController getScreenWidth] * 2,  [MyController getScreenHeight] - [MyController isIOS7] - 50);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, [MyController getScreenWidth],  [MyController getScreenHeight] - [MyController isIOS7] - 50) animated:NO];
    [self.view addSubview:self.scrollView];
    
    signInViewController = [[SignInViewController alloc] init];
    signInViewController.view.frame = CGRectMake([MyController getScreenWidth] * 0, 0, [MyController getScreenWidth], [MyController getScreenHeight] - [MyController isIOS7] - 50);
    [self addChildViewController:signInViewController];
    [self.scrollView addSubview:signInViewController.view];
    
    footprintViewController = [[FootprintViewController alloc] init];
    footprintViewController.view.frame = CGRectMake([MyController getScreenWidth] * 1, 0, [MyController getScreenWidth], [MyController getScreenHeight] - [MyController isIOS7] - 50);
    [self addChildViewController:footprintViewController];
    [self.scrollView addSubview:footprintViewController.view];
}

/**
 点击下面滑动的按钮

 @param segmentedControl HMSegmentedControl控制器
 */
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    if (0 == segmentedControl.selectedSegmentIndex) {
        self.title = @"签到";
    }else if (1 == segmentedControl.selectedSegmentIndex){
        self.title = @"团队足迹";
    }
}

/**
 scrollView代理方法

 @param scrollView UIScrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UITableView class]]) {
        CGFloat pageWidth = scrollView.frame.size.width;
        NSInteger page = scrollView.contentOffset.x / pageWidth;
        [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
        NSLog(@"-----%ld",page);
        
        if (0 == page) {
            self.title = @"签到";
        }else if (1 == page){
            self.title = @"团队足迹";
        }
    }
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
