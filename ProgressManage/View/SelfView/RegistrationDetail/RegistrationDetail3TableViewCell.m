//
//  RegistrationDetail3TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/23.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "RegistrationDetail3TableViewCell.h"

#import "RegistrationDetail3Model.h"
@interface RegistrationDetail3TableViewCell()
@property (nonatomic, strong) UIView* whiteView;
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* headView;
@property (nonatomic, strong) UIView* lineView1;

@property (nonatomic, strong) UIImageView* yesImageView;
@property (nonatomic, strong) UIImageView* tempImageView;

@property (nonatomic, strong) UILabel* headLable;
@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* stateLable;
@property (nonatomic, strong) UILabel* timeLable;
@property (nonatomic, strong) UILabel* opinionLable;

@property (nonatomic, strong) UIButton* checkBtn;
@end
@implementation RegistrationDetail3TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    
    self.lineView = [MyController viewWithFrame:self.contentView.frame];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"e2e4e8"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.width.mas_offset(3);
    }];
    
    self.yesImageView = [MyController createImageViewWithFrame:self.contentView.frame ImageName:@"请假详情-确认"];
    [self.contentView addSubview:self.yesImageView];
    
    [self.yesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(self.lineView.mas_centerX);
        make.width.mas_offset(12);
        make.height.mas_offset(12);
    }];
    
    self.whiteView = [MyController viewWithFrame:self.contentView.frame];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.whiteView];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView.mas_right).mas_offset(20);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(16);
        make.height.mas_offset(60);
    }];
    
    self.headView = [MyController viewWithFrame:self.whiteView.frame];
    self.headView.backgroundColor = [MyController randomColor];//[MyController colorWithHexString:@"bee099"];
    [self.whiteView addSubview:self.headView];
    //将图层的边框设置为圆脚
    self.headView.layer.cornerRadius = 22;
    self.headView.layer.masksToBounds = YES;
    [self.headView setContentMode:UIViewContentModeScaleAspectFill];
    self.headView.clipsToBounds = YES;
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(10);
        make.height.mas_offset(44);
        make.width.mas_offset(44);
    }];
    
    self.headLable = [MyController createLabelWithFrame:self.whiteView.frame Font:18 Text:nil];
    self.headLable.textColor = [UIColor whiteColor];
    self.headLable.numberOfLines = 1;
    self.headLable.textAlignment = NSTextAlignmentCenter;
    [self.whiteView addSubview:self.headLable];
    
    [self.headLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(10);
        make.height.mas_offset(44);
        make.width.mas_offset(44);
    }];
    
    self.nameLable = [MyController createLabelWithFrame:self.whiteView.frame Font:13 Text:nil];
    self.nameLable.textColor = [MyController colorWithHexString:@"81889d"];
    self.nameLable.numberOfLines = 1;
    [self.whiteView addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headView.mas_right).mas_offset(10);
        make.right.mas_equalTo(-95);
        make.top.mas_equalTo(15);
    }];
    
    self.stateLable = [MyController createLabelWithFrame:self.whiteView.frame Font:13 Text:nil];
    self.stateLable.textColor = [MyController colorWithHexString:@"bee099"];
    self.stateLable.numberOfLines = 1;
    [self.whiteView addSubview:self.stateLable];
    
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(10);
    }];
    
    self.timeLable = [MyController createLabelWithFrame:self.whiteView.frame Font:12 Text:nil];
    self.timeLable.textColor = [MyController colorWithHexString:@"c8cbd4"];
    self.timeLable.numberOfLines = 1;
    self.timeLable.textAlignment = NSTextAlignmentRight;
    [self.whiteView addSubview:self.timeLable];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.stateLable);
    }];
    
    self.hyb_lastViewInCell = self.whiteView;
    self.hyb_bottomOffsetToCell = 4;
    
}

- (void)configCellWithModel:(RegistrationDetail3Model *)model{
    if ([MyController returnStr:model.name].length) {
        self.headLable.text = [model.name substringToIndex:1];
    }
    self.nameLable.text = model.name;
    self.stateLable.text = model.state;
    self.timeLable.text = model.time;
    self.yesImageView.image = [UIImage imageNamed:@"请假详情-确认"];
    if (model.opinion.length) {
        [self.whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lineView.mas_right).mas_offset(20);
            make.right.mas_equalTo(-12);
            make.top.mas_equalTo(16);
            make.height.mas_offset(100);
        }];
        
        self.lineView1 = [MyController viewWithFrame:self.whiteView.frame];
        self.lineView1.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
        [self.whiteView addSubview:self.lineView1];
        
        [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.left.mas_equalTo(self.stateLable);
            make.top.mas_equalTo(self.stateLable.mas_bottom).mas_offset(10);
            make.height.mas_offset(0.5);
        }];
        
        self.opinionLable = [MyController createLabelWithFrame:self.whiteView.frame Font:13 Text:model.opinion];
        self.opinionLable.textColor = [MyController colorWithHexString:@"81889d"];
        self.opinionLable.numberOfLines = 1;
        [self.whiteView addSubview:self.opinionLable];
        
        [self.opinionLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lineView1);
            make.right.mas_equalTo(self.lineView1);
            make.top.mas_equalTo(self.lineView1.mas_bottom).mas_offset(10);
        }];
        
        if (model.image.length) {
            [self.whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.lineView.mas_right).mas_offset(20);
                make.right.mas_equalTo(-12);
                make.top.mas_equalTo(16);
                make.height.mas_offset(230);
            }];
            
            self.tempImageView = [MyController createImageViewWithFrame:self.whiteView.frame ImageName:nil];
            [self.tempImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
            [self.whiteView addSubview:self.tempImageView];
            
            [self.tempImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.opinionLable);
                make.top.mas_equalTo(self.opinionLable.mas_bottom).mas_offset(10);
                make.height.mas_offset(90);
                make.width.mas_offset(120);
            }];
            
            self.checkBtn = [MyController createButtonWithFrame:self.whiteView.frame ImageName:nil Target:self Action:@selector(checkBtnClick:) Title:nil];
            [self.whiteView addSubview:self.checkBtn];
            
            [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.tempImageView);
                make.top.mas_equalTo(self.tempImageView);
                make.height.mas_equalTo(self.tempImageView);
                make.width.mas_equalTo(self.tempImageView);
            }];
        }
    }else{
        if (model.image.length) {
            [self.whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.lineView.mas_right).mas_offset(20);
                make.right.mas_equalTo(-12);
                make.top.mas_equalTo(16);
                make.height.mas_offset(190);
            }];
            
            self.tempImageView = [MyController createImageViewWithFrame:self.whiteView.frame ImageName:nil];
            [self.tempImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
            [self.whiteView addSubview:self.tempImageView];
            
            [self.tempImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.stateLable);
                make.top.mas_equalTo(self.stateLable.mas_bottom).mas_offset(10);
                make.height.mas_offset(90);
                make.width.mas_offset(120);
            }];
            
            self.checkBtn = [MyController createButtonWithFrame:self.whiteView.frame ImageName:nil Target:self Action:@selector(checkBtnClick:) Title:nil];
            [self.whiteView addSubview:self.checkBtn];
            
            [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.tempImageView);
                make.top.mas_equalTo(self.tempImageView);
                make.height.mas_equalTo(self.tempImageView);
                make.width.mas_equalTo(self.tempImageView);
            }];
        }
    }
}

- (void)checkBtnClick:(UIButton*)btn{
    [self.RegistrationDetail3TableViewCellDelegate sendBackCheckImage:self.cellIndex];
}
@end
