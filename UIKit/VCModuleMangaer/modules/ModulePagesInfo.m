//
//  ModuleInfo.m
//  mkt
//
//  Created by Harin Li on 6/12/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import "ModulePagesInfo.h"


@interface ModulePagesInfo ()
@property(nonatomic,strong) NSMutableDictionary * moduleData;
@property(nonatomic,strong) NSDictionary * modulePageInfos;
@property(nonatomic,strong) ModulePageInfo * firstPageInfo;

@property(nonatomic,strong) ModulePageInfo * currentPageInfo;

@end

@implementation ModulePagesInfo

+(ModulePagesInfo*)modulePagesInfo:(ModuleVC*)moduleVC andData:(NSObject*)data
{
    return nil;
}

-(instancetype)initWithData:(NSMutableDictionary*)moduleData andPages:(NSDictionary*)modulePageInfos andFirstPage:(ModulePageInfo*)firstPageInfo
{
    self = [super init];
    if(self)
    {
        self.moduleData = moduleData;
        self.modulePageInfos = modulePageInfos;
        self.firstPageInfo = firstPageInfo;
    }
    return self;
}

-(ModulePageInfo*)getFirstPage
{
    _currentPageInfo = _firstPageInfo;
    return _currentPageInfo;
}

-(ModulePageInfo*)getCurrentPage
{
    return _currentPageInfo;
}

-(ModulePageInfo*)getPage:(NSString*)pageName
{
    _currentPageInfo = _modulePageInfos[pageName];
    return _currentPageInfo;
}


@end
