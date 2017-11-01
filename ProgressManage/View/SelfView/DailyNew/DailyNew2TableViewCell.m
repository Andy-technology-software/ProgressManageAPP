//
//  DailyNew2TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "DailyNew2TableViewCell.h"

#import "DailyNew2Model.h"
@interface DailyNew2TableViewCell()
@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UILabel* hLable;
@property(nonatomic,strong)UILabel* hLable1;
@property(retain,strong) UISwitch * mySwitch;

@end
@implementation DailyNew2TableViewCell

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
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(0);
        make.height.mas_offset(50);
    }];
    
    self.hLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"发给谁"];
    [self.bgView addSubview:self.hLable];
    self.hLable.textColor = [MyController colorWithHexString:@"81889d"];
    [self.hLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
        make.width.mas_offset(80);
        make.height.mas_offset(50);
    }];
    
    self.mySwitch = [[UISwitch alloc]init];
    self.mySwitch.frame=CGRectMake(CGRectGetMaxX(self.bgView.frame) - 90, 10, 80, 40);
    //也可以使用set函数
    //[_mySwitch setOn:YES];
    //设置开关状态
    //p1:状态设置
    //p2:是否开启动画效果
    //[_mySwitch setOn:YES animated:YES];
    [self.bgView addSubview:self.mySwitch];
    //        //设置开启状态的风格颜色
    //        [self.mySwitch setOnTintColor:[UIColor orangeColor]];
    //        //设置开关圆按钮的风格颜色
    //        [self.mySwitch setThumbTintColor:[UIColor blueColor]];
    //        //设置整体风格颜色,按钮的白色是整个父布局的背景颜色
    //        [self.mySwitch setTintColor:[UIColor greenColor]];
    [self.mySwitch addTarget:self action:@selector(swChange:) forControlEvents:UIControlEventValueChanged];
    
    self.hLable1 = [MyController createLabelWithFrame:self.bgView.frame Font:12 Text:@"发个消息告知"];
    self.hLable1.textAlignment = NSTextAlignmentRight;
    [self.bgView addSubview:self.hLable1];
    self.hLable1.textColor = [MyController colorWithHexString:@"edeef1"];
    [self.hLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mySwitch.mas_left).mas_offset(-6);
        make.top.mas_equalTo(0);
        make.width.mas_offset(100);
        make.height.mas_offset(50);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(DailyNew2Model *)model{
    self.mySwitch.on = model.isOn;
}

//参数传入开关对象本身
- (void) swChange:(UISwitch*) sw{
    if(sw.on==YES){
        NSLog(@"开关被打开");
        [self.DailyNew2TableViewCellDelegate sendBackIsOn:NO];
    }else{
        NSLog(@"开关被关闭");
        [self.DailyNew2TableViewCellDelegate sendBackIsOn:YES];
    }
}

@end
