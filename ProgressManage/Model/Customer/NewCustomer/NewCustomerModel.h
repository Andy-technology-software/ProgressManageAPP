//
//  NewCustomerModel.h
//  ProgressManage
//
//  Created by lingnet on 2017/5/25.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewCustomerModel : NSObject
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* type;
@property(nonatomic,copy)NSString* jibie;
@property(nonatomic,copy)NSString* phone;
@property(nonatomic,copy)NSString* lxr;
@property(nonatomic,copy)NSString* remark;
@property(nonatomic,strong)NSMutableArray* rightArr;
@end
