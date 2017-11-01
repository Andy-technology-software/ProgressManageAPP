//
//  requestURL.h
//  WhereAreYou
//
//  Created by lingnet on 2017/7/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#ifndef requestURL_h
#define requestURL_h
//#define HEADER1 @"http://192.168.1.113:8080/lpms/app/"
#define HEADER1 @"http://192.168.10.29:8080/lpms/app/"
/********************************************************************************销售过程接口**********************************************************************************************/

//12.日报
#define createDaily HEADER1"daily!createDaily.action"



//13.获取下级人员
#define getNextPers HEADER1"daily!getNextPers.action"



//14.日报列表
#define dailyList HEADER1"daily!dailyList.action"



//15.定位(获取某个时间、某个人的轨迹)
#define getTrack HEADER1"location!getTrack.action"



//16.上传经纬度
#define upLocation HEADER1"location!upLocation.action"



//15.请假/外出(leave!XXXX.action 获取请假/外出次数)
#define getLeaveNum HEADER1"leave!getLeaveNum.action"



//16.请假/外出
#define createLeave HEADER1"leave!createLeave.action"



//17.获取外出类型和请假类型+获取请假/外出次数
#define findType HEADER1"leave!findType.action"



//18.请假/外出记录
#define leaveList HEADER1"leave!leaveList.action"



//19.外出详情、请假详情同审核详情
//#define leaveList HEADER1"leave!leaveList.action"



//20.审核列表
#define auditList HEADER1"leave!auditList.action"



//21.审核详情
#define auditDetail HEADER1"leave!detail.action"



//22  交审核
#define auditSave HEADER1"leave!auditSave.action"


/***********************************************************************销售过程接口*****客户customer!XXXX.action*******************************************************************/



//1.客户列表
#define customerList HEADER1"customer!list.action"



//2.客户分类
#define getCustomerInfo HEADER1"customer!getCustomerInfo.action"


//3.客户详情
#define customerDetail HEADER1"customer!customerDetail.action"


//4.客户新增
#define createCustomer HEADER1"customer!createCustomer.action"


//5.客户筛选(接口多余—直接在客户列表筛选，详情建客户 列表)
#define searchCustomer HEADER1"customer!searchCustomer.action"


//6.客户删除
#define deleteCustomer HEADER1"customer!deleteCustomer.action"




/********************************************************************************销售过程接口******用户信息****************************************************************************************/


//1.用户申请试用(调在线管理平台接口)
#define apply HEADER1"user_app!apply.action"


//2.用户登录
#define login HEADER1"user_app!login.action"


//3.用户资料修改
#define InfoUpdate HEADER1"user_app!infoUpdate.action"


//4.修改密码
#define changePass HEADER1"user_app!changePass.action"


//5.获取签到次数(sign!XXX.action)
#define getSignNum HEADER1"sign!getSignNum.action"


//获取Token
#define createToken HEADER1"token!createToken.action"





/********************************************************************************销售过程接口******签到定位****************************************************************************************/


//登陆
#define LOGINURL @"login!login.action"

//上传坐标
#define positionUpload @"location!positionUpload.action"

//获取轨迹
#define getTrail @"location!getTrail.action"

//通讯录
#define getStaff @"communication!getStaff.action"

//员工列表
#define getSubordinate @"person!getSubordinate.action"

//签到
#define signin @"attendance!signin.action"

//签到信息
#define getSigninInfo @"attendance!getSigninInfo.action"

//通知信息
#define Notice @"dynamic!notice.action"

//个人信息
#define PersonInfo @"person!personalInfo.action"

//设置定位开启关闭
#define SetLocate @"person!setLocationState.action"

//修改密码
#define ChangePW @"person!modifyPassword.action"

//用户反馈
#define FeedBack @"common!feedback.action"

//外出签到
#define WAICHUQIANDAO @"egression!sign.action"


//团队足迹
#define TUANDUIZUJI @"egression!teamFootprint.action"


//个人足迹
#define GERENZUJI @"egression!myFootprint.action"

//足迹分布
#define ZUJIFENBU @"egression!printDistributed.action"

//请求地址
#define allRequest @"http://lingatte.china-saas.com:8081/oa/compnay!findCompany.action"




#endif /* requestURL_h */
