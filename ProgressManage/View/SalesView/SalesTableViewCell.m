//
//  SalesTableViewCell.m
//  ProgressManage
//
//  Created by Gem on 2017/5/8.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SalesTableViewCell.h"

@implementation SalesTableViewCell

{
    UIView* topView;
    UIView *bgView;
    UIView *point;
    UIView *percentBg;
    UIView *percent;
    UILabel *title;
    UILabel *time;
    UILabel *custom;
    UILabel *customname;
    UILabel *money;
    UILabel *moneyCount;
    UILabel *state;
    UIButton* editBtn;
    UIButton* deleBtn;
    UISwipeGestureRecognizer *swipLeft;
    UISwipeGestureRecognizer *swipRight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
        self.contentView.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    }
    return self;
}
- (void)createView{
    bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.clipsToBounds = YES;
    [bgView setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:bgView];
    
    editBtn = [MyController createButtonWithFrame:CGRectZero ImageName:@"客户-编辑背景" Target:self Action:@selector(editBtnClick) Title:@"编辑"];
    [editBtn setTitleColor:[MyController colorWithHexString:@"838793"] forState:UIControlStateNormal];
    [bgView addSubview:editBtn];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [editBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
    editBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 30, 10, 60);
    editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    deleBtn = [MyController createButtonWithFrame:CGRectZero ImageName:nil Target:self Action:@selector(deleBtnClick) Title:@"删除"];
    [deleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleBtn setBackgroundColor:[MyController colorWithHexString:@"ff7854"]];
    [bgView addSubview:deleBtn];
    deleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    topView = [[UIView alloc] init];
    [bgView addSubview:topView];
    //将图层的边框设置为圆脚
    topView.layer.cornerRadius = 5;
    topView.layer.masksToBounds = YES;
    [topView setContentMode:UIViewContentModeScaleAspectFill];
    topView.clipsToBounds = YES;
    topView.backgroundColor = [UIColor whiteColor];
    
   
    
    point = [[UIView alloc] init];
    point.layer.cornerRadius = 3;
    point.clipsToBounds = YES;
    point.backgroundColor = [MyController colorWithHexString:@"3273f9"];
    [topView addSubview:point];
    
    title = [MyController createLabelWithFrame:CGRectZero Font:14 Text:@""];
    title.lineBreakMode = NSLineBreakByTruncatingTail;
    [topView addSubview:title];
    
    time = [MyController createLabelWithFrame:CGRectZero Font:12 Text:@""];
    time.textAlignment = NSTextAlignmentRight;
    time.textColor = [MyController colorWithHexString:@"81889d"];
    [topView addSubview:time];
    
    percentBg = [UIView new];
    percentBg.backgroundColor = [MyController colorWithHexString:@"ebecee"];
    percentBg.layer.cornerRadius = 2;
    percentBg.clipsToBounds = YES;
    [topView addSubview:percentBg];
    
    percent = [UIView new];
    percent.backgroundColor = [MyController colorWithHexString:@"3273f9"];
    percent.layer.cornerRadius = 2;
    percent.clipsToBounds = YES;
    [topView addSubview:percent];

    
    state = [MyController createLabelWithFrame:CGRectZero Font:12 Text:@""];
    state.textAlignment = NSTextAlignmentCenter;
    state.textColor = [MyController colorWithHexString:@"3273f9"];
    [topView addSubview:state];
    
    custom = [MyController createLabelWithFrame:CGRectZero Font:12 Text:@"客户"];
    custom.textColor = [MyController colorWithHexString:@"81889d"];
    [topView addSubview:custom];
    
    money = [MyController createLabelWithFrame:CGRectZero Font:12 Text:@"合同金额"];
    money.textAlignment = NSTextAlignmentRight;
    money.textColor = [MyController colorWithHexString:@"81889d"];
    [topView addSubview:money];

    
    customname = [MyController createLabelWithFrame:CGRectZero Font:16 Text:@""];
    customname.textColor = [MyController colorWithHexString:@"3273f9"];
    [topView addSubview:customname];
    
    moneyCount = [MyController createLabelWithFrame:CGRectZero Font:16 Text:@""];
    moneyCount.textAlignment = NSTextAlignmentRight;
    moneyCount.textColor = [MyController colorWithHexString:@"3273f9"];
    [topView addSubview:moneyCount];
  
    
}
- (void)editBtnClick{
    [self.SalesTableViewCellDelegate editNum:self.cellIndex];
}

- (void)deleBtnClick{
    [self.SalesTableViewCellDelegate deleteNum:self.cellIndex];
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
        topView.center = CGPointMake(topView.center.x - 144, topView.center.y);
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
        topView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2 - 10, topView.center.y);
    }completion:^(BOOL finished) {
        if (finished) {
            self.isOpen = NO;
        }
    }];
    
}
- (void)setModel:(SalesModel *)model{
    
    int padding = 10;
    title.text = model.title;
    time.text = model.time;
    state.text = model.state;
    customname.text = model.customer;
    moneyCount.text = model.money;
    if ([model.flag isEqualToString:@"1"]) {
        //添加左滑手势
        swipLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
        swipLeft.direction=UISwipeGestureRecognizerDirectionLeft;
        [topView addGestureRecognizer:swipLeft];
        //添加右滑手势
        swipRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
        swipRight.direction=UISwipeGestureRecognizerDirectionRight;
        [topView addGestureRecognizer:swipRight];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(padding / 2);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-padding / 2);
        }];
        [deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(bgView.mas_right);
            make.centerY.mas_equalTo(bgView.centerY);
            make.height.mas_equalTo(editBtn);
            make.width.mas_offset(56);
        }];
        [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(deleBtn.mas_left);
            make.centerY.mas_equalTo(bgView.centerY);
            make.height.mas_offset(75);
            make.width.mas_offset(78);
        }];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(bgView);
            make.right.mas_equalTo(bgView.mas_right);
            make.height.mas_equalTo(bgView);
        }];
    }else{
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(padding / 2);
            make.left.mas_equalTo(padding);
            make.right.mas_equalTo(-padding);
            make.bottom.mas_equalTo(-padding / 2);
        }];
       
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(bgView);
            make.right.mas_equalTo(bgView.mas_right);
            make.height.mas_equalTo(bgView);
        }];
        
    }
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).offset(padding);
        make.left.mas_equalTo(point.mas_right).mas_offset(padding);
        make.right.mas_equalTo(time.mas_left).mas_offset(-padding);
        make.height.mas_offset(20);
    }];
    
    [point mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).offset(padding * 1.5);
        make.left.mas_equalTo(topView.mas_left).mas_offset(padding);
        make.width.mas_offset(6);
        make.height.mas_offset(6);
    }];
    
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(title.mas_right).mas_offset(padding);
        make.right.mas_equalTo(topView.mas_right).mas_offset(-padding);
        make.bottom.mas_equalTo(title.mas_bottom);
    }];
    
    [state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).mas_offset(padding);
        make.right.mas_equalTo(topView.mas_right).mas_offset(-padding);
        make.height.mas_offset(20);
        
    }];
    
    [percentBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).mas_offset(padding * 1.5);
        make.left.mas_equalTo(point.mas_left);
        make.right.mas_equalTo(state.mas_left).mas_offset(-padding);
        make.height.mas_offset(8);
    }];
    
   
    [custom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(state.mas_bottom).mas_offset(padding);
        make.left.mas_equalTo(percentBg.mas_left);
        make.right.mas_equalTo(money.mas_left).mas_offset(-padding);
       
    }];
    
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(state.mas_bottom).mas_offset(padding);
        make.left.mas_equalTo(moneyCount.mas_left);
        make.right.mas_equalTo(topView.mas_right).mas_offset(-padding);
        
    }];
    [customname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(custom.mas_bottom).mas_offset(padding);
        make.left.mas_equalTo(custom.mas_left);
        make.right.mas_equalTo(moneyCount.mas_left).mas_offset(-padding);
        
    }];
    
    [moneyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(money.mas_bottom).mas_offset(padding);
        make.left.mas_equalTo(money.mas_left);
        make.right.mas_equalTo(topView.mas_right).mas_offset(-padding);
        
    }];
    
    [percent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).mas_offset(padding * 1.5);
        make.left.mas_equalTo(point.mas_left);
        make.height.mas_offset(8);
        make.width.mas_equalTo(percentBg.mas_width).multipliedBy([model.percent floatValue]  * 0.01);
    }];
    self.hyb_lastViewInCell = bgView;
    self.hyb_bottomOffsetToCell = 0;

   
}
//-(float)roundFloat:(float)price{
//    NSString *temp = [NSString stringWithFormat:@"%.2f",price];
//    NSDecimalNumber *numResult = [NSDecimalNumber decimalNumberWithString:temp];
//    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
//                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
//                                       scale:2
//                                       raiseOnExactness:NO
//                                       raiseOnOverflow:NO
//                                       raiseOnUnderflow:NO
//                                   raiseOnDivideByZero:YES];
//    return [[numResult decimalNumberByRoundingAccordingToBehavior:roundUp] floatValue];
//}
//
//
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    //遍历子视图，找出左滑按钮
//
//    for (UIView *subView in self.subviews)
//    {
//        NSLog(@"class= %@",[subView class]);
//        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")])
//        {
//            for (UIButton *btn in subView.subviews) {
//                if ([btn isKindOfClass:[UIButton class]]) {
//                    //更改左滑标签按钮样式
//                    if ([btn.titleLabel.text isEqualToString:@"编辑"]) {
//                        [btn setTitle:@"        编辑" forState:UIControlStateNormal];
//                        btn.titleLabel.font = [UIFont systemFontOfSize:13];
//                        [btn setTitleColor:[MyController colorWithHexString:@"838793"] forState:UIControlStateNormal];
//                        [btn setBackgroundImage:[UIImage imageNamed:@"销售-编辑2"] forState:UIControlStateNormal];
//                        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//                        btn.backgroundColor = [UIColor whiteColor];
//                    }else if([btn.titleLabel.text isEqualToString:@"删除"]){
//
//                        //更改左滑详情按钮样式
//                        [btn setTitle:@"删除" forState:UIControlStateNormal];
//                        btn.titleLabel.font = [UIFont systemFontOfSize:13];
//                        [btn setBackgroundImage:[UIImage imageNamed:@"销售-删除2"] forState:UIControlStateNormal];
//                        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//                        btn.backgroundColor = [UIColor whiteColor];
//
//                    }
//                }
//            }
//        }
//    }
//}

@end
