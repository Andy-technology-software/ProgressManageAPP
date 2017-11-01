//
//  GemHeader.h
//  ProgressManage
//
//  Created by Gem on 2017/5/4.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#ifndef GemHeader_h
#define GemHeader_h
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "UIView+Extension.h"
#import <HyphenateLite_CN/EMSDK.h>
#import "EaseUI.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#define HEADER1 @"http://192.168.10.29:8080/lpms/app/"
#define NEWINFO @"http://192.168.10.29:8080/lpms/app/"
//#define NEWINFO @"http://192.168.1.41:8080/lpms/app/"
//http://192.168.10.29:8080/lpms/app/token!createToken.action?userId=402881993f55f1cd013f55fd5e5c0001&cname=ilingnet
/****************************凌信*******************************************/
//1. 通讯录
#define Contact NEWINFO"lingxin!contact.action"

//2. 消息
#define Message NEWINFO"daily!getPushMessageList.action"

/****************************销售*******************************************/
//1. 销售列表
#define SaleList NEWINFO"sales!saleList.action"

//2. 筛选条件
#define Condation NEWINFO"sales!condation.action"

//3. 销售机会识别详情
#define Saledetail NEWINFO"sales!saledetail.action"

//4. 销售其他详情
#define ActRecords NEWINFO"sales!actRecords.action"

//5. 销售新增
#define Increase NEWINFO"sales!increase.action"

//6. 销售筛选
#define SearchCon NEWINFO"sales!searchCon.action"

//7. 销售详情新增
#define AddAct NEWINFO"sales!addAct.action"

//8. 销售详情删除
#define ActDelete NEWINFO"sales!actDelete.action"

//9. 销售删除
#define SalesDelete NEWINFO"sales!salesDelete.action"

//10. 开票获取订单编号
#define GetContractNumber NEWINFO"sales!getContractNumber.action"

// tolen
#define TokenURL NEWINFO"token!createToken.action"

#endif /* GemHeader_h */
