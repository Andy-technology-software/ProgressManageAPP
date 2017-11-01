//
//  AdjustAddTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/11.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "AdjustAddTableViewCell.h"

#import "AdjustAddModel.h"
@interface AdjustAddTableViewCell()
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* rnameLable;

@property (nonatomic, strong) UIImageView* duiImageview;

@end
@implementation AdjustAddTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    
    self.bgView = [MyController viewWithFrame:self.contentView.frame];
    self.bgView.backgroundColor = [UIColor whiteColor];
    //将图层的边框设置为圆脚
//    self.bgView.layer.cornerRadius = 6;
//    self.bgView.layer.masksToBounds = YES;
//    [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
//    self.bgView.clipsToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.height.mas_offset(55);
    }];
    
    self.nameLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.nameLable];
    self.nameLable.numberOfLines = 1;
    self.nameLable.font = [UIFont systemFontOfSize:14];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-35);
        make.top.mas_equalTo(8);
    }];
    
    self.rnameLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.rnameLable];
    self.rnameLable.numberOfLines = 1;
    self.rnameLable.textColor = [MyController colorWithHexString:@"81889d"];
    self.rnameLable.font = [UIFont systemFontOfSize:12];
    
    [self.rnameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.right.mas_equalTo(self.nameLable);
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(5);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
    [self.bgView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rnameLable);
        make.right.mas_equalTo(-15);
        make.height.mas_offset(0.5);
        make.top.mas_equalTo(self.rnameLable.mas_bottom).mas_offset(8);
    }];
    
    self.duiImageview = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"项目跟进"];
    [self.bgView addSubview:self.duiImageview];
    
    [self.duiImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(16);
        make.height.mas_offset(16);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.bgView);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(AdjustAddModel *)model{
    self.nameLable.text = model.name;
    self.rnameLable.text = model.rname;
    if (model.isSelect) {
        self.duiImageview.image = [UIImage imageNamed:@"地点选择"];
    }else{
        self.duiImageview.image = [UIImage imageNamed:@""];
    }
}
@end
