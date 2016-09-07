//
//  AbstractRemoteService.m
//  mkt
//
//  Created by Harin Li on 6/9/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import "AbstractRemoteService.h"
#import "CoreService.h"
#import "TaskInfo.h"
#import "HttpTaskData.h"
#import "TaskCodeEnum.h"

#import "ASIHTTPRequest.h"
#import "HttpStatusEvent.h"
#import "BaseResponse.h"

@interface AbstractRemoteService ()
@property(strong,nonatomic) ON_RESULT_FAILED_BLOCK defaultFailedBlock;
@end

@implementation AbstractRemoteService
-(id)init
{
    self = [super init];
    if(self)
    {
        self.postLoadingMessage = YES;
        self.postSuccessMessage = NO;
        self.postFailedMessage = YES;
        [self setDefaultData];
        [self resetBlocks];
    }
    return self;
}

-(void)setDefaultData
{
    self.loadingMessage = @"加载中...";
    AbstractRemoteService * selfInBlock = self;
    self.defaultFailedBlock = ^(NSInteger errorCode,NSObject * error)
    {
        BaseResponse * baseResponse = (BaseResponse *)error;
        if(selfInBlock.postFailedMessage)
        {
            if(baseResponse.info==nil)
                baseResponse.info = @"服务器返回未知错误";
            selfInBlock.failedMessage = baseResponse.info;
        }
        return 0;
    };
    self.failedBlock = self.defaultFailedBlock;
    self.parseErrorBlock = ^(TaskInfo *taskInfo,id request,NSObject ** data)
    {
        ASIHTTPRequest * httpRequest = (ASIHTTPRequest *)request;
        NSError * httpError = httpRequest.error;
        NSInteger responseStatusCode = httpRequest.responseStatusCode;

        BaseResponse * baseResponse = [[BaseResponse alloc] init];
        if(httpError==nil && httpRequest.responseString!=nil)
        {
            baseResponse.httpCode = [NSString stringWithFormat:@"%d",responseStatusCode];
            baseResponse.info = [NSString stringWithFormat:@"网络不给力(%@)...",baseResponse.httpCode ];
        }
        else if(httpError!=nil)
        {
            baseResponse.info = [NSString stringWithFormat:@"网络不给力(%@)...",baseResponse.httpCode ];
        }
        else
        {
            baseResponse.errorCode = @"-1";
            baseResponse.info = @"未知错误";
        }
        *data = baseResponse;
        return -1;
    };
}

-(void)resetBlocks
{
}

-(void)execute
{
    [self postNotification:HttpStatusEvent.HTTP_EXECUTING withObject:@[@(self.postLoadingMessage),self.loadingMessage==nil?@"":self.loadingMessage]];
    self.executeBlock();
}

-(NSDictionary*)pageInfo
{
    return @{@"pageNo":_pageNo,@"pageSize":_pageSize};
}

-(TaskInfo*)executeWithUrl:(NSString*)url andHttpMethod:(NSString*)httpMethod AndUrlParams:(NSDictionary *)urlParams andPostParams:(NSDictionary*)postParams andToken:(NSDictionary*)token
{
    HttpTaskData * httpTaskData = [self configHttpWithURL:url andHttpMethod:httpMethod AndUrlParams:urlParams andPostParams:postParams andToken:token];
    
    TaskInfo * taskInfo = [[CoreService sharedInstance].taskManagerService createTaskInfoWithCode:TaskCodeEnum.HTTP_TASK_EXECUTOR andTaskDescription:@"Http Task" andTaskData:httpTaskData];
    
    [[CoreService sharedInstance].taskManagerService startTask:taskInfo];
    return taskInfo;
}

-(TaskInfo*)executeWithUrl:(NSString*)url andHttpMethod:(NSString*)httpMethod AndUrlParams:(NSDictionary *)urlParams andPostParams:(NSDictionary*)postParams andFiles:(NSDictionary*)files andToken:(NSDictionary*)token
{
    HttpTaskData * httpTaskData = [self configHttpWithURL:url andHttpMethod:httpMethod AndUrlParams:urlParams andPostParams:postParams andToken:token];
    httpTaskData.httpDataFilePaths = files;
    TaskInfo * taskInfo = [[CoreService sharedInstance].taskManagerService createTaskInfoWithCode:TaskCodeEnum.HTTP_TASK_EXECUTOR andTaskDescription:@"Http Task" andTaskData:httpTaskData];
    
    [[CoreService sharedInstance].taskManagerService startTask:taskInfo];
    return taskInfo;
}

-(TaskInfo*)executeWithHttpData:(HttpTaskData*)httpTaskData
{
    TaskInfo * taskInfo = [[CoreService sharedInstance].taskManagerService createTaskInfoWithCode:TaskCodeEnum.HTTP_TASK_EXECUTOR andTaskDescription:@"Http Task" andTaskData:httpTaskData];
    
    [[CoreService sharedInstance].taskManagerService startTask:taskInfo];
    return taskInfo;
}

-(HttpTaskData *)configHttpWithURL:(NSString*)url andHttpMethod:(NSString*)httpMethod AndUrlParams:(NSDictionary *)urlParams andPostParams:(NSDictionary*)postParams andToken:(NSDictionary*)token
{
    HttpTaskData *taskData = [[HttpTaskData alloc] init];
    
    taskData.url = url;
    taskData.requestMethod = httpMethod;
    taskData.urlParams = urlParams;
    taskData.httpParams = postParams;
    
    return [self setHttpTaskDataBlock:taskData];
}

-(HttpTaskData *)setHttpTaskDataBlock:(HttpTaskData *)httpTaskData
{
    void (^notificationBlock)(NSInteger retCode,NSObject * retData) = ^ (NSInteger retCode,NSObject * retData)
    {
        if(retCode==0)
        {
            self.successBlock(retData);
            [self postNotification:HttpStatusEvent.HTTP_SUCCESS withObject:@[@(self.postSuccessMessage),self.successMessage==nil?@"":self.successMessage]];
        }
        else
        {
            self.failedBlock(retCode,retData);
            [self postNotification:HttpStatusEvent.HTTP_FAILED withObject:@[@(self.postFailedMessage),self.failedMessage==nil?@"":self.failedMessage,@(self.postFailedAutoMessage)]];
        }
    };
    OnFailedBlock onHttpFailedBlock = ^(TaskInfo *taskInfo, id request) {
        NSObject * retData;
        NSInteger retCode = self.parseErrorBlock(taskInfo,request,&retData);
        notificationBlock(retCode,retData);
    };
    OnSuccessBlock onHttpSuccessBlock = ^(TaskInfo *taskInfo,id request){
        NSObject * retData;
        NSInteger responseStatusCode = ((ASIHTTPRequest*)request).responseStatusCode;
        if(responseStatusCode==200)
        {
            NSInteger retCode = self.parseBlock(taskInfo,request,&retData);
            notificationBlock(retCode,retData);
        }
        else
        {
            onHttpFailedBlock(taskInfo,request);
        }
    };
    [httpTaskData setOnFailedBlock:onHttpFailedBlock];
    [httpTaskData setOnSuccessBlock:onHttpSuccessBlock];
    
    [httpTaskData setOnBytesSentBlock:^(TaskInfo *taskInfo, unsigned long long size, unsigned long long total) {
        
        taskInfo.taskProcessed += (NSInteger)size;
        taskInfo.taskTotal = (NSInteger)total;
        taskInfo.taskStatus = TaskStatusProcessing;
        NSLog(@"Uploading --- size: %lld, total size: %lld",size, total);
    }];
    [httpTaskData setOnBytesReceivedBlock:^(TaskInfo *taskInfo, unsigned long long size, unsigned long long total) {
        
        taskInfo.taskProcessed += (NSInteger)size;
        taskInfo.taskTotal = (NSInteger)total;
        taskInfo.taskStatus = TaskStatusProcessing;
        NSLog(@"Downloading --- size: %lld, total size: %lld",size, total);
    }];
    
    return httpTaskData;
}

@end
