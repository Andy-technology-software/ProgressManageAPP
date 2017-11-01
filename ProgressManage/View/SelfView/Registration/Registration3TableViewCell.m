//
//  Registration3TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/22.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "Registration3TableViewCell.h"

#import "Registration3Model.h"
@interface Registration3TableViewCell()
@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UIView* bgView;
@property(nonatomic,assign)NSInteger imgaeNum;
@property(nonatomic,assign)NSInteger delNum;

@end
@implementation Registration3TableViewCell

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
        make.top.mas_equalTo(10);
        make.height.mas_offset(76);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 16;
}

- (void)configCellWithModel:(Registration3Model *)model{
    float imageWidth = ([MyController getScreenWidth] - 20*5 - 24)/4;
    self.bgView = [MyController viewWithFrame:self.contentView.frame];
    self.bgView.backgroundColor = [UIColor whiteColor];
    //将图层的边框设置为圆脚
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
    self.bgView.clipsToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(10);
        make.height.mas_offset((30 + imageWidth) * ceil(((float)(model.approvalArr.count + 1) / 4)) + 35);
    }];
    
    self.titleLable = [MyController createLabelWithFrame:self.contentView.frame Font:14 Text:@"审批人"];
    self.titleLable.textColor = [MyController colorWithHexString:@"81889d"];
    [self.bgView addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(11);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 16;
    
    self.imgaeNum = model.approvalArr.count;
    
    UIImageView* seleIv = [MyController createImageViewWithFrame:CGRectMake(20, 35, imageWidth, imageWidth) ImageName:nil];
    [self.bgView addSubview:seleIv];
    
    UIButton* deleBtn = [MyController createButtonWithFrame:CGRectMake(seleIv.frame.origin.x, seleIv.frame.origin.y, imageWidth, imageWidth) ImageName:nil Target:self Action:@selector(deleBtnClick:) Title:nil];
    
    NSString* aa = [model.approvalArr lastObject];
    if (0 == [MyController returnStr:aa].length) {
        seleIv.image = [UIImage imageNamed:@"添加审批人"];
    }else{
        [deleBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [deleBtn setTitle:[aa substringToIndex:1] forState:UIControlStateNormal];
        [deleBtn setBackgroundColor:[MyController colorWithHexString:@"ff7854"]];
    }
    [self.bgView addSubview:deleBtn];
    
//    for (int i = 0; i < model.approvalArr.count + 1; i++) {
//        UIImageView* seleIv = [MyController createImageViewWithFrame:CGRectMake(20 * ((i % 4)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           + 1) + (imageWidth * (i % 4)), 15 * ((i / 4) +  1) + imageWidth * (i / 4) + 35, imageWidth, imageWidth) ImageName:nil];
//        seleIv.tag = 2000 + i;
//        [self.bgView addSubview:seleIv];
//        
//        UIButton* deleBtn = [MyController createButtonWithFrame:CGRectMake(seleIv.frame.origin.x, seleIv.frame.origin.y, imageWidth, imageWidth) ImageName:nil Target:self Action:@selector(deleBtnClick:) Title:nil];
//        deleBtn.tag = 3000 + i;
//        
//        if (i != self.imgaeNum) {
//            seleIv.image = model.approvalArr[i];
//        }else{
//            seleIv.image = [UIImage imageNamed:@"添加审批人"];
//        }
//        [self.bgView addSubview:deleBtn];
//    }
}

- (void)deleBtnClick:(UIButton*)btn{
    NSLog(@"删除%ld",btn.tag - 3000);
    [self.Registration3TableViewCellDelegate sendBackAdd3];
}

@end
