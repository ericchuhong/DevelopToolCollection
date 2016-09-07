//
//  TaskManager.h
//  evalapp
//
//  Created by Harin Li on 11/4/13.
//  Copyright (c) 2013 Harin Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"
#import "ITaskManageService.h"
#import "TaskInfo.h"

@interface TaskManageServiceImpl : NSObject <ITaskManageService>
AS_SINGLETON(TaskManageServiceImpl)
@end
