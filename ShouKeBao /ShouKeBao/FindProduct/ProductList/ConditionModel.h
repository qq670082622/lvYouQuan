//
//  ConditionModel.h
//  ShouKeBao
//
//  Created by 吴铭 on 15/3/24.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConditionModel : NSObject
//“ ProductCondition”:{
//    “ ProductBrowseTag “:[{}````{}],
//    “GoDate”:[{“Text”:””,”Value”:””}],
//    “ ScheduleDays “:[{“Text”:”1天”,”Value”:”1"},{},{},{}````];
//        “StartCity”:[{},{}````],
//        “ProductThemeTag”:[{“Text”:,”Value”:”"},{}```],
//            “Supplier”:[{},{},{}````];
//            “ HotelStandard :"[{},{}```]”,
//            “ CruiseShipCompany “:”[{},{},{}````]"
//        }
@property (nonatomic,copy) NSString *ProductBrowseTag;//游览线路ID
@property (nonatomic,copy) NSString *GoDate;//出发日期
@property (nonatomic,copy) NSString *ScheduleDays;//行程时间
@property (nonatomic,copy) NSString *StartCity;//出发城市
@property (nonatomic,copy) NSString *ProductThemeTag;//主题推荐iD
@property (nonatomic,copy) NSString *Supplier;//供应商ID
@property (nonatomic,copy) NSString *HotelStandard;//酒店类型
@property (nonatomic,copy) NSString *TrafficType;//出行方式
@property (nonatomic,copy) NSString *CruiseShipCompany;//油轮公司
@property (nonatomic,copy) NSString *ProductLevel;//线路等级
//IsPersonBackPrice ture 是否加返
//IsComfirmStockNow bool 及时确认
//MinPrice MaxPrice 价格区间 nsnumber
@end
