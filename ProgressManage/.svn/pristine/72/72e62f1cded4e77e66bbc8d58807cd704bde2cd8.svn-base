//
//  ApplyTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/27.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ApplyTableViewCell.h"

@interface ApplyTableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UIView* bgView;

@end
@implementation ApplyTableViewCell

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
        make.height.mas_offset(45 * 5);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 10;
}

- (void)configCellWithModel{
    NSArray* TemLArr = [[NSArray alloc] initWithObjects:@"姓名",@"企业名称",@"联系电话",@"邮箱",@"推荐人", nil];
    for (int i = 0; i < 5; i++) {
        UILabel* temL = [MyController createLabelWithFrame:CGRectMake(15, 45 * i, 69, 45) Font:14 Text:TemLArr[i]];
        temL.textColor = [MyController colorWithHexString:TEXTCOLOR];
        [self.bgView addSubview:temL];
        
        UITextField* temtf = [MyController createTextFieldWithFrame:CGRectMake(CGRectGetMaxX(temL.frame), temL.frame.origin.y, [MyController getScreenWidth] - 60 - 69, 45) placeholder:@"请填写" passWord:NO leftImageView:nil rightImageView:nil Font:14];
        temtf.delegate = self;
        temtf.tag = 100 + i;
        [self.bgView addSubview:temtf];
        
        if (i < 4) {
            UIView* lineView = [MyController viewWithFrame:CGRectMake(15, 45 * (i + 1), [MyController getScreenWidth] - 60, 0.5)];
            lineView.backgroundColor = [MyController colorWithHexString:LINECOLOR];
            [self.bgView addSubview:lineView];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.ApplyTableViewCellDelegate sendIndex:textField.tag - 100 AndText:textField.text];
}

@end
