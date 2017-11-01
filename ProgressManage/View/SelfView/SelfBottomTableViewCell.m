//
//  SelfBottomTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SelfBottomTableViewCell.h"

@interface SelfBottomTableViewCell()
@property (nonatomic, strong) UIImageView* imgaeIV;
@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UIButton* clickBtn;

@end
@implementation SelfBottomTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.imgaeIV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgaeIV];

    [self.imgaeIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        make.left.mas_equalTo(20);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    
    self.nameLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLable];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    self.nameLable.numberOfLines = 0;
    self.nameLable.font = [UIFont systemFontOfSize:12];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.imgaeIV.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(self.imageView);
    }];
    
    self.clickBtn = [MyController createButtonWithFrame:self.frame ImageName:nil Target:self Action:@selector(clickBtnAction) Title:nil];
    [self.contentView addSubview:self.clickBtn];
    
    [self.clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView);
        make.top.mas_equalTo(self.imgaeIV);
        make.width.mas_equalTo(self.imageView);
        make.bottom.mas_equalTo(self.nameLable);
    }];
    
    self.hyb_lastViewInCell = self.clickBtn;
    self.hyb_bottomOffsetToCell = 0;

}

- (void)configCellWithModel{
    self.imageView.image = [UIImage imageNamed:@"addMatters@2x"];
    self.nameLable.text = @"签到";
}

- (void)clickBtnAction {
    [self.SelfBottomTableViewCellDelegate sendBackClickIndex:0];
}
@end
