//
//  DailyNew0TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/24.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "DailyNew0TableViewCell.h"

#define kFontSize  14.0
#define kMinHeigth 176.0

@interface DailyNew0TableViewCell()<UITextViewDelegate>
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UIImageView* areaImageView;

@property (nonatomic, strong) UILabel* titleLable;

@property (nonatomic, strong) UIButton* areaBtn;
@end
@implementation DailyNew0TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setText:(NSString*)text
{
    self.textView.text = text;
    self.areaLable.text = self._location;
}

- (void)setPlaceholder:(NSString*)placeholder
{
    self.textView.placeholder = placeholder;
    self.areaLable.text = self._location;
}

- (CGFloat)cellHeight
{
    CGFloat height = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)].height;
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(10);
        make.height.mas_offset(MAX(kMinHeigth, height + 101));
    }];
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable);
        make.right.mas_equalTo(self.titleLable);
        make.top.mas_equalTo(self.titleLable.mas_bottom);
        make.height.mas_offset(MAX(kMinHeigth - 101, height));
    }];
    
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textView);
        make.right.mas_equalTo(self.textView);
        make.height.mas_offset(0.5);
        make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(10);
    }];
    [self.areaImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(17);
    }];
    
    self.areaLable.numberOfLines = 1;
    self.areaLable.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.areaLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.areaImageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.lineView);
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(15);
    }];
    
    [self.areaBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.areaImageView);
        make.right.mas_equalTo(self.areaLable);
        make.top.mas_equalTo(self.areaLable);
        make.bottom.mas_equalTo(self.areaLable);
    }];
    
    return MAX(kMinHeigth, height + 61);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self != NULL) {
        self.contentView.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
        
        self.bgView = [MyController viewWithFrame:self.contentView.frame];
        self.bgView.layer.cornerRadius = 6;
        self.bgView.layer.masksToBounds = YES;
        [self.bgView setContentMode:UIViewContentModeScaleAspectFill];
        self.bgView.clipsToBounds = YES;
        self.bgView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.bgView];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(-12);
            make.top.mas_equalTo(10);
            make.height.mas_offset(kMinHeigth);
        }];
        
        self.titleLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"工作日报"];
        self.titleLable.textColor = [MyController colorWithHexString:@"a6abb9"];
        [self.bgView addSubview:self.titleLable];
        /*
         15, 45 * i, 69, 45
         */
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(0);
            make.height.mas_offset(40);
        }];
        
        self.textView = [[XRQTextview alloc] initWithFrame:self.bgView.frame];
        self.textView.delegate = self;
        
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.textView.placeholderTextColor = [UIColor colorWithRed:(float)0xcc/0xff green:(float)0xcc/0xff blue:(float)0xcc/0xff alpha:1];
        self.textView.backgroundColor = [UIColor whiteColor];
        self.textView.font = [UIFont systemFontOfSize:kFontSize];
        
        self.textView.scrollEnabled = NO;
        self.textView.showsVerticalScrollIndicator = NO;
        self.textView.showsHorizontalScrollIndicator = NO;
        [self.bgView addSubview:self.textView];
        
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLable);
            make.right.mas_equalTo(self.titleLable);
            make.top.mas_equalTo(self.titleLable.mas_bottom);
            make.height.mas_offset(kMinHeigth - 105);
        }];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [MyController colorWithHexString:@"eeeff2"];
        [self.bgView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.textView);
            make.right.mas_equalTo(self.textView);
            make.height.mas_offset(0.5);
            make.top.mas_equalTo(self.textView.mas_bottom).mas_offset(10);
        }];
        
        self.areaImageView = [MyController createImageViewWithFrame:self.bgView.frame ImageName:@"获取位置"];
        [self.bgView addSubview:self.areaImageView];
        
        [self.areaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.lineView);
            make.height.mas_offset(15);
            make.width.mas_offset(15);
            make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(17);
        }];
        
        self.areaLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:@"获取所在位置"];
        self.areaLable.numberOfLines = 1;
        self.areaLable.lineBreakMode = NSLineBreakByTruncatingTail;
        self.areaLable.textColor = [MyController colorWithHexString:@"4c89f0"];
        if ([MyController returnStr:self._location].length) {
            self.areaLable.text = self._location;
        }
        [self.bgView addSubview:self.areaLable];
        
        [self.areaLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.areaImageView.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.lineView);
            make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(15);
            make.height.mas_offset(20);
        }];
        
        self.areaBtn = [MyController createButtonWithFrame:self.bgView.frame ImageName:nil Target:self Action:@selector(areaBtnClick) Title:nil];
        [self.bgView addSubview:self.areaBtn];
        
        [self.areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.areaImageView);
            make.right.mas_equalTo(self.areaLable);
            make.bottom.mas_equalTo(self.areaLable);
        }];
    }
    
    return self;
}
- (void)areaBtnClick{
    [self.DailyNew0TableViewCellDelegate sendBackSelectArea];
}
#pragma mark - Text View Delegate

-(void)textViewDidEndEditing:(UITextView *)textView{
    if ([self.expandableTableView.delegate respondsToSelector:@selector(tableView:textViewDidEndEditing:)]) {
        [(id<AdvancedExpandableTableViewDelegate>)self.expandableTableView.delegate tableView:self.expandableTableView textViewDidEndEditing:self.textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([self.expandableTableView.delegate respondsToSelector:@selector(tableView:textViewDidChangeSelection:)]) {
        [(id<AdvancedExpandableTableViewDelegate>)self.expandableTableView.delegate tableView:self.expandableTableView textViewDidChangeSelection:self.textView];
    }
    
    //
    [self performSelector:@selector(caretPostionChanged)
               withObject:self.textView
               afterDelay:0.1];
}

- (void) caretPostionChanged{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self.expandableTableView.delegate respondsToSelector:@selector(tableView:textView:shouldChangeTextInRange:replacementText:)]) {
        id<AdvancedExpandableTableViewDelegate> delegate = (id<AdvancedExpandableTableViewDelegate>)self.expandableTableView.delegate;
        return [delegate tableView:self.expandableTableView
                          textView:textView
           shouldChangeTextInRange:range
                   replacementText:text];
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    // make sure the cell is at the top
    [self.expandableTableView scrollToRowAtIndexPath:[self.expandableTableView indexPathForCell:self]
                                    atScrollPosition:UITableViewScrollPositionTop
                                            animated:YES];
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.expandableTableView.delegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [(id<AdvancedExpandableTableViewDelegate>)self.expandableTableView.delegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidChange:(UITextView *)theTextView
{
    if ([self.expandableTableView.delegate conformsToProtocol:@protocol(AdvancedExpandableTableViewDelegate)]) {
        
        id<AdvancedExpandableTableViewDelegate> delegate = (id<AdvancedExpandableTableViewDelegate>)self.expandableTableView.delegate;
        NSIndexPath *indexPath = [self.expandableTableView indexPathForCell:self];
        
        // update the text
        if (_maxCharacter > 0 && self.textView.text.length > _maxCharacter) {
            self.textView.text = [self.textView.text substringToIndex:_maxCharacter];
        }
        
        _text = self.textView.text;
        
        [delegate tableView:self.expandableTableView
                updatedText:_text
                atIndexPath:indexPath];
        
        //高度有变化
        CGFloat newHeight = [self cellHeight];
        CGFloat oldHeight = [delegate tableView:self.expandableTableView heightForRowAtIndexPath:indexPath];
        
        if (fabs(newHeight - oldHeight) > 0.01) {
            
            // update the height
            if ([delegate respondsToSelector:@selector(tableView:updatedHeight:atIndexPath:)]) {
                [delegate tableView:self.expandableTableView
                      updatedHeight:newHeight
                        atIndexPath:indexPath];
            }
            
            [self.expandableTableView beginUpdates];
            [self.expandableTableView endUpdates];
        }
        
    }
}


@end


@implementation UITableView (AdvancedExpandableTextCell)

- (DailyNew0TableViewCell *)advancedExpandableTextCellWithId2:(NSString*)cellId
{
    DailyNew0TableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == NULL) {
        cell = [[DailyNew0TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        cell.expandableTableView = self;

        cell.maxCharacter = -1;
    }
    
    return cell;
}

- (void)tapToDismissKeyboard
{
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self addGestureRecognizer:tapGr];
}

- (void)viewTapped:(id)sender
{
    [self endEditing:YES];
}

@end
