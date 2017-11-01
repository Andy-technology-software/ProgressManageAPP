//
//  SalesTableViewCell.h
//  ProgressManage
//
//  Created by Gem on 2017/5/8.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesModel.h"
typedef void(^swipeBlock) ();
typedef void(^deleteBlock) ();
typedef void(^cancleBlock) ();
@protocol SalesTableViewCellDelegate <NSObject>
- (void)callNum:(NSInteger)cellIndex;
- (void)editNum:(NSInteger)cellIndex;
- (void)deleteNum:(NSInteger)cellIndex;
@end
@interface SalesTableViewCell : UITableViewCell
@property (nonatomic,strong) SalesModel *model;
@property(nonatomic,weak)id<SalesTableViewCellDelegate>SalesTableViewCellDelegate;
@property(nonatomic,assign)NSInteger cellIndex;

////////////////////////////////////////////////////////
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy)swipeBlock mySwipeBlock;
@property (nonatomic, copy)deleteBlock myDeleteBlock;
-(void)closeMenu;

@end
