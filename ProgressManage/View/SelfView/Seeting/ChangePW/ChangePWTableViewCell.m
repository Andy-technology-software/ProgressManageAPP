//
//  ChangePWTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ChangePWTableViewCell.h"

@interface ChangePWTableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UIView* bgView;

@end
@implementation ChangePWTableViewCell

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
        make.height.mas_offset(45 * 3);
    }];
    
    NSArray* titA = [[NSArray alloc] initWithObjects:@"原始密码",@"新密码",@"确认密码", nil];
    for (int i = 0; i < 3; i++) {
        UILabel* titLable = [MyController createLabelWithFrame:CGRectMake(12, i * 45, 80, 45) Font:14 Text:titA[i]];
        titLable.textColor = [MyController colorWithHexString:TEXTCOLOR];
        [self.bgView addSubview:titLable];
        
        UITextField* tf = [MyController createTextFieldWithFrame:CGRectMake(95, i * 45, [MyController getScreenWidth] - 60 - 80, 45) placeholder:@"请填写" passWord:NO leftImageView:nil rightImageView:nil Font:14];
        tf.tag = 100 + i;
        tf.delegate = self;
        [self.bgView addSubview:tf];
        
        if (i < 2) {
            UIView* linv = [MyController viewWithFrame:CGRectMake(12, 45 * (i + 1), [MyController getScreenWidth] - 30 - 24, 0.5)];
            linv.backgroundColor = [MyController colorWithHexString:LINECOLOR];
            [self.bgView addSubview:linv];
        }
    }
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.ChangePWTableViewCellDelegate sendBackTextIndex:textField.tag - 100 AndText:textField.text];
}


@end