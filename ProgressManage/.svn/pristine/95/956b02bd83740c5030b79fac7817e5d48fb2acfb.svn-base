//
//  CustomerTableViewCell.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/8.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomerModel;
typedef void(^swipeBlock) ();
typedef void(^deleteBlock) ();
typedef void(^cancleBlock) ();

@protocol CustomerTableViewCellDelegate <NSObject>
- (void)callNum:(NSInteger)cellIndex;
- (void)editNum:(NSInteger)cellIndex;
- (void)deleteNum:(NSInteger)cellIndex;
@end
@interface CustomerTableViewCell : UITableViewCell
- (void)configCellWithModel:(CustomerModel *)model;
@property(nonatomic,weak)id<CustomerTableViewCellDelegate>CustomerTableViewCellDelegate;
@property(nonatomic,assign)NSInteger cellIndex;

////////////////////////////////////////////////////////
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy)swipeBlock mySwipeBlock;
@property (nonatomic, copy)deleteBlock myDeleteBlock;
-(void)closeMenu;
@end
