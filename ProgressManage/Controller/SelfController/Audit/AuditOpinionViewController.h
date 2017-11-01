//
//  AuditOpinionViewController.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/23.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "BaseViewController.h"
@protocol AuditOpinionViewControllerDelegate <NSObject>
- (void)sendBackChanged:(BOOL)changed;
@end
@interface AuditOpinionViewController : BaseViewController
@property(nonatomic,copy)NSString* _id;
@property(nonatomic,copy)NSString* _state;

@property(nonatomic,weak)id<AuditOpinionViewControllerDelegate>AuditOpinionViewControllerDelegate;

@end
