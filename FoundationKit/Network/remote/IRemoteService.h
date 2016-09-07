//
//  IRemoteService.h
//  mkt
//
//  Created by Harin Li on 6/9/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TaskInfo;


typedef int(^ON_EXECUTE_BLOCK)();
typedef int(^ON_RESULT_PARSE_BLOCK)(TaskInfo *taskInfo,id request,NSObject ** data);
typedef int(^ON_RESULT_SUCCESS_BLOCK)(NSObject * data);
typedef int(^ON_RESULT_FAILED_BLOCK)(NSInteger errorCode,NSObject * error);
//typedef int(^ON_RESULT_FAILED_BLOCK)(NSInteger errorCode,NSObject * error);


@protocol IRemoteService <NSObject>

@property(nonatomic) BOOL postLoadingMessage;
@property(nonatomic) BOOL postSuccessMessage;
@property(nonatomic) BOOL postFailedMessage;
@property(nonatomic) BOOL postFailedAutoMessage;

@property(nonatomic,strong) NSString * loadingMessage;
@property(nonatomic,strong) NSString * failedMessage;
@property(nonatomic,strong) NSString * successMessage;

@property(strong,nonatomic) ON_EXECUTE_BLOCK executeBlock;
@property(strong,nonatomic) ON_RESULT_PARSE_BLOCK parseBlock;
@property(strong,nonatomic) ON_RESULT_PARSE_BLOCK parseErrorBlock;
@property(strong,nonatomic) ON_RESULT_SUCCESS_BLOCK successBlock;
@property(strong,nonatomic) ON_RESULT_FAILED_BLOCK failedBlock;

@property(strong,readonly) ON_RESULT_FAILED_BLOCK defaultFailedBlock;
@property(strong,nonatomic) ON_EXECUTE_BLOCK defaultParseBlock;

-(void)resetBlocks;
-(void)execute;

@end
