//
//  HttpTaskData.h
//  evalapp
//
//  Created by Harin Li on 11/4/13.
//  Copyright (c) 2013 Harin Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"

@class TaskInfo;

typedef void (^OnSuccessBlock)(TaskInfo * taskInfo,id request);
typedef void (^OnFailedBlock)(TaskInfo * taskInfo,id request);
typedef void (^OnProccessingBlock)(TaskInfo * taskInfo,unsigned long long size,unsigned long long total);

typedef void (^OnBytesSentBlock)(TaskInfo * taskInfo,unsigned long long size,unsigned long long total);
typedef void (^OnBytesReceivedBlock)(TaskInfo * taskInfo,unsigned long long size,unsigned long long total);

@interface HttpTaskData : NSObject
AS_STATIC_PROPERTY_STRING(POST)
AS_STATIC_PROPERTY_STRING(GET)
AS_STATIC_PROPERTY_STRING(PUT)
AS_STATIC_PROPERTY_STRING(DELETE)
AS_STATIC_PROPERTY_STRING(HEAD)

// HTTP method to use (eg: GET / POST / PUT / DELETE / HEAD etc). Defaults to GET
@property(strong,nonatomic) NSString            *requestMethod;

@property(strong,nonatomic) NSString            * url;
@property(strong,nonatomic) NSDictionary        * urlParams;

@property(strong,nonatomic) NSDictionary        * httpParams;
@property(strong,nonatomic) NSDictionary        * httpHeader;

@property(strong,nonatomic) NSDictionary        * httpDataFilePaths;
@property(strong,nonatomic) id                    httpDatas;

@property(strong,nonatomic) NSObject            * additionData;

@property(strong,nonatomic) OnSuccessBlock          onSuccessBlock;
@property(strong,nonatomic) OnFailedBlock           onFailedBlock;
@property(strong,nonatomic) OnProccessingBlock      onProccessingBlock;
@property(strong,nonatomic) OnBytesSentBlock        onBytesSentBlock;
@property(strong,nonatomic) OnBytesReceivedBlock    onBytesReceivedBlock;

+(instancetype)fromDictionary:(NSDictionary*)httpTaskDic;
-(NSDictionary*)toDictionary;

@end
