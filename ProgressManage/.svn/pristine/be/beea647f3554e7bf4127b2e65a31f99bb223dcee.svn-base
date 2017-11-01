//
//  ContactViewController.h
//  ProgressManage
//
//  Created by Gem on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "BaseViewController.h"
@protocol ContactViewControllerDelegate <NSObject>
- (void)sendBackName:(NSString*)_name AndId:(NSString*)_id;
@end
@interface ContactViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic,assign)BOOL isFromAndy;
@property(nonatomic,weak)id<ContactViewControllerDelegate>ContactViewControllerDelegate;

@end
