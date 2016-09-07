//
//  HttpTaskData.m
//  evalapp
//
//  Created by Harin Li on 11/4/13.
//  Copyright (c) 2013 Harin Li. All rights reserved.
//

#import "HttpTaskData.h"


@implementation HttpTaskData

DEF_STATIC_PROPERTY_STRING(GET,@"GET");
DEF_STATIC_PROPERTY_STRING(POST,@"POST");
DEF_STATIC_PROPERTY_STRING(PUT,@"PUT");
DEF_STATIC_PROPERTY_STRING(DELETE,@"DELETE");
DEF_STATIC_PROPERTY_STRING(HEAD,@"HEAD");

+(instancetype)fromDictionary:(NSDictionary*)httpTaskDic
{
    HttpTaskData * httpTaskData = [[HttpTaskData alloc] init];
    httpTaskData.requestMethod = httpTaskDic[@"requestMethod"];
    httpTaskData.url = httpTaskDic[@"url"];
    httpTaskData.urlParams = httpTaskDic[@"urlParams"];
    httpTaskData.httpParams = httpTaskDic[@"httpParams"];
    httpTaskData.httpHeader = httpTaskDic[@"httpHeader"];
    httpTaskData.httpDataFilePaths = httpTaskDic[@"httpDataFilePaths"];
    httpTaskData.httpDatas = httpTaskDic[@"httpDatas"];
    httpTaskData.additionData = httpTaskDic[@"additionData"];
    return httpTaskData;
}

-(NSDictionary*)toDictionary
{
    NSMutableDictionary * httpTaskDic = [[NSMutableDictionary alloc] init];
    if (self.requestMethod)
        httpTaskDic[@"requestMethod"] = self.requestMethod;
    if (self.url)
        httpTaskDic[@"url"] = self.url;
    if (self.urlParams)
        httpTaskDic[@"urlParams"] = self.urlParams;
    if (self.httpParams)
        httpTaskDic[@"httpParams"] = self.httpParams;
    if (self.httpHeader)
        httpTaskDic[@"httpHeader"] = self.httpHeader;
    if (self.httpDataFilePaths)
        httpTaskDic[@"httpDataFilePaths"] = self.httpDataFilePaths;
    if (self.httpDatas)
        httpTaskDic[@"httpDatas"] = self.httpDatas;
    if (self.additionData)
        httpTaskDic[@"additionData"] = self.additionData;
    return httpTaskDic;
}
@end
