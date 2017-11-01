//
//  Registration2TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/22.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "Registration2TableViewCell.h"

#import "Registration2Model.h"
@interface Registration2TableViewCell()<UIAlertViewDelegate>
@property (nonatomic, strong) UIView* bgView;
@property(nonatomic,assign)BOOL isUseImage;
@end
@implementation Registration2TableViewCell

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
        make.top.mas_equalTo(-5);
        make.height.mas_offset(95);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(Registration2Model *)model{
    UIImageView* seleIv = [MyController createImageViewWithFrame:CGRectMake(20, 15, 60, 60) ImageName:@""];
    [self.bgView addSubview:seleIv];
    
    UIButton* imageBtn = [MyController createButtonWithFrame:seleIv.frame ImageName:nil Target:self Action:@selector(imageBtnClick) Title:nil];
    [self.bgView addSubview:imageBtn];
    
    //如果选了图片的话那就显示已选图片
    if (model.useImage) {
        self.isUseImage = YES;
        seleIv.image = model.useImage;
        
        UIButton* deleBtn = [MyController createButtonWithFrame:CGRectMake(seleIv.frame.origin.x, seleIv.frame.origin.y, 60, 20) ImageName:nil Target:self Action:@selector(deleBtnClick) Title:@"删除"];
        [deleBtn setBackgroundColor:[UIColor lightGrayColor]];
        deleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [deleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        deleBtn.alpha = 0.6;
        [self.bgView addSubview:deleBtn];
    }else{
        self.isUseImage = NO;
        seleIv.image = [UIImage imageNamed:@"拍照"];
    }
}

- (void)deleBtnClick{
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除该图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [al show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (1 == buttonIndex) {
        NSLog(@"删除");
        [self.Registration2TableViewCellDelegate sendBackDelImage];
    }
}
- (void)imageBtnClick{
    if (self.isUseImage) {
        [self.Registration2TableViewCellDelegate sendBackCheckImage];
    }else{
        [self.Registration2TableViewCellDelegate sendBackAddImage];
    }
}

@end
