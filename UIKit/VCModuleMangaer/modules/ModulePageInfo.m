//
//  ModulePageInfo.m
//  mkt
//
//  Created by Harin Li on 6/13/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import "ModulePageInfo.h"

@implementation ModulePageInfo

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self.xOffset = 0;
    }
    return self;
}

-(ModulePageInfo*)modulePageInfoWithDictionary:(NSDictionary*)bords
{
    ModulePageInfo * modulePageInfo = [[ModulePageInfo alloc] init];
    modulePageInfo.boards = bords;
    return modulePageInfo;
}

@end
