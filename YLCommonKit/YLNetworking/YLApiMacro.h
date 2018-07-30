//
//  YLApiMacro.h
//  YLCommonKit
//
//  Created by xyanl on 2018/7/18.
//  Copyright © 2018年 xyanl. All rights reserved.
//  请求地址

#ifndef YLApiMacro_h
#define YLApiMacro_h

//----------生产发布信息------------ 20180605v2.4.0 --------------------
/****************************************************************************************************
 
 * 生产环境打包流程
 1、核对生产环境地址                                        ---√
 2、核对VendorMacro文件中第三方配置是否是生产参数               ---√
 3、检查DEBUG_MODE开关是否关闭                              ---√
 4、搜索-testdata-删除测试数据                              ---√
 5、核对打包版本号(info.plist & LaunchScreen.xib) x.x.x     ---√
 6、关闭僵尸对象选项等                                       ---√
 7、打开防崩溃                                             ---√
 8、检查APP_SC_SERVER_API宏的地址是否和生产地址相同(请复制地址内容对比)，相同:正确，不同:错误             ---√
 9、如果用LoanInternalPlus.sh脚本自动打包，需要修改脚本中的updateDescription描述与地址环境一致         ---√
 *****************************************************************************************************/

//----------生产环境----------
/* 与生产环境对比地址 - 不要注销!!! (注意:此地址必须于生产地址保持一致！！！用于判断是否是生产环境地址) */
//#define APP_SC_SERVER_API                 @"https://dkapp.jieyuechina.com/fintech-LNAE/"


//----------测试环境------------
// 联调地址
/************** 行销地址 *************/
#define APP_NMKP_SERVER_API               @"http://172.18.100.67:8085/jy-nmkp/"


#pragma mark - ----------行销相关----------
/**
 * 拜访模块
 */
// 添加拜访记录
#define NMKP_API_POST_ADDVISITRECORDS             APP_NMKP_SERVER_API@"saleApp/customer/addVisitRecords/v1/"

#endif /* YLApiMacro_h */
