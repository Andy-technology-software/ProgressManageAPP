//
//  Registration1TableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/22.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRQTextview.h"
@protocol AdvancedExpandableTableViewDelegate <UITableViewDelegate, UITextViewDelegate>

@required
- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)tableView:(UITableView *)tableView textViewDidChangeSelection:(UITextView*)textView;
- (void)tableView:(UITableView *)tableView textViewDidEndEditing:(UITextView*)textView;
@end
@interface Registration1TableViewCell : UITableViewCell
@property (nonatomic) XRQTextview *textView;
@property (nonatomic, weak) UITableView *expandableTableView;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UILabel* leftLable;
@property (nonatomic) CGFloat cellHeight;

@property (nonatomic) int  maxCharacter;

- (void)setText:(NSString*)text;

@end
@interface UITableView (AdvancedExpandableTextCell)

- (Registration1TableViewCell *)advancedExpandableTextCellWithId1:(NSString*)cellId;

@end
