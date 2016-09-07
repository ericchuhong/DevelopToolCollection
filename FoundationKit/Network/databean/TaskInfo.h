//
//  TaskInfo.h
//  mkt
//
//  Created by Harin Li on 6/16/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum TaskStatus{
    TaskStatusPending,
    TaskStatusStarting,
    TaskStatusProcessing,
    TaskStatusSuccess,
    TaskStatusCanceled,
    TaskStatusStartFailed,
    TaskStatusFailed
} TaskStatus;

typedef enum TaskType{
    TaskTypeTimer,
    TaskTypeDeque,
    TaskTypeSingle,
    TaskTypeNone
} TaskType;

@class ASIHTTPRequest;

@interface TaskInfo : NSObject

//task base info
@property(nonatomic) TaskType taskType;
@property(nonatomic) NSString * taskKey;
@property(nonatomic) NSString * taskCode;
@property(nonatomic) NSString * taskDescription;

//status info
@property(nonatomic) TaskStatus taskStatus;
@property(nonatomic) NSInteger taskProcessed;
@property(nonatomic) NSInteger taskTotal;

//task data
@property(strong,nonatomic) id taskData;

//temp
@property (strong,nonatomic) ASIHTTPRequest * request;

@end
