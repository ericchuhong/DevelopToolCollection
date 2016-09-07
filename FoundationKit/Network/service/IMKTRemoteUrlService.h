//
//  IMKTRemoteUrlService.h
//  mkt
//
//  Created by Harin Li on 6/18/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IMKTRemoteUrlService <NSObject>

-(NSString*)getCustomerDetailUrlById:(NSString*)customerId;
-(NSString*)getHomeChartUrl;
-(NSString*)getHomeActivityUrl;

-(NSString*)getCustomerCreditDetailUrlByCustomerId:(NSString*)customerId andProductId:(NSString*)productId andTypeId:(NSString*)typeId;
-(NSString*)getCustomerExchangeDetailUrlByCustomerId:(NSString*)customerId andProductId:(NSString*)productId andTypeId:(NSString*)typeId;
-(NSString*)getCustomerActivityDetailUrlByCustomerId:(NSString*)customerId andActId:(NSString*)actId;
-(NSString*)getCustomerFTFDetailUrlByCustomerId:(NSString*)customerId andActId:(NSString*)actId andType:(NSString*)type;

-(NSString*)getQueryNewCompleteDetailBySceneId:(NSString*)sceneId;
-(NSString*)getQueryGoodsLossDetailBySceneId:(NSString*)sceneId;
-(NSString*)getQueryGoodsDamageDetailBySceneId:(NSString*)sceneId;
@end
