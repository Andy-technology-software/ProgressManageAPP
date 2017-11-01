//
//  Registration1TableViewCell.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/22.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "Registration1TableViewCell.h"

#define kFontSize  14.0
#define kMinHeigth 50.0

@interface Registration1TableViewCell()<UITextViewDelegate>
@property (nonatomic, strong) UIView* bgView;


@end
@implementation Registration1TableViewCell

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
}

- (void)setPlaceholder:(NSString*)placeholder
{
    self.textView.placeholder = placeholder;
}

- (CGFloat)cellHeight
{
    CGFloat height = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)].height;
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(0);
        make.height.mas_offset(MAX(kMinHeigth, height + 1.0));
    }];
    return MAX(kMinHeigth, height + 1.0);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self != NULL) {
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
        self.leftLable = [MyController createLabelWithFrame:self.bgView.frame Font:14 Text:nil];
        self.leftLable.textColor = [MyController colorWithHexString:@"a6abb9"];
        [self.bgView addSubview:self.leftLable];
        /*
         15, 45 * i, 69, 45
         */
        [self.leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.height.mas_offset(45);
            make.width.mas_offset(66);
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
            make.left.mas_equalTo(self.leftLable.mas_right);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.leftLable).mas_offset(6);
        }];
        
    }
    
    return self;
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

- (Registration1TableViewCell *)advancedExpandableTextCellWithId1:(NSString*)cellId
{
    Registration1TableViewCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == NULL) {
        cell = [[Registration1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        cell.expandableTableView = self;
        
        //键盘消失的手势
        //        [self tapToDismissKeyboard];
        //        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        //检测键盘事件
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardAvoiding_keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardAvoiding_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
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
