//
//  ITaskManageService.h
//  evalapp
//
//  Created by Harin Li on 11/4/13.
//  Copyright (c) 2013 Harin Li. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TaskInfo;


@protocol ITaskExecutor <NSObject>

+(id<ITaskExecutor>) createTaskExecutor;

-(TaskInfo*)createTaskInfoWithCode:(NSString*)code andTaskDescription:(NSString*)taskDescription andTaskData:(id)taskData;
-(NSArray*) getTaskCodes;

-(void) startTask:(TaskInfo*)taskInfo;
-(void) stopTask:(TaskInfo*)taskInfo;
-(void) pauseTask:(TaskInfo*)taskInfo;
-(void) resumeTask:(TaskInfo*)taskInfo;

@end


@protocol ITaskManageService <NSObject>

-(void)registerTaskExecutor:(id<ITaskExecutor>) taskExecutor;
-(void)registerTaskExecutorClass:(Class) taskExecutorClass;

-(TaskInfo*)createTaskInfoWithCode:(NSString*)code andTaskDescription:(NSString*)taskDescription andTaskData:(id)taskData;

-(void) startTask:(TaskInfo*)taskInfo;
-(void) stopTask:(TaskInfo*)taskInfo;
-(void) pauseTask:(TaskInfo*)taskInfo;
-(void) resumeTask:(TaskInfo*)taskInfo;

@end
