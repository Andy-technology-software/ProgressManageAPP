//
//  ChartPart0TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ChartPart0TableViewCell.h"

#import "ChartPart0Model.h"
@interface ChartPart0TableViewCell()
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* lineView;

@end
@implementation ChartPart0TableViewCell

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
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(15);
        make.height.mas_offset(120);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 30;
}

- (void)configCellWithModel:(ChartPart0Model *)model{
    NSArray* titA = [[NSArray alloc] initWithObjects:@"开始时间：",@"结束时间：", nil];
    for (int i = 0; i < 2; i++) {
        UIImageView* tImageView = [MyController createImageViewWithFrame:CGRectMake(15, 10 * (i + 1) + 30 * i, 20, 20) ImageName:@"签到-日期"];
        [self.bgView addSubview:tImageView];
        
        UILabel* tLbale = [MyController createLabelWithFrame:CGRectMake(CGRectGetMaxX(tImageView.frame) + 3, 40 * i, 60, 40) Font:14 Text:titA[i]];
        tLbale.textColor = [MyController colorWithHexString:@"a7abba"];
        [self.bgView addSubview:tLbale];
        
        UILabel* tLbale1 = [MyController createLabelWithFrame:CGRectMake(CGRectGetMaxX(tLbale.frame) + 6, 40 * i, 160, 40) Font:14 Text:model.timeArr[i]];
        [self.bgView addSubview:tLbale1];
        
        UIView* lineView = [MyController viewWithFrame:CGRectMake(15, 40 * (i + 1), [MyController getScreenWidth] - 60, 0.5)];
        lineView.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
        [self.bgView addSubview:lineView];
        
        UIButton* temBtn = [MyController createButtonWithFrame:CGRectMake(0, 40 * i, [MyController getScreenWidth] - 60, 40) ImageName:nil Target:self Action:@selector(temBtnClick:) Title:nil];
        temBtn.tag = 100 + i;
        [self.bgView addSubview:temBtn];
    }
    
    NSArray* btnArr = [[NSArray alloc] initWithObjects:@"折线图-选中",@"柱状图",@"导出", nil];
    for (int i = 0; i < 3; i++) {
        UIButton* chartBtn = [MyController createButtonWithFrame:CGRectMake(15 * (i + 1) + 30 * i, 80 + 5, 30, 30) ImageName:btnArr[i] Target:self Action:@selector(chartBtnClick:) Title:nil];
        chartBtn.tag = 200 + i;
        [self.bgView addSubview:chartBtn];
    }
    
}
- (void)temBtnClick:(UIButton*)btn{
    if (100 == btn.tag) {
        [self.ChartPart0TableViewCellDelegate sendBackStartTime];
    }else if (101 == btn.tag){
        [self.ChartPart0TableViewCellDelegate sendBackEndTime];
    }
}

- (void)chartBtnClick:(UIButton*)btn{
    [self.ChartPart0TableViewCellDelegate sendBackIndex:btn.tag - 200];
}

@end
