//
//  DailyNew1TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "DailyNew1TableViewCell.h"

#import "DailyNew1Model.h"
@interface DailyNew1TableViewCell()
//d48a4e19d3e04be694d24798605803dd
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* lineView;

@end
@implementation DailyNew1TableViewCell

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
        make.top.mas_equalTo(-5);
        make.height.mas_offset(50);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 10;
}

- (void)configCellWithModel:(DailyNew1Model *)model{
    float baiwidth = (([MyController getScreenWidth] - 24) - 30*6)/7;
    float btnwidth = 30;
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(-5);
        make.height.mas_offset((20 + btnwidth) * ceil(((float)(model.pArr.count + 1) / 6)));
    }];
    
    
    UIButton* temBtn = [MyController createButtonWithFrame:CGRectMake(10, 15, btnwidth, btnwidth) ImageName:nil Target:self Action:@selector(temBtnClick:) Title:nil];
    if (0 == model.pArr.count) {
        //没人
        [temBtn setBackgroundImage:[UIImage imageNamed:@"添加发给谁"] forState:UIControlStateNormal];
    }else{
        //有人
        NSString* aa = [model.pArr lastObject];
        [temBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [temBtn setTitle:[aa substringToIndex:1] forState:UIControlStateNormal];
        [temBtn setBackgroundColor:[MyController colorWithHexString:@"ff7854"]];
    }
     [self.bgView addSubview:temBtn];
    
//    for (int i = 0; i < model.pArr.count + 1; i++) {
//        UIButton* temBtn = [MyController createButtonWithFrame:CGRectMake((baiwidth * (i % 6)) + btnwidth * ((i % 6) + 1),(i / 6) * btnwidth + ((i / 6) + 1) * 15, btnwidth, btnwidth) ImageName:nil Target:self Action:@selector(temBtnClick:) Title:nil];
//        temBtn.tag = 1000 + i;
//        [self.bgView addSubview:temBtn];
//        if (i == model.pArr.count) {
//            //没人
//            [temBtn setBackgroundImage:[UIImage imageNamed:@"添加发给谁"] forState:UIControlStateNormal];
//        }else{
//            //有人
//            [temBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//            [temBtn setTitle:@"皮" forState:UIControlStateNormal];
//            [temBtn setBackgroundColor:[MyController colorWithHexString:@"ff7854"]];
//        }
//    }
}

- (void)temBtnClick:(UIButton*)btn{
    [self.DailyNew1TableViewCellDelegate sendBackAddPerson];
}

@end