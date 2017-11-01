//
//  requestService.m
//  WhereAreYou
//
//  Created by lingnet on 2017/7/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#import "requestService.h"

@implementation requestService


/********************************************************************************销售过程接口**********************************************************************************************/




/**
12.日报

@param userId 当前用户 id
@param content 日报内容
@param loaction 地址
@param sendMessage 是否发送消息 0 不发，1 发送
@param sendPers 添加的多个用户 Id
@param time 日报填写时间
@param token 时间戳
@param cname 公司名
@param complate 请求完成
@param failure 请求失败
*/
+(void)postCreateDailyWithUserId:(NSString*)userId content:(NSString*)content loaction:(NSString*)loaction sendMessage:(NSString*)sendMessage sendPers:(NSString*)sendPers token:(NSString*)token time:(NSString*)time cname:(NSString*)cname complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",createDaily];
    NSDictionary* param = @{@"userId":userId,@"content":content,@"loaction":loaction,@"sendMessage":sendMessage,@"sendPers":sendPers,@"token":token,@"time":time,@"cname":cname};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}






/**
 13.获取下级人员
 
 @param userId 当前用户 id
 @param token 时间戳
 @param cname 公司名
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetNextPersWithUserId:(NSString*)userId token:(NSString*)token cname:(NSString*)cname complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getNextPers];
    NSDictionary* param = @{@"userId":userId,@"token":token,@"cname":cname};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}








/**
 14.日报列表
 
 @param userId 当前用户 id
 @param time 选择时间日期
 @param _id 人员 Id
 @param token 时间戳
 @param num 数量
 @param pnum 页码
 @param cname 公司名
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postdailyListWithUserId:(NSString*)userId time:(NSString*)time id:(NSString*)_id token:(NSString*)token num:(NSString*)num pnum:(NSString*)pnum cname:(NSString*)cname complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",dailyList];
    NSDictionary* param = @{@"userId":userId,@"time":time,@"id":_id,@"token":token,@"num":num,@"pnum":pnum,@"cname":cname};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}







/**
 15.请假/外出（leave!XXXX.action获取请假/外出次数）
 
 @param userId 当前用户 id
 @param type 0外出；1请假
 @param token 时间戳
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetLeaveNumWithUserId:(NSString*)userId type:(NSString*)type token:(NSString*)token complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getLeaveNum];
    NSDictionary* param = @{@"userId":userId,@"type":type,@"token":token};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}







/**
 16.请假/外出（leave!XXXX.action）
 
 @param userId 当前用户 id
 @param leaveType 外出类型\请假类型
 @param stime 开始时间
 @param etime 结束时间
 @param duration 时长
 @param due 外出事由
 @param leaveImg 图片
 @param auditPers 审批人
 @param type 0外出；1请假
 @param token 时间戳
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postCreateLeaveWithUserId:(NSString*)userId leaveType:(NSString*)leaveType stime:(NSString*)stime etime:(NSString*)etime duration:(NSString*)duration due:(NSString*)due leaveImg:(NSString*)leaveImg auditPers:(NSString*)auditPers type:(NSString*)type token:(NSString*)token complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",createLeave];
    NSDictionary* param = @{@"userId":userId,@"leaveType":leaveType,@"stime":stime,@"etime":etime,@"duration":duration,@"due":due,@"leaveImg":leaveImg,@"auditPers":auditPers,@"type":type,@"token":token};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}







/**
 17.获取外出类型和请假类型+获取请假/外出次数
 
 @param type 0外出；1请假
 @param token 时间戳
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postFindTypeWithType:(NSString*)type token:(NSString*)token complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",findType];
    NSDictionary* param = @{@"type":type,@"token":token};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}





/**
 18.请假/外出记录
 
 @param userId 当前用户 id
 @param type 0外出；1请假
 @param token 时间戳
 @param pnum 页码
 @param num 数量
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postLeaveListWithUserId:(NSString*)userId type:(NSString*)type token:(NSString*)token num:(NSString*)num pnum:(NSString*)pnum complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",leaveList];
    NSDictionary* param = @{@"userId":userId,@"type":type,@"token":token,@"num":num,@"pnum":pnum};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}





/**
 20.审核列表
 
 @param userId 当前用户 id
 @param state 0待审核、1已审核
 @param content 搜索内容为空显示全部
 @param token 时间戳
 @param pnum 页码
 @param num 数量
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postAuditListWithUserId:(NSString*)userId state:(NSString*)state content:(NSString*)content num:(NSString*)num pnum:(NSString*)pnum token:(NSString*)token complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",auditList];
    NSDictionary* param = @{@"userId":userId,@"state":state,@"content":content,@"num":num,@"pnum":pnum,@"token":token};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}




/**
 21.审核详情
 
 @param userId 当前用户 id
 @param _id 列表Id
 @param token 时间戳
 @param type 0外出；1请假
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postDetailWithUserId:(NSString*)userId id:(NSString*)_id type:(NSString*)type token:(NSString*)token complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",auditDetail];
    NSDictionary* param = @{@"userId":userId,@"id":_id,@"type":type,@"token":token};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}





/**
 22.提交审核
 
 @param userId 当前用户 id
 @param _id 列表Id
 @param token 时间戳
 @param options 意见
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postAuditSaveUserId:(NSString*)userId id:(NSString*)_id options:(NSString*)options state:(NSString*)state token:(NSString*)token complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure {
    NSString* path = [NSString stringWithFormat:@"%@",auditSave];
    NSDictionary* param = @{@"userId":userId,@"id":_id,@"options":options,@"token":token,@"state":state};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}









/***********************************************************************销售过程接口*****客户customer!XXXX.action*******************************************************************/






/**
 1.客户列表
 @param userId 当前用户 id
 @param customerType 客户分类;空和不限就是全部
 @param followState 跟进状态;空和不限就是全部
 @param customerLevel 客户级别;空和不限就是全部
 @param searchName 模糊查询条件(名称、负责员工)
 @param token 时间戳
 @param num 每页数量
 @param pnum 页码
 @param cname 组织名
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postCustomerListWithUserId:(NSString*)userId customerType:(NSString*)customerType followState:(NSString*)followState customerLevel:(NSString*)customerLevel searchName:(NSString*)searchName token:(NSString*)token num:(NSString*)num pnum:(NSString*)pnum cname:(NSString*)cname complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",customerList];
    NSDictionary* param = @{@"userId":userId,@"customerType":customerType,@"followState":followState,@"customerLevel":customerLevel,@"searchName":searchName,@"token":token,@"num":num,@"pnum":pnum,@"cname":cname};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}






/**
 2.客户分类
 @param token 时间戳
 @param cname 组织名
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetCustomerInfoWithToken:(NSString*)token cname:(NSString*)cname complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getCustomerInfo];
    NSDictionary* param = @{@"token":token,@"cname":cname};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}






/**
 3.客户详情
 @param userId 用户 ID
 @param _id 客户 ID
 @param token 时间戳
 @param cname 组织名
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postCustomerDetailWithUserId:(NSString*)userId id:(NSString*)_id token:(NSString*)token cname:(NSString*)cname complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",customerDetail];
    NSDictionary* param = @{@"userId":userId,@"id":_id,@"token":token,@"cname":cname};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}






/**
 4.客户新增
 @param userId 用户 ID
 @param customerType 客户类型
 @param token 时间戳
 @param customerLevel 客户级别
 @param contact 联系方式
 @param customerName 客户名称
 @param des 备注
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postCreateCustomerWithUserId:(NSString*)userId id:(NSString*)_id contacts:(NSString*)contacts customerType:(NSString*)customerType token:(NSString*)token customerLevel:(NSString*)customerLevel contact:(NSString*)contact customerName:(NSString*)customerName des:(NSString*)des complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",createCustomer];
    NSDictionary* param = @{@"userId":userId,@"id":_id,@"contacts":contacts,@"customerType":customerType,@"token":token,@"customerLevel":customerLevel,@"contact":contact,@"customerName":customerName,@"des":des};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}






/**
 5.客户筛选(接口多余—直接在客户列表筛选，详情建客户 列表)
 @param userId 用户 ID
 @param customerName 客户名称
 @param token 时间戳
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postSearchCustomerWithUserId:(NSString*)userId customerName:(NSString*)customerName token:(NSString*)token complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",searchCustomer];
    NSDictionary* param = @{@"userId":userId,@"customerName":customerName,@"token":token};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}






/**
 6.客户删除
 @param userId 用户 ID
 @param cname 公司名
 @param token 时间戳
 @param _id 客户id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postDeleteCustomerWithUserId:(NSString*)userId cname:(NSString*)cname token:(NSString*)token id:(NSString*)_id complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",deleteCustomer];
    NSDictionary* param = @{@"userId":userId,@"cname":cname,@"token":token,@"id":_id};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}







/**
 获取token
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postCreateTokenWithUserId:(NSString*)userId cname:(NSString*)cname complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",createToken];
    NSDictionary* param = @{@"userId":userId,@"cname":cname};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}


/***********************************************************************销售过程接口*****用户信息*******************************************************************/



/**
 1.用户申请试用(调在线管理平台接口)
 @param userName 用户名
 @param companyName 企业名
 @param contactPhone 联系电话
 @param email 邮箱
 @param recommender 推荐人
 @param token 时间戳
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postApplyWithUserName:(NSString*)userName companyName:(NSString*)companyName contactPhone:(NSString*)contactPhone email:(NSString*)email recommender:(NSString*)recommender token:(NSString*)token complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",apply];
    NSDictionary* param = @{@"userName":userName,@"companyName":companyName,@"contactPhone":contactPhone,@"email":email,@"recommender":recommender,@"token":token};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];

    
}





/**
 2.用户登录
 @param userName 用户名
 @param cname 组织名
 @param password 密码
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postLoginWithUserName:(NSString*)userName cname:(NSString*)cname password:(NSString*)password complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",login];
    NSDictionary* param = @{@"userName":userName,@"cname":cname,@"password":password};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
    
}





/**
 3.用户资料修改
 @param userId 用户id
 @param nickName 姓名
 @param token 时间戳
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postInfoUpdateWithUserId:(NSString*)userId phone:(NSString*)phone nickName:(NSString*)nickName token:(NSString*)token complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",InfoUpdate];
    NSDictionary* param = @{@"userId":userId,@"phone":phone,@"nickName":nickName,@"token":token};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
    
}





/**
 3.1用户头像修改
 @param userId 用户id
 @param headImg 头像
 @param token 时间戳
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postInfoUpdateHeadImgWithUserId:(NSString*)userId headImg:(NSString*)headImg token:(NSString*)token complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure {
    NSString* path = [NSString stringWithFormat:@"%@",InfoUpdate];
    NSDictionary* param = @{@"userId":userId,@"headImg":headImg,@"token":token};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
    
}





/**
 4.修改密码
 @param userId 用户id
 @param oldPassword 原密码
 @param newPassword 新密码
 @param token 时间戳
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postChangePassWithUserId:(NSString*)userId oldPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword token:(NSString*)token complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",changePass];
    NSDictionary* param = @{@"userId":userId,@"oldPassword":oldPassword,@"newPassword":newPassword,@"token":token};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
    
}





/**
 5.获取签到次数（sign!XXX.action）
 @param userId 用户id
 @param token 时间戳
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetSignNumWithUserId:(NSString*)userId token:(NSString*)token complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@",getSignNum];
    NSDictionary* param = @{@"userId":userId,@"token":token};
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}










/***********************************************************************销售过程接口*****签到定位*******************************************************************/








/**
 登录
 
 @param userId 手机号/用户名
 @param password 密码
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postLoginWithUserid:(NSString*)userId password:(NSString*)password complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"requestIP"],LOGINURL];
    NSDictionary* param = @{@"userId":userId,@"password":password};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}


/**
 上传坐标
 
 @param userId userid
 @param lat 纬度
 @param lng 经度
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postPositionUpLoadWithUserid:(NSString*)userId lat:(NSString*)lat lng:(NSString*)lng complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"requestIP"],positionUpload];
    NSDictionary* param = @{@"userId":userId,@"lat":lat,@"lng":lng};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



/**
 获取轨迹
 
 @param userId userid
 @param date 日期
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetTrailWithUserid:(NSString*)userId date:(NSString*)date complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"requestIP"],getTrail];
    NSDictionary* param = @{@"userId":userId,@"date":date};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



/**
 通讯录列表
 
 @param departmentId 部门id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetStaffWithDepartmentId:(NSString*)departmentId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"requestIP"],getStaff];
    NSDictionary* param = @{@"departmentId":departmentId,@"userId":[MyController getuserId]};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



/**
 员工列表
 
 @param userId 自己id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetSubordinateWithUserId:(NSString*)userId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"requestIP"],getSubordinate];
    NSDictionary* param = @{@"userId":userId};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
    
}



/**
 签到信息
 
 @param userId 自己id
 @param time 日期
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGetSigninInfoWithUserId:(NSString*)userId time:(NSString*)time complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"requestIP"],getSigninInfo];
    NSDictionary* param = @{@"userId":userId,@"time":time};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}



/**
 签到
 
 @param userId 自己id
 @param type 考勤类型(1:wifi;2:定位;)
 @param lat 纬度
 @param lng 经度
 @param registerType 签到班次
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postSigninWithUserId:(NSString*)userId type:(NSString*)type lat:(NSString*)lat lng:(NSString*)lng registerType:(NSString*)registerType address:(NSString*)address complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"requestIP"],signin];
    NSDictionary* param = @{@"userId":userId,@"type":type,@"lat":lat,@"lng":lng,@"registerType":registerType,@"address":address};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}








/**
 外出签到
 
 @param signDate 签到日期
 @param address 地址
 @param customer 拜访对象
 @param userId 用户id
 @param remark 备注
 @param lon 经度
 @param lat 纬度
 @param img 图片
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postQIANDAOWithSignDate:(NSString*)signDate address:(NSString*)address location:(NSString*)location customer:(NSString*)customer userId:(NSString*)userId remark:(NSString*)remark lon:(NSString*)lon lat:(NSString*)lat img:(NSString*)img complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"requestIP"],WAICHUQIANDAO];
    NSDictionary* param = @{@"signDate":signDate,@"address":address,@"location":location,@"customer":customer,@"userId":userId,@"remark":remark,@"lon":lon,@"lat":lat,@"img":img};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}


/**
 团队足迹
 
 @param signDate 签到日期
 @param pnum 页码
 @param num 每页条数
 @param userId 用户id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postTUANDUIZIJIWithSignDate:(NSString*)signDate pnum:(NSString*)pnum num:(NSString*)num userId:(NSString*)userId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"requestIP"],TUANDUIZUJI];
    NSDictionary* param = @{@"signDate":signDate,@"pnum":pnum,@"num":num,@"userId":userId};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}


/**
 个人足迹
 
 @param signDate 签到日期
 @param pnum 页码
 @param num 每页条数
 @param userId 用户id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postGERENZUJIWithSignDate:(NSString*)signDate pnum:(NSString*)pnum num:(NSString*)num userId:(NSString*)userId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"requestIP"],GERENZUJI];
    NSDictionary* param = @{@"signDate":signDate,@"pnum":pnum,@"num":num,@"userId":userId};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}

/**
 足迹分布
 
 @param signDate 签到日期
 @param userId 被查看id
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postZUJIFENBUWithSignDate:(NSString*)signDate userId:(NSString*)userId complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"requestIP"],ZUJIFENBU];
    NSDictionary* param = @{@"signDate":signDate,@"userId":userId};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}




/**
 获取地址
 
 @param cname 公司名
 
 @param complate 请求完成
 @param failure 请求失败
 */
+(void)postAllRequest:(NSString*)cname complate:(HttpSuccessBlock)complate failure:(HttpFailureBlock)failure{
    NSString* path = allRequest;
    NSDictionary* param = @{@"cname":cname};
    
    [XRQRequestClient postWithOldURLString:path params:param WithSuccess:^(id responseObject) {
        !complate?:complate(responseObject);
    } WithFailure:^(NSError *error) {
        !failure?:failure(error);
    }];
}







@end
