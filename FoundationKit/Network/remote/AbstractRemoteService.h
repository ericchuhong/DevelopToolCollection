//
//  AbstractRemoteService.h
//  mkt
//
//  Created by Harin Li on 6/9/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRemoteService.h"
#import "HttpTaskData.h"
#import "TaskInfo.h"
#import "SKCModel.h"

@interface AbstractRemoteService : NSObject <IRemoteService>

@property(nonatomic) BOOL postLoadingMessage;
@property(nonatomic) BOOL postSuccessMessage;
@property(nonatomic) BOOL postFailedMessage;
@property(nonatomic) BOOL postFailedAutoMessage;
@property(nonatomic,strong) NSString * loadingMessage;
@property(nonatomic,strong) NSString * failedMessage;
@property(nonatomic,strong) NSString * successMessage;

@property(nonatomic,strong) NSString * subUrl;
@property(nonatomic,strong) NSDictionary * params;
@property(strong,nonatomic) ON_EXECUTE_BLOCK executeBlock;
@property(strong,nonatomic) ON_RESULT_PARSE_BLOCK parseErrorBlock;
@property(strong,nonatomic) ON_RESULT_PARSE_BLOCK parseBlock;
@property(strong,nonatomic) ON_RESULT_SUCCESS_BLOCK successBlock;
@property(strong,nonatomic) ON_RESULT_FAILED_BLOCK failedBlock;

@property(strong,readonly) ON_RESULT_FAILED_BLOCK defaultFailedBlock;
@property(strong,nonatomic) ON_EXECUTE_BLOCK defaultParseBlock;

-(void)resetBlocks;

@property(nonatomic,strong) NSString * pageNo;
@property(nonatomic,strong) NSString * pageSize;
@property(nonatomic,readonly) NSDictionary * pageInfo;

-(HttpTaskData *)configHttpWithURL:(NSString*)url andHttpMethod:(NSString*)httpMethod AndUrlParams:(NSDictionary *)urlParams andPostParams:(NSDictionary*)postParams andToken:(NSDictionary*)token;
-(HttpTaskData *)setHttpTaskDataBlock:(HttpTaskData *)httpTaskData;

-(TaskInfo*)executeWithHttpData:(HttpTaskData*)httpTaskData;
-(TaskInfo*)executeWithUrl:(NSString*)url andHttpMethod:(NSString*)httpMethod AndUrlParams:(NSDictionary *)urlParams andPostParams:(NSDictionary*)postParams andToken:(NSDictionary*)token;
-(TaskInfo*)executeWithUrl:(NSString*)url andHttpMethod:(NSString*)httpMethod AndUrlParams:(NSDictionary *)urlParams andPostParams:(NSDictionary*)postParams andFiles:(NSDictionary*)files andToken:(NSDictionary*)token;
@end
