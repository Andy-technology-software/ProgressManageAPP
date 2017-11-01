//
//  Remind1TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "Remind1TableViewCell.h"

#import "Remind1Model.h"
@interface Remind1TableViewCell()
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, strong) UILabel* lLable;
@property (nonatomic, strong) UILabel* pLable;
@property (nonatomic, strong) UILabel* lLable1;
@property (nonatomic, strong) UILabel* yLable;
@property (nonatomic, strong) UILabel* dLable;

@property (nonatomic, strong) UIImageView* rImageView;
@property (nonatomic, strong) UIImageView* yImageView;
@property (nonatomic, strong) UIImageView* dImageView;

@property (nonatomic, strong) UIButton* yBtn;
@property (nonatomic, strong) UIButton* dBtn;
@end
@implementation Remind1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    
    self.bgView = [MyController viewWithFrame:self.contentView.frame];
    self.bgView.backgroundColor = [UIColor whiteColor];
    //将图层的边框设置为圆脚
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
    self.bgView.clipsToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(10);
        make.height.mas_offset(100);
    }];
    
    self.lLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"接收人"];
    self.lLable.textColor = [MyController colorWithHexString:@"81889d"];
    [self.bgView addSubview:self.lLable];
    
    [self.lLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
        make.width.mas_offset(60);
    }];
    
    self.rImageView = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@"向右"];
    [self.bgView addSubview:self.rImageView];
    
    [self.rImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(15);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.pLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:nil];
    self.pLable.textColor = [MyController colorWithHexString:@"81889d"];
    [self.bgView addSubview:self.pLable];
    
    [self.pLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rImageView.mas_left).mas_offset(-2);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
    }];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bgView.frame];
    [self.bgView addSubview: self.scrollView];
    
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lLable.mas_right).mas_offset(3);
        make.right.mas_equalTo(self.pLable.mas_left).mas_offset(-3);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
    }];
    
    self.lineView = [MyController viewWithFrame:self.bgView.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:LINECOLOR];
    [self.bgView addSubview:self.lineView];
    
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(50);
        make.height.mas_offset(0.5);
    }];

    self.lLable1 = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"发送方式"];
    self.lLable1.textColor = [MyController colorWithHexString:@"81889d"];
    [self.bgView addSubview:self.lLable1];
    
    [self.lLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lLable);
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.height.mas_equalTo(self.lLable);
        make.width.mas_offset(60);
    }];
    
    self.dLable = [MyController createLabelWithFrame:self.bgView.frame Font:12 Text:@"短信"];
    self.dLable.textColor = [MyController colorWithHexString:@"9da2b2"];
    [self.bgView addSubview:self.dLable];
    
    [self.dLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25);
        make.top.mas_equalTo(self.lLable1);
        make.height.mas_equalTo(self.lLable1);
    }];
    
    self.dImageView = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@"未选中点"];
    [self.bgView addSubview:self.dImageView];
    
    [self.dImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.dLable.mas_left).mas_offset(-5);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(15);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.dBtn = [MyController createButtonWithFrame:self.bgView.frame ImageName:nil Target:self Action:@selector(dBtnClick) Title:nil];
    [self.bgView addSubview:self.dBtn];
    
    [self.dBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.dLable);
        make.left.mas_equalTo(self.dImageView);
        make.top.mas_equalTo(self.dLable);
        make.height.mas_equalTo(self.dLable);
    }];
    
    
    self.yLable = [MyController createLabelWithFrame:self.bgView.frame Font:12 Text:@"应用内"];
    self.yLable.textColor = [MyController colorWithHexString:@"9da2b2"];
    [self.bgView addSubview:self.yLable];
    
    [self.yLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.dImageView.mas_left).mas_offset(-10);
        make.top.mas_equalTo(self.dLable);
        make.height.mas_equalTo(self.dLable);
    }];
    
    self.yImageView = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@"选中点"];
    [self.bgView addSubview:self.yImageView];
    
    [self.yImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.yLable.mas_left).mas_offset(-5);
        make.top.mas_equalTo(self.dImageView);
        make.height.mas_equalTo(self.dImageView);
        make.width.mas_equalTo(self.dImageView);
    }];
    
    self.yBtn = [MyController createButtonWithFrame:self.bgView.frame ImageName:nil Target:self Action:@selector(yBtnClick) Title:nil];
    [self.bgView addSubview:self.yBtn];
    
    [self.yBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.yLable);
        make.left.mas_equalTo(self.yImageView);
        make.top.mas_equalTo(self.yLable);
        make.height.mas_equalTo(self.yLable);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 10;
}

- (void)configCellWithModel:(Remind1Model *)model{
    NSLog(@"---%.2f",self.scrollView.frame.size.width);
    //给scrollview设置一个真正的大小，其实就是contentView的大小
    self.scrollView.contentSize = CGSizeMake(55 * model.nameArr.count, 50);
    //设置偏移量
    self.scrollView.contentOffset = CGPointMake(0, 0);
    //分页
    self.scrollView.pagingEnabled = YES;
    //设置额外空间 上 左 下 右`
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //锁定滑动方向
    self.scrollView.directionalLockEnabled = YES;
    //反弹效果
    self.scrollView.bounces = YES;
    //总是水平方向保持反弹效果
    self.scrollView.alwaysBounceHorizontal = YES;
    //总是垂直方向保持反弹效果
    self.scrollView.alwaysBounceVertical = NO;
    //开启滑动
    self.scrollView.scrollEnabled = YES;
    //显示水平状态条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //显示垂直状态条
    self.scrollView.showsVerticalScrollIndicator = NO;
    //状态条类型
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    //减速速率
    self.scrollView.decelerationRate = 0.5;
    
    float imageWidth = 40;
    for (int i = 0; i < model.nameArr.count; i++) {
        UIView* temView = [MyController viewWithFrame:CGRectMake(((imageWidth + 15) * i), 5 , imageWidth, imageWidth)];
        temView.backgroundColor = [MyController randomColor];//[MyController colorWithHexString:@"ff7854"];
        temView.layer.cornerRadius = imageWidth/2;
        temView.layer.masksToBounds = YES;
        [temView setContentMode:UIViewContentModeScaleAspectFill];
        temView.clipsToBounds = YES;
        [self.scrollView addSubview:temView];
        
        UILabel* temLable = [MyController createLabelWithFrame:temView.frame Font:18 Text:[model.nameArr[i] substringToIndex:1]];
        temLable.textColor = [UIColor whiteColor];
        temLable.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:temLable];

    }
    
    self.pLable.text = [NSString stringWithFormat:@"%ld人",model.nameArr.count];
    
    if (!model.type) {
        self.dImageView.image = [UIImage imageNamed:@"未选中点"];
        self.yImageView.image = [UIImage imageNamed:@"选中点"];
    }else{
        self.dImageView.image = [UIImage imageNamed:@"选中点"];
        self.yImageView.image = [UIImage imageNamed:@"未选中点"];
    }
}
- (void)yBtnClick{
    [self.Remind1TableViewCellDelegate sendIndex:0];
}

- (void)dBtnClick{
    [self.Remind1TableViewCellDelegate sendIndex:1];
}
@end

