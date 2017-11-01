//
//  SeetingTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SeetingTableViewCell.h"

@interface SeetingTableViewCell()
@property (nonatomic, strong) UIView* bgView;

@property (nonatomic, strong) UIView* outView;
@property (nonatomic, strong) UIButton* outBtn;

@end
@implementation SeetingTableViewCell

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
        make.height.mas_offset(90);
    }];
    
    NSArray* titA = [[NSArray alloc] initWithObjects:@"修改资料",@"密码修改", nil];
    for (int i = 0; i < 2; i++) {
        UILabel* titLable = [MyController createLabelWithFrame:CGRectMake(12, i * 45, [MyController getScreenWidth] - 30 - 24, 45) Font:14 Text:titA[i]];
        titLable.textColor = [MyController colorWithHexString:TEXTCOLOR];
        [self.bgView addSubview:titLable];
        
        UIImageView* rIV = [MyController createImageViewWithFrame:CGRectMake([MyController getScreenWidth] - 30 - 12 - 20, 12 + (i * 45), 20, 20) ImageName:@"下拉"];
        [self.bgView addSubview:rIV];
        
        UIButton* temBtn = [MyController createButtonWithFrame:titLable.frame ImageName:nil Target:self Action:@selector(temBtnClick:) Title:nil];
        temBtn.tag = 100 + i;
        [self.bgView addSubview:temBtn];
    }
    
    UIView* linv = [MyController viewWithFrame:CGRectMake(12, 45, [MyController getScreenWidth] - 30 - 24, 0.5)];
    linv.backgroundColor = [MyController colorWithHexString:LINECOLOR];
    [self.bgView addSubview:linv];
    
    self.outView = [MyController viewWithFrame:self.contentView.frame];
    self.outView.backgroundColor = [UIColor whiteColor];
    //将图层的边框设置为圆脚
    self.outView.layer.cornerRadius = 6;
    self.outView.layer.masksToBounds = YES;
    [self.outView setContentMode:UIViewContentModeScaleAspectFill];
    self.outView.clipsToBounds = YES;
    [self.contentView addSubview:self.outView];
    
    [self.outView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView);
        make.right.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(10);
        make.height.mas_offset(45);
    }];
    
    self.outBtn = [MyController createButtonWithFrame:self.contentView.frame ImageName:nil Target:self Action:@selector(outBtnClick) Title:@"登 出"];
    [self.outBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.outBtn];
    
    [self.outBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.outView);
        make.right.mas_equalTo(self.outView);
        make.top.mas_equalTo(self.outView);
        make.height.mas_equalTo(self.outView);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel{
    
}

- (void)temBtnClick:(UIButton*)btn{
    [self.SeetingTableViewCellDelegate sendBackSelectIndex:btn.tag - 100];
}

- (void)outBtnClick{
    [self.SeetingTableViewCellDelegate sendBackOut];
}
@end
