//
//  TaskManager.m
//  evalapp
//
//  Created by Harin Li on 11/4/13.
//  Copyright (c) 2013 Harin Li. All rights reserved.
//

#import "TaskManageServiceImpl.h"
#import "HttpTaskExecutor.h"


@implementation TaskManageServiceImpl{
    NSMutableDictionary * _taskCodeToTaskExecutor;
    TaskInfo * _taskInfo;
}
DEF_SINGLETON(TaskManageServiceImpl)

-(id)init
{
    self = [super init];
    if(self)
    {
        _taskCodeToTaskExecutor = [NSMutableDictionary dictionary];
        [self registerTaskExecutorClass:[HttpTaskExecutor class]];
    }
    return self;
}

-(void)registerTaskExecutor:(id<ITaskExecutor>) taskExecutor
{
    NSArray * taskCodes = [taskExecutor getTaskCodes];
    for (NSString * taskCode in taskCodes) {
        _taskCodeToTaskExecutor[taskCode] = taskExecutor;
    }
}

-(void)registerTaskExecutorClass:(Class) taskExecutorClass
{
    if([taskExecutorClass conformsToProtocol:@protocol(ITaskExecutor) ])
    {
        id<ITaskExecutor> taskExecutor = (id<ITaskExecutor>)[taskExecutorClass createTaskExecutor];
        [self registerTaskExecutor:taskExecutor];
    }
    else
    {
        assert(NO);
    }
    
}

-(TaskInfo*)createTaskInfoWithCode:(NSString*)code andTaskDescription:(NSString*)taskDescription andTaskData:(id)taskData
{
    id<ITaskExecutor> taskExecutor = _taskCodeToTaskExecutor[code];
    return [taskExecutor createTaskInfoWithCode:code andTaskDescription:taskDescription andTaskData:taskData];
}

-(void) startTask:(TaskInfo*)taskInfo
{
    //todo: for now the task manager only support one task execting
    //       we need to make it can support diff task has diff strategy
    //       we also need to make the task can design its own stratgy
    if(_taskInfo && (_taskInfo.taskStatus==TaskStatusStarting || _taskInfo.taskStatus==TaskStatusProcessing) )
    {
        id<ITaskExecutor> taskExecutor = _taskCodeToTaskExecutor[_taskInfo.taskCode];
        [taskExecutor stopTask:_taskInfo];
    }
    id<ITaskExecutor> taskExecutor = _taskCodeToTaskExecutor[taskInfo.taskCode];
    [taskExecutor startTask:taskInfo];
}

-(void) stopTask:(TaskInfo*)taskInfo
{
    id<ITaskExecutor> taskExecutor = _taskCodeToTaskExecutor[taskInfo.taskCode];
    [taskExecutor stopTask:taskInfo];
}

-(void) pauseTask:(TaskInfo*)taskInfo
{
    id<ITaskExecutor> taskExecutor = _taskCodeToTaskExecutor[taskInfo.taskCode];
    [taskExecutor pauseTask:taskInfo];
}

-(void) resumeTask:(TaskInfo*)taskInfo
{
    id<ITaskExecutor> taskExecutor = _taskCodeToTaskExecutor[taskInfo.taskCode];
    [taskExecutor resumeTask:taskInfo];
}

@end
