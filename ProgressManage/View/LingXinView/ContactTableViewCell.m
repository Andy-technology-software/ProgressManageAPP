//
//  ContactTableViewCell.m
//  ProgressManage
//
//  Created by Gem on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "UIView+SDAutoLayout.h"

@implementation ContactTableViewCell

{
    UIView *bgView;
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
    UILabel *_phoneLabel;
    UILabel *_departmentLabel;
    
    UIView *_line;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 这行代是为了解决tableview开启了字母序列索引之后cell会向左缩进一段距离的问题
        self.contentView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        [self setupView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    //    frame.size.width = 375;
    [super setFrame:frame];
}

- (void)setupView
{
    bgView = [UIView new];
    [self.contentView addSubview:bgView];
    _iconImageView = [UIImageView new];
    [bgView addSubview:_iconImageView];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    [bgView addSubview:_nameLabel];
    
    _phoneLabel = [UILabel new];
    _phoneLabel.font = [UIFont systemFontOfSize:12];
    _phoneLabel.textColor = [MyController colorWithHexString:@"848893"];
    [bgView addSubview:_nameLabel];

    
    _departmentLabel = [UILabel new];
    _departmentLabel.textColor = [MyController colorWithHexString:@"848893"];
    _departmentLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:_departmentLabel];
    
    
    _line = [UIView new];
    _line.backgroundColor = [MyController colorWithHexString:@"e8e8e8"];
    [bgView addSubview:_line];
    
    
    
}

- (void)setModel:(ContactModel *)model
{
    CGFloat margin = 10;
    _model = model;
    bgView.sd_layout
    .leftSpaceToView(self.contentView,margin)
    .rightSpaceToView(self.contentView,margin)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    
    _iconImageView.layer.cornerRadius = 20;
    _iconImageView.clipsToBounds = YES;
    _iconImageView.sd_layout
    .leftSpaceToView(bgView, margin)
    .widthIs(40)
    .heightEqualToWidth()
    .centerYEqualToView(bgView);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconImageView, margin)
    .topEqualToView(_iconImageView)
    .rightSpaceToView(bgView, margin)
    .heightIs(20);
    
    _phoneLabel.sd_layout
    .leftSpaceToView(_iconImageView, margin)
    .bottomEqualToView(_iconImageView)
    .rightSpaceToView(bgView, margin)
    .heightIs(20);
    
    _departmentLabel.sd_layout
    .leftSpaceToView(_iconImageView, margin)
    .topSpaceToView(_nameLabel,0)
    .rightSpaceToView(bgView, margin)
    .heightIs(16);
    
    _line.sd_layout
    .leftEqualToView(bgView)
    .rightEqualToView(bgView)
    .bottomEqualToView(bgView)
    .heightIs(0.5);

    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"我-默认头像"]];
    _departmentLabel.text = [NSString stringWithFormat:@"%@",[MyController returnStr:model.phone]];
    _nameLabel.text = model.name;
    _phoneLabel.text = model.phone;
}
+ (CGFloat)fixedHeight
{
    return 60;
}


@end
