//
//  ModuleFactory.h
//  mkt
//
//  Created by Harin Li on 6/12/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModulePagesInfo.h"

@class ModuleVC;
@interface ModuleFactory : NSObject

+(ModulePagesInfo*)createModuleInfoByName:(NSString*)name andModuleVC:(ModuleVC*)moduleVC andData:(NSObject*)data;

+(ModulePagesInfo*)createModuleInfoByName:(NSString*)name andModuleVC:(ModuleVC*)moduleVC andData:(NSObject*)data;

@end
