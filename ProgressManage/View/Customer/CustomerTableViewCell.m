//
//  CustomerTableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/8.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "CustomerTableViewCell.h"

#import "CustomerModel.h"
@interface CustomerTableViewCell()
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* topView;

@property (nonatomic, strong) UIImageView* pointImageview;
@property (nonatomic, strong) UIImageView* vipImageview;
@property (nonatomic, strong) UIImageView* telImageview;

@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* typeLable;
@property (nonatomic, strong) UILabel* telLable;

@property (nonatomic, strong) UIButton* callBtn;
@property (nonatomic, strong) UIButton* editBtn;
@property (nonatomic, strong) UIButton* deleBtn;

@end
@implementation CustomerTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    
    self.bgView = [[UIView alloc] init];
    [self.contentView addSubview:self.bgView];
    //将图层的边框设置为圆脚
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
    self.bgView.clipsToBounds = YES;
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.top.mas_equalTo(6);
        make.right.mas_equalTo(-13);
        make.height.mas_offset(116);
    }];
    
    self.topView = [[UIView alloc] init];
    [self.bgView addSubview:self.topView];
    //将图层的边框设置为圆脚
    self.topView.layer.cornerRadius = 6;
    self.topView.layer.masksToBounds = YES;
    [self.topView setContentMode:UIViewContentModeScaleAspectFill];
    self.topView.clipsToBounds = YES;
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.bgView);
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(134);
        make.height.mas_equalTo(self.bgView);
    }];
    
    //添加左滑手势
    UISwipeGestureRecognizer *swipLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.topView addGestureRecognizer:swipLeft];
    //添加右滑手势
    UISwipeGestureRecognizer *swipRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipRight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.topView addGestureRecognizer:swipRight];
    
    
    self.pointImageview = [[UIImageView alloc] init];
    [self.topView addSubview:self.pointImageview];
    //将图层的边框设置为圆脚
    self.pointImageview.layer.cornerRadius = 6;
    self.pointImageview.layer.masksToBounds = YES;
    [self.pointImageview setContentMode:UIViewContentModeScaleAspectFill];
    self.pointImageview.clipsToBounds = YES;
    self.pointImageview.backgroundColor = [MyController colorWithHexString:@"4c89f0"];
    
    [self.pointImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(18);
        make.width.mas_offset(12);
        make.height.mas_offset(12);
    }];
    
    self.titleLable = [[UILabel alloc] init];
    [self.topView addSubview:self.titleLable];
    self.titleLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.titleLable.numberOfLines = 1;
    self.titleLable.font = [UIFont systemFontOfSize:14];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pointImageview.mas_right).offset(6);
        make.top.mas_equalTo(15);
        make.right.mas_lessThanOrEqualTo(-25);
    }];
    
    self.vipImageview = [[UIImageView alloc] init];
    [self.topView addSubview:self.vipImageview];
    
    [self.vipImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable.mas_right).mas_offset(2);
        make.bottom.mas_equalTo(self.titleLable);
        make.width.mas_offset(14);
        make.height.mas_offset(14);
    }];
    
    self.nameLable = [[UILabel alloc] init];
    [self.topView addSubview:self.nameLable];
    self.nameLable.textColor = [MyController colorWithHexString:@"81889d"];
    self.nameLable.numberOfLines = 1;
    self.nameLable.font = [UIFont systemFontOfSize:12];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pointImageview);
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(15);
    }];
    
    self.typeLable = [[UILabel alloc] init];
    [self.topView addSubview:self.typeLable];
    self.typeLable.textColor = [MyController colorWithHexString:@"81889d"];
    self.typeLable.numberOfLines = 1;
    self.typeLable.textAlignment = NSTextAlignmentRight;
    self.typeLable.font = [UIFont systemFontOfSize:12];
    
    [self.typeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable.mas_right).mas_offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-30);
        make.top.mas_equalTo(self.nameLable);
    }];
    
    self.telLable = [[UILabel alloc] init];
    [self.topView addSubview:self.telLable];
    self.telLable.textColor = [MyController colorWithHexString:@"81889d"];
    self.telLable.numberOfLines = 1;
    self.telLable.font = [UIFont systemFontOfSize:12];
    
    [self.telLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLable);
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(15);
    }];

    self.telImageview = [[UIImageView alloc] init];
    [self.topView addSubview:self.telImageview];
    
    [self.telImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.telLable.mas_right).mas_offset(2);
        make.top.mas_equalTo(self.telLable).mas_offset(5);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];
    
    self.callBtn = [MyController createButtonWithFrame:self.topView.frame ImageName:nil Target:self Action:@selector(callBtnClick) Title:nil];
    [self.topView addSubview:self.callBtn];
    [self.callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.telLable);
        make.right.mas_equalTo(self.telImageview);
        make.top.mas_equalTo(self.telLable);
        make.bottom.mas_equalTo(self.telLable);
    }];
    
    self.editBtn = [MyController createButtonWithFrame:self.topView.frame ImageName:@"客户-编辑背景" Target:self Action:@selector(editBtnClick) Title:@"编辑"];
    [self.editBtn setTitleColor:[MyController colorWithHexString:@"838793"] forState:UIControlStateNormal];
    [self.topView addSubview:self.editBtn];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.editBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
    self.editBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 30, 10, 60);
    self.editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_right);
        make.top.mas_equalTo(23);
        make.height.mas_offset(75);
        make.width.mas_offset(78);
    }];
    
    self.deleBtn = [MyController createButtonWithFrame:self.topView.frame ImageName:nil Target:self Action:@selector(deleBtnClick) Title:@"删除"];
    [self.deleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.deleBtn setBackgroundColor:[MyController colorWithHexString:@"ff7854"]];
    [self.topView addSubview:self.deleBtn];
    self.deleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.editBtn.mas_right);
        make.top.mas_equalTo(self.editBtn);
        make.height.mas_equalTo(self.editBtn);
        make.width.mas_offset(56);
    }];
    
    self.hyb_lastViewInCell = self.topView;
    self.hyb_bottomOffsetToCell = 5;
}

- (void)configCellWithModel:(CustomerModel *)model{
    self.titleLable.text = model.custName;
    if ([@"VIP客户" isEqualToString:model.custLevel]) {
        self.vipImageview.image = [UIImage imageNamed:@"vip"];
    }else {
        self.vipImageview.image = [UIImage imageNamed:@""];
    }
    
    self.nameLable.text = [NSString stringWithFormat:@"联系人   %@",model.contactPer];
    [MyController fuwenbenLabel:self.nameLable FontNumber:[UIFont systemFontOfSize:16] AndRange:NSMakeRange(3, self.nameLable.text.length - 3) AndColor:[MyController colorWithHexString:@"4c89f0"]];
    self.typeLable.text = [NSString stringWithFormat:@"类型    %@",model.custType];
    [MyController fuwenbenLabel:self.typeLable FontNumber:[UIFont systemFontOfSize:16] AndRange:NSMakeRange(2, self.typeLable.text.length - 2) AndColor:[MyController colorWithHexString:@"4c89f0"]];
    self.telLable.text = [NSString stringWithFormat:@"联系方式   %@",model.phone];;
    [MyController fuwenbenLabel:self.telLable FontNumber:[UIFont systemFontOfSize:16] AndRange:NSMakeRange(4, self.telLable.text.length - 4) AndColor:[MyController colorWithHexString:@"4c89f0"]];
    self.telImageview.image = [UIImage imageNamed:@"电话"];
}

- (void)callBtnClick{
    [self.CustomerTableViewCellDelegate callNum:self.cellIndex];
}

- (void)editBtnClick{
    [self.CustomerTableViewCellDelegate editNum:self.cellIndex];
}

- (void)deleBtnClick{
    [self.CustomerTableViewCellDelegate deleteNum:self.cellIndex];
}

- (void)swip:(UISwipeGestureRecognizer *)swipe{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        // 打开
        [self openMenu];
        // 将其他已打开的关闭
        if( self.mySwipeBlock ){
            self.mySwipeBlock();
        }
    }else if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        // 关闭
        [self closeMenu];
    }
}

- (void)openMenu{
    if (self.isOpen) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.topView.center = CGPointMake(self.topView.center.x - 134, self.topView.center.y);
    }completion:^(BOOL finished) {
        if(finished){
            self.isOpen = YES;
        }
    }];
}

/**关闭左滑菜单*/
-(void)closeMenu
{
    if(!_isOpen)
        return;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.topView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 + 54, self.topView.center.y);
    }completion:^(BOOL finished) {
        if (finished) {
            self.isOpen = NO;
        }
    }];
    
}


@end
