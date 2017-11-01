//
//  ChartPartIndexTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ChartPartIndexTableViewCell.h"

@interface ChartPartIndexTableViewCell()
@property (nonatomic, strong) UIView* bgView;

@end
@implementation ChartPartIndexTableViewCell

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
        make.height.mas_offset(45 * 5);
    }];
    
    NSArray* titA = [[NSArray alloc] initWithObjects:@"签单金额月份统计",@"签单数量月份统计",@"签单金额人员分布",@"签单数量人员分布",@"回款月度统计", nil];
    for (int i = 0; i < 5; i++) {
        UILabel* titLable = [MyController createLabelWithFrame:CGRectMake(12, i * 45, [MyController getScreenWidth] - 30 - 24, 45) Font:14 Text:titA[i]];
        titLable.textColor = [MyController colorWithHexString:TEXTCOLOR];
        [self.bgView addSubview:titLable];
        
        UIImageView* rIV = [MyController createImageViewWithFrame:CGRectMake([MyController getScreenWidth] - 30 - 12 - 20, 12 + (i * 45), 20, 20) ImageName:@"向右"];
        [self.bgView addSubview:rIV];
        
        UIButton* temBtn = [MyController createButtonWithFrame:titLable.frame ImageName:nil Target:self Action:@selector(temBtnClick:) Title:nil];
        temBtn.tag = 100 + i;
        [self.bgView addSubview:temBtn];
        
        if (i < 4) {
            UIView* linv = [MyController viewWithFrame:CGRectMake(12, 45 * (i + 1), [MyController getScreenWidth] - 30 - 24, 0.5)];
            linv.backgroundColor = [MyController colorWithHexString:LINECOLOR];
            [self.bgView addSubview:linv];
        }
    }
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel{
    
}

- (void)temBtnClick:(UIButton*)btn{
    NSArray* titA = [[NSArray alloc] initWithObjects:@"签单金额月份统计",@"签单数量月份统计",@"签单金额人员分布",@"签单数量人员分布",@"回款月度统计", nil];
    [self.ChartPartIndexTableViewCellDelegate sendBackSelectIndex:btn.tag - 100 AndTitle:titA[btn.tag - 100]];
    
}


@end
