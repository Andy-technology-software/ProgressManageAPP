//
//  WeizhiViewController.h
//  WhereAreYou
//
//  Created by lingnet on 2017/6/15.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "BaseViewController.h"
@protocol WeizhiViewControllerDelegate <NSObject>

- (void)sendBackNoGuiji:(BOOL)noguiji;

@end
@interface WeizhiViewController : BaseViewController
@property(nonatomic,strong)NSMutableArray* nameArr;
@property(nonatomic,strong)NSMutableArray* idArr;
@property(nonatomic,weak)id<WeizhiViewControllerDelegate>WeizhiViewControllerDelegate;

@property(nonatomic,assign)BOOL isFromPerson;
@property(nonatomic,copy)NSString* pName;
@property(nonatomic,copy)NSString* pId;
@end
