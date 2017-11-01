//
//  SelfHeadModel.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelfHeadModel : NSObject
@property(nonatomic,copy)NSString* headImage;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* cname;
@property (nonatomic, assign) int uid;
@property (nonatomic, assign) BOOL isExpand;
@end
