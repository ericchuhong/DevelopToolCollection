//
//  HttpTaskExecutor.m
//  DailyPlanner
//
//  Created by Tony on 14-4-18.
//  Copyright (c) 2014年 TTS. All rights reserved.
//

#import "HttpTaskExecutor.h"
#import "TaskCodeEnum.h"
#import "HttpTaskData.H"
#import "TaskInfo.h"
#import "HttpStatusEvent.h"

#define FILE_NAME @"file"
#define TASK_ID_PREFIX @"TASK"
#define ZERO 0

@implementation HttpTaskExecutor


+(id<ITaskExecutor>) createTaskExecutor
{
    return [[HttpTaskExecutor alloc] init];
}

-(TaskInfo*)createTaskInfoWithCode:(NSString*)code andTaskDescription:(NSString*)taskDescription andTaskData:(id)taskData
{
    TaskInfo *taskInfo = [[TaskInfo alloc] init];
    taskInfo.taskKey = TTSGenID(TASK_ID_PREFIX);
    taskInfo.taskType = TaskTypeNone;
    taskInfo.taskCode = code;
    taskInfo.taskDescription = taskDescription;
    taskInfo.taskStatus = TaskStatusPending;
    taskInfo.taskProcessed = ZERO;
    taskInfo.taskTotal = ZERO;
    taskInfo.taskData = taskData;//taskData = HttpTaskData
    
    [self configHttpParams:taskInfo];
    
    return taskInfo;
}

-(void)configHttpParams:(TaskInfo *)taskInfo
{
    HttpTaskData * httpTaskData = (HttpTaskData *)taskInfo.taskData;
    
    //1 create URL
    NSString * urlString = httpTaskData.url;
    NSString * urlParams = [NSString queryStringFromDictionary:httpTaskData.urlParams];
    if(urlParams!=nil && urlParams.length)
    {
        urlString = [urlString stringByAppendingFormat:@"?%@",urlParams ];
    }
    else
    {
        //urlParams = nil
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    ASSERT(httpTaskData.requestMethod!=nil);
    
    //2 create request base on the request method
    ASIHTTPRequest *request = [self createHttpRequestByTaskInfo:taskInfo withHttpTaskData:httpTaskData andURL:url].request;
    request.timeOutSeconds = 60;
    
    //3. add request header
    NSDictionary *httpHeader = httpTaskData.httpHeader;
    
    if(httpHeader != nil)
    {
        for (NSString *key in httpHeader.allKeys) {
            [request addRequestHeader:key value:httpHeader[key]];
        }
    }
    else
    {
        [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    }
    
    [request setTimeOutSeconds:120.0];
    
    [self setHttpRequestBlocks:request withTaskInfo:taskInfo];
}

-(TaskInfo *)createHttpRequestByTaskInfo:(TaskInfo *)taskInfo withHttpTaskData:(HttpTaskData *)httpTaskData andURL:(NSURL *)url
{
    //Upload Perform and UserLog,Download Alignment request
    if([httpTaskData.requestMethod isEqualToString:httpTaskData.POST])
    {
        //create ASIFormDataRequest
        ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:url];
        request.defaultResponseEncoding = NSUTF8StringEncoding;
        [request setRequestMethod:httpTaskData.POST];
        
        //add httpParams as postData
        NSString * jsonString = [httpTaskData.httpParams JSONString];
        if (nil != jsonString)
        {
            [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        }
                
        //Upload Perform,UserLog Zip File
        for (NSString * fileName in httpTaskData.httpDataFilePaths.allKeys) {
            [request addFile:httpTaskData.httpDataFilePaths[fileName] forKey:fileName];
        }
        
        taskInfo.request = request;
    }
    else if([httpTaskData.requestMethod isEqualToString:httpTaskData.GET])
    {
        //create ASIFormDataRequest
        ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
        request.defaultResponseEncoding = NSUTF8StringEncoding;
        
        [request setRequestMethod:httpTaskData.GET];
        taskInfo.request = request;
    }
    else if ([httpTaskData.requestMethod isEqualToString:httpTaskData.PUT])
    {
        
    }
    else if ([httpTaskData.requestMethod isEqualToString:httpTaskData.DELETE])
    {
        
    }
    else if ([httpTaskData.requestMethod isEqualToString:httpTaskData.HEAD])
    {
        
    }
    else
    {
        
    }
    return taskInfo;
}

-(void)setHttpRequestBlocks:(ASIHTTPRequest*)request withTaskInfo:(TaskInfo *)taskInfo
{
    __block ASIHTTPRequest * blockRequest = request;
    __block HttpTaskData * httpTaskData = (HttpTaskData *)taskInfo.taskData;
    
    [request setCompletionBlock:^{
        taskInfo.taskStatus = TaskStatusSuccess;
        httpTaskData.onSuccessBlock(taskInfo,blockRequest);
    }];
    
    [request setFailedBlock:^{
        taskInfo.taskStatus = TaskStatusFailed;
        httpTaskData.onFailedBlock(taskInfo,blockRequest);
    }];
    
    [request setBytesSentBlock:^(unsigned long long size, unsigned long long total) {
        taskInfo.taskStatus = TaskStatusProcessing;
        httpTaskData.onBytesSentBlock(taskInfo,size,total);
    }];
    [request setBytesReceivedBlock:^(unsigned long long size, unsigned long long total) {
        taskInfo.taskStatus = TaskStatusProcessing;
        httpTaskData.onBytesReceivedBlock(taskInfo,size,total);
    }];
    
}

-(NSArray*) getTaskCodes
{
    return @[TaskCodeEnum.HTTP_TASK_EXECUTOR];
}

-(void) startTask:(TaskInfo*)taskInfo
{
    if(taskInfo.request!=nil)
    {
        taskInfo.taskStatus = TaskStatusStarting;
        @try {
            [taskInfo.request startAsynchronous];
            NSError * error = taskInfo.request.error;
        }
        @catch (NSException *exception) {
            taskInfo.taskStatus = TaskStatusFailed;
            HttpTaskData * httpTaskData = taskInfo.taskData;
            httpTaskData.onFailedBlock(taskInfo,taskInfo.request);
        }
    }
}

-(void) stopTask:(TaskInfo*)taskInfo
{
    if(taskInfo.request!=nil)
    {
        taskInfo.taskStatus = TaskStatusCanceled;
        [taskInfo.request cancel];
    }
}

-(void) pauseTask:(TaskInfo*)taskInfo
{
    assert(NO);
}

-(void) resumeTask:(TaskInfo*)taskInfo
{
    assert(NO);
}

@end
