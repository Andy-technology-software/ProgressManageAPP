//
//  AdjustAddViewController.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/11.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "BaseViewController.h"
@protocol AdjustAddViewControllerDelegate <NSObject>

- (void)sendBackSelectTime:(NSString*)addName add1:(NSString*)add1 jingdu:(NSString*)jingdu weidu:(NSString*)weidu;
@end
@interface AdjustAddViewController : BaseViewController
@property(nonatomic,weak)id<AdjustAddViewControllerDelegate>AdjustAddViewControllerDelegate;

@end
