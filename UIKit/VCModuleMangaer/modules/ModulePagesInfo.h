//
//  ModuleInfo.h
//  mkt
//
//  Created by Harin Li on 6/12/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"
#import "ModulePageInfo.h"
#import "ModuleVC.h"

@class ModulePagesInfo;

typedef void (^ModuleCloseCallback)(NSObject*data);
typedef void (^ModuleReAppearCallback)(ModulePagesInfo * modulePages, NSObject*data);

@interface ModulePagesInfo : NSObject

+(ModulePagesInfo*)modulePagesInfo:(ModuleVC*)moduleVC andData:(NSObject*)data;

-(instancetype)initWithData:(NSMutableDictionary*)moduleData andPages:(NSDictionary*)modulePageInfos andFirstPage:(ModulePageInfo*)firstPageInfo;

-(ModulePageInfo*)getFirstPage;
-(ModulePageInfo*)getCurrentPage;
-(ModulePageInfo*)getPage:(NSString*)pageName;

@property(nonatomic,strong) NSString * moduleName;
@property(nonatomic,strong) ModuleCloseCallback finishCloseCallback;
@property(nonatomic,strong) ModuleReAppearCallback reAppearCloseCallback;

@end
