//
//  ModuleVC.m
//  mkt
//
//  Created by Harin Li on 6/12/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import "ModuleVC.h"
#import "ModuleEvent.h"
#import "ModuleSignal.h"
#import "ModulePagesInfo.h"
#import "ModuleFactory.h"
#import "SiftVC.h"
#import "UILayoutHelper.h"

@interface ModuleFrameInfo :NSObject

@property(strong,nonatomic) ModulePagesInfo * modulePagesInfo;
@property(strong,nonatomic) UIView * view;

@end

@implementation ModuleFrameInfo
@end

@interface ModuleStack :NSObject

@property(strong,nonatomic) NSMutableArray * modulesStack;

-(BOOL)isStackEmpty;
-(ModuleFrameInfo *)lastFrameInfo;
-(ModuleFrameInfo *)pushModulePagesInfo:(ModulePagesInfo *)modulePagesInfo OnModuleVC:(ModuleVC*)moduleVC;
-(ModuleFrameInfo *)popModulePagesInfo;
@end

@implementation ModuleStack
-(UIView*)createModuleContainerOnModuleVC:(ModuleVC*)moduleVC
{
    UIView * view = [[UIView alloc] initWithFrame:moduleVC.view.frame];
    return view;
}

-(id)init
{
    self = [super init];
    if (self) {
        _modulesStack = [NSMutableArray array];
    }
    return self;
}

-(BOOL)isStackEmpty
{
    return _modulesStack.count==0;
}

-(ModuleFrameInfo *)lastFrameInfo
{
    return (ModuleFrameInfo *)[_modulesStack lastObject];
}

-(ModuleFrameInfo *)pushModulePagesInfo:(ModulePagesInfo *)modulePagesInfo OnModuleVC:(ModuleVC*)moduleVC
{
    ModuleFrameInfo * moduleFrameInfo = [[ModuleFrameInfo alloc] init];
    moduleFrameInfo.modulePagesInfo = modulePagesInfo;
    moduleFrameInfo.view = [self createModuleContainerOnModuleVC:moduleVC];
    [_modulesStack addObject:moduleFrameInfo];
    return moduleFrameInfo;
}

-(ModuleFrameInfo *)popModulePagesInfo
{
    ModuleFrameInfo * moduleFrameInfo;
    if(!self.isStackEmpty)
    {
        moduleFrameInfo = [self lastFrameInfo];
        [_modulesStack removeLastObject];
    }
    return moduleFrameInfo;
}
@end


@interface ModuleVC ()
{
    ModuleStack * _moduleStack;
    ModuleFrameInfo * _moduleFrameInfo;
    SiftVC *_siftVC;
}
@property(nonatomic,strong) ModuleEvent * moduleEvent;

@end

@implementation ModuleVC
TTS_DEF_XIB(MainVC, YES, NO)

ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        [self initObserveNotification];
    }
    else if([signal isKindOf:BeeUIBoard.LAYOUT_VIEWS])
    {
        
    }
    else if([signal isKindOf:BeeUIBoard.DELETE_VIEWS])
    {
        
    }
    else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
	{
//        [self setupFirstPage:_moduleFrameInfo];
	}
	else if ( [signal is:BeeUIBoard.DID_APPEAR] )
	{
       
	}
	else if ( [signal is:BeeUIBoard.WILL_DISAPPEAR] )
	{
    
    }
	else if ( [signal is:BeeUIBoard.DID_DISAPPEAR] )
	{
	}
}


-(void)openModuleEvent:(ModuleEvent *)moduleEvent inView:(UIView*)parentView
{
    ModulePagesInfo * modulePagesInfo = [ModuleFactory createModuleInfoByName:moduleEvent.moduleName andModuleVC:self andData:moduleEvent.moduleData];
    if(_moduleStack == nil){
        _moduleStack = [self initialModuleStack];
    }
    BOOL isStackEmpty = _moduleStack.isStackEmpty;
    if(isStackEmpty)
    {
        [parentView addSubview:self.view];
    }
    ModuleFrameInfo * moduleFrameInfo = [_moduleStack pushModulePagesInfo:modulePagesInfo OnModuleVC:self];
    _moduleFrameInfo = moduleFrameInfo;
    [self setupFirstPage:moduleFrameInfo];
    
}

-(void)setupFirstPage:(ModuleFrameInfo *)moduleFrameInfo
{
    ModulePageInfo * modulePageInfo = [moduleFrameInfo.modulePagesInfo getFirstPage];
    [self.view addSubview:moduleFrameInfo.view];
    [self setupPage:modulePageInfo inFrameInfo:moduleFrameInfo];
}

-(void)setupPage:(ModulePageInfo*)modulePageInfo inFrameInfo:(ModuleFrameInfo *)moduleFrameInfo
{
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:moduleFrameInfo.view cache:YES];
//    [UIView setAnimationDuration:0.5f];
    //[UIView setAnimationDelegate:moduleFrameInfo.view];
    CATransition *animation = [CATransition animation];
    animation.duration = 0.1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"default"];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [moduleFrameInfo.view.layer addAnimation:animation forKey:@"left"];

    [moduleFrameInfo.view removeAllSubviews];
    for (BeeUIBoard * board in modulePageInfo.boards.allValues) {
        if(IOS7_OR_LATER)
            [moduleFrameInfo.view addSubview:board.view];
        else
        {
            CGRect rect = board.view.frame;
            [moduleFrameInfo.view addSubview:board.view];
            board.view.frame = rect;
        }

    }
    
//    [UIView commitAnimations];

}

- (void)initObserveNotification
{
}

#pragma mark - ModuleStack methods
-(ModuleStack *)initialModuleStack
{
    ModuleStack *moduleStack = [[ModuleStack alloc] init];
    return moduleStack;
}

ON_SIGNAL3(ModuleSignal, MODULE_VIEW_CHANGE, signal)
{
    NSString * pageName = (NSString *)signal.object;
    ModulePageInfo * modulePageInfo = [_moduleFrameInfo.modulePagesInfo getPage:pageName];
    [self setupPage:modulePageInfo inFrameInfo:_moduleFrameInfo];
}

ON_SIGNAL3(ModuleSignal, MODULE_CLOSE, signal)
{
    ModuleFrameInfo * moduleFrameInfo = [_moduleStack popModulePagesInfo];
    [moduleFrameInfo.view removeAllSubviews];
    [moduleFrameInfo.view removeFromSuperview];
    
    if (_moduleFrameInfo && _moduleFrameInfo.modulePagesInfo && _moduleFrameInfo.modulePagesInfo.finishCloseCallback) {
        _moduleFrameInfo.modulePagesInfo.finishCloseCallback(signal.object);
    }
    
    BOOL isStackEmpty = _moduleStack.isStackEmpty;
    if(isStackEmpty)
    {
        [self.view removeAllSubviews];
        [self.view removeFromSuperview];
        _moduleFrameInfo = nil;
    }
    else
    {
        _moduleFrameInfo = [_moduleStack lastFrameInfo];
        if (_moduleFrameInfo && _moduleFrameInfo.modulePagesInfo && _moduleFrameInfo.modulePagesInfo.reAppearCloseCallback)
        {
            _moduleFrameInfo.modulePagesInfo.reAppearCloseCallback(moduleFrameInfo.modulePagesInfo,signal.object);
        }
    }

    
}

ON_SIGNAL3(ModuleSignal, MODULE_ALL_CLOSE, signal)
{
    [self.view removeAllSubviews];
    [self.view removeFromSuperview];
    [_moduleStack.modulesStack removeAllObjects];
    _moduleFrameInfo = nil;
}

ON_SIGNAL3(ModuleSignal, MODULE_MENU_SHOW, signal)
{
    NSString *leftString = (NSString *)signal.object;
    [self hideOrShowMenu:leftString.integerValue];
}

ON_SIGNAL3(ModuleSignal, MODULE_MENU_HIDE, signal)
{
    [self hideOrShowMenu:0];
}

- (void)hideOrShowMenu:(NSInteger)left
{
    ModulePageInfo * currentPage = [_moduleFrameInfo.modulePagesInfo getCurrentPage];
    if( (left==0 && currentPage.xOffset==0 ) || left==currentPage.xOffset)
        return;
    
    CGFloat movingXOffset = 0;
    movingXOffset = left - currentPage.xOffset;
    currentPage.xOffset = left;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    
    for (BeeUIBoard * board in currentPage.boards.allValues) {
        CGFloat movedX = board.view.left + movingXOffset;
        board.view.left = movedX;
    }
    
    [UIView commitAnimations];
//
//    
//    if (self.view.left != left) {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationDuration:0.3f];
//        [UIView setAnimationDelegate:self];
//        
//        self.view.left = left;
//        
//        [UIView commitAnimations];
//    }
}


@end
