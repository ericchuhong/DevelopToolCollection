//
//  ModuleVC.h
//  mkt
//
//  Created by Harin Li on 6/12/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import "Bee.h"
#import "ModuleEvent.h"


@interface ModuleVC : BeeUIBoard

-(void)openModuleEvent:(ModuleEvent *)moduleEvent inView:(UIView*)parentView;


@end
