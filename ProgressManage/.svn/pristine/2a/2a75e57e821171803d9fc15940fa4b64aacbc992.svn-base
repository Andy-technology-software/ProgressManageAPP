//
//  Footprint21TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/26.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "Footprint21TableViewCell.h"

#import "Footprint21Model.h"
@interface Footprint21TableViewCell()
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong)UIButton* tixingBtn;

@end
@implementation Footprint21TableViewCell

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
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
    self.bgView.clipsToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(0);
        make.height.mas_offset(150);
    }];
}

- (void)configCellWithModel:(Footprint21Model *)model{
    float imageWidth = ([MyController getScreenWidth] - 15*5 - 30)/4;
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(0);
        make.height.mas_offset((45 + 50 + imageWidth) * ceil(((float)(model.nameArr.count + 1) / 4)));
    }];
    
    self.tixingBtn = [MyController createButtonWithFrame:self.bgView.frame ImageName:@"给个提醒" Target:self Action:@selector(tixingBtnClick) Title:nil];
    [self.tixingBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [self.tixingBtn setBackgroundColor:[MyController colorWithHexString:@"4c89f0"]];
    [self.bgView addSubview:self.tixingBtn];
    
    [self.tixingBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(85);
//        make.right.mas_equalTo(-85);
        make.centerX.mas_equalTo(self.bgView);
        make.width.mas_offset(124);
        make.height.mas_offset(33);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-20);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 10;
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 10;
    
    for (int i = 0; i < model.nameArr.count; i++) {        
        UIView* temView = [MyController viewWithFrame:CGRectMake(15 * ((i % 4)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           + 1) + (imageWidth * (i % 4)), 15 * ((i / 4) +  1) + imageWidth * (i / 4) + (30 * (i / 4)), imageWidth, imageWidth)];
        temView.backgroundColor = [MyController randomColor];//[MyController colorWithHexString:@"ff7854"];
        temView.layer.cornerRadius = imageWidth/2;
        temView.layer.masksToBounds = YES;
        [temView setContentMode:UIViewContentModeScaleAspectFill];
        temView.clipsToBounds = YES;
        [self.bgView addSubview:temView];
        
        UILabel* temLable = [MyController createLabelWithFrame:temView.frame Font:18 Text:[model.nameArr[i] substringToIndex:1]];
        temLable.textColor = [UIColor whiteColor];
        temLable.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:temLable];
        
        UILabel* titLable = [MyController createLabelWithFrame:CGRectMake(temLable.frame.origin.x, CGRectGetMaxY(temLable.frame), temLable.frame.size.width, 30) Font:14 Text:model.nameArr[i]];
        titLable.textAlignment = NSTextAlignmentCenter;
        titLable.textColor = [MyController colorWithHexString:TEXTCOLOR];
        [self.bgView addSubview:titLable];
    }
}

- (void)tixingBtnClick{
    [self.Footprint21TableViewCellDelegate sendBackTixing];
}

@end
