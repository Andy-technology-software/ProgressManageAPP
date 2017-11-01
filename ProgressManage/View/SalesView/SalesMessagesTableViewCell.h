//
//  SalesMessagesTableViewCell.h
//  ProgressManage
//
//  Created by Gem on 2017/5/31.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesMessageModel.h"

@protocol salesMessageDelegate <NSObject>

- (void)removeCurrentRecord:(NSInteger)index;
@end
@interface SalesMessagesTableViewCell : UITableViewCell
@property (nonatomic,strong) SalesMessageModel *model;
@property(nonatomic,weak)id<salesMessageDelegate> delegate;
@property(nonatomic,assign)NSInteger index;

@end
