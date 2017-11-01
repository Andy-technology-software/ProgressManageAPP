//
//  SignSecondImageTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/12.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SignSecondImageTableViewCell.h"

#import "SignSecondImageModel.h"
@interface SignSecondImageTableViewCell()<UIAlertViewDelegate>
@property (nonatomic, strong) UIView* bgView;
@property(nonatomic,assign)NSInteger imgaeNum;
@property(nonatomic,assign)NSInteger delNum;

@end

@implementation SignSecondImageTableViewCell

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
        make.height.mas_offset(90);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(SignSecondImageModel *)model{
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
        make.top.mas_equalTo(0);
        make.height.mas_offset((30 + imageWidth) * ceil(((float)(model.imageArr.count + 1) / 4)));
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
    
    self.imgaeNum = model.imageArr.count;
    if (model.imageArr.count < 1) {
        for (int i = 0; i < model.imageArr.count + 1; i++) {
            UIImageView* seleIv = [MyController createImageViewWithFrame:CGRectMake(20 * ((i % 4)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           + 1) + (imageWidth * (i % 4)), 15 * ((i / 4) +  1) + imageWidth * (i / 4), imageWidth, imageWidth) ImageName:nil];
            seleIv.tag = 2000 + i;
            [self.bgView addSubview:seleIv];
            
            UIButton* imageBtn = [MyController createButtonWithFrame:seleIv.frame ImageName:nil Target:self Action:@selector(imageBtnClick:) Title:nil];
            imageBtn.tag = 2000 + i;
            [self.bgView addSubview:imageBtn];
            
            if (i != self.imgaeNum) {
                seleIv.image = model.imageArr[i];
                
                UIButton* deleBtn = [MyController createButtonWithFrame:CGRectMake(seleIv.frame.origin.x, seleIv.frame.origin.y, imageWidth, 20) ImageName:nil Target:self Action:@selector(deleBtnClick:) Title:@"删除"];
                [deleBtn setBackgroundColor:[UIColor lightGrayColor]];
                deleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
                [deleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                deleBtn.alpha = 0.6;
                deleBtn.tag = 3000 + i;
                [self.bgView addSubview:deleBtn];
            }else{
                seleIv.image = [UIImage imageNamed:@"拍照"];
            }
        }
    }else{
        for (int i = 0; i < model.imageArr.count; i++) {
            UIImageView* seleIv = [MyController createImageViewWithFrame:CGRectMake(20 * ((i % 4)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           + 1) + (imageWidth * (i % 4)), 15 * ((i / 4) +  1) + imageWidth * (i / 4), imageWidth, imageWidth) ImageName:nil];
            [self.bgView addSubview:seleIv];
            seleIv.image = model.imageArr[i];
            
            UIButton* imageBtn = [MyController createButtonWithFrame:seleIv.frame ImageName:nil Target:self Action:@selector(imageBtnClick:) Title:nil];
            imageBtn.tag = 2000 + i;
            [self.bgView addSubview:imageBtn];
            
            UIButton* deleBtn = [MyController createButtonWithFrame:CGRectMake(seleIv.frame.origin.x, seleIv.frame.origin.y, imageWidth, 20) ImageName:nil Target:self Action:@selector(deleBtnClick:) Title:@"删除"];
            [deleBtn setBackgroundColor:[UIColor lightGrayColor]];
            deleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            [deleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            deleBtn.alpha = 0.6;
            deleBtn.tag = 3000 + i;
            [self.bgView addSubview:deleBtn];
        }
    }
}

- (void)deleBtnClick:(UIButton*)btn{
    NSLog(@"删除%ld",btn.tag - 3000);
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除该图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.delNum = btn.tag - 3000;
    [al show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (1 == buttonIndex) {
        NSLog(@"删除");
        [self.SignSecondImageTableViewCellDelegate sendBackDeleImage:self.delNum];
    }
}
- (void)imageBtnClick:(UIButton*)btn{
    if (self.imgaeNum == btn.tag - 2000) {
        [self.SignSecondImageTableViewCellDelegate sendBackAddImage];
    }else{
        [self.SignSecondImageTableViewCellDelegate sendBackSelectImage:btn.tag - 2000];
    }
}

@end
