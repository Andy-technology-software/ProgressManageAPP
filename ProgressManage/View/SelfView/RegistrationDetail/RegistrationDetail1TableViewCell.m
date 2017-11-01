//
//  RegistrationDetail1TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/23.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "RegistrationDetail1TableViewCell.h"

#import "RegistrationDetail1Model.h"
@interface RegistrationDetail1TableViewCell()
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* bgView;

@property (nonatomic, strong) UILabel* leftLable;
@property (nonatomic, strong) UILabel* rightLable;
@end
@implementation RegistrationDetail1TableViewCell

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
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(0);
        make.height.mas_offset(43);
    }];

    self.leftLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:nil];
    self.leftLable.textColor = [MyController colorWithHexString:@"8b91a4"];
    [self.bgView addSubview:self.leftLable];
    
    [self.leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.height.mas_offset(43);
        make.width.mas_offset(69);
    }];
    
    self.rightLable = [MyController createLabelWithFrame:self.bgView.frame Font:12 Text:nil];
    self.rightLable.textColor = [MyController colorWithHexString:@"9fa4b3"];
    [self.bgView addSubview:self.rightLable];
    
    [self.rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftLable.mas_right);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.leftLable);
        make.height.mas_equalTo(self.leftLable);
    }];
    
    self.lineView = [MyController viewWithFrame:self.bgView.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
    [self.bgView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(-0.5);
        make.height.mas_offset(0.5);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(RegistrationDetail1Model *)model{
    self.leftLable.text = model.leftTitle;
    self.rightLable.text = model.rightTitle;

}
@end
