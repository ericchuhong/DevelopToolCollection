//
//  CoreService.h
//  mkt
//
//  Created by Harin Li on 6/16/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRemoteService.h"
#import "ITaskManageService.h"
#import "ILoginRemoteService.h"
#import "IRegisterRemoteService.h"
#import "IUserInfoRemoteService.h"
#import "IMotifyUserInfoRemoteService.h"
#import "ISearchExchangeListRemoteService.h"
#import "IExchangeRemoteService.h"
#import "IBindNumberRemoteService.h"
#import "IBlackListOperationRemoteService.h"
#import "ICommentOperationRermoteService.h"
#import "IContactOperationRemoteService.h"
#import "IFeedBackRemoteService.h"
#import "IHelpApplyRemoteService.h"
#import "IAskforHelpRemoteService.h"
#import "IReportRemoteService.h"
#import "IResOperationRemoteService.h"
#import "ISkillDetailRemoteService.h"
#import "ISkillOperationRemoteService.h"
#import "IWtcOperationRemoteService.h"
@interface CoreService : NSObject
AS_SINGLETON(CoreService)

@property(nonatomic,readonly) id<ITaskManageService> taskManagerService;
@property (readonly , nonatomic) id<ILoginRemoteService> loginRemoteService;
@property (readonly , nonatomic) id<IRegisterRemoteService>registerRemoterService;
@property (readonly , nonatomic) id<IUserInfoRemoteService>userInfoRemoteService;
@property (readonly , nonatomic) id<IMotifyUserInfoRemoteService>motifyUserInfoRemoteService;
@property (readonly , nonatomic) id<IQueryFriendsRemoteService>searchExchangeListRemoteService;
@property (readonly , nonatomic) id<IExchangeRemoteService>exchangeRemoteService;
@property (readonly , nonatomic) id<IBindNumberRemoteService>bindNumberRemoteService;
@property (readonly , nonatomic) id<IBlackListOperationRemoteService>blackListOperationRemoteService;
@property (readonly , nonatomic) id<ICommentOperationRermoteService>commentOperationRermoteService;
@property (readonly , nonatomic) id<IContactOperationRemoteService>contactOperationRemoteService;
@property (readonly , nonatomic) id<IFeedBackRemoteService>feedBackRemoteService;
@property (readonly , nonatomic) id<IHelpApplyRemoteService>helpApplyRemoteService;
@property (readonly , nonatomic) id<IAskforHelpRemoteService>askforHelpRemoteService;
@property (readonly , nonatomic) id<IReportRemoteService>reportRemoteService;
@property (readonly , nonatomic) id<IResOperationRemoteService>resOperationRemoteService;
@property (readonly , nonatomic) id<ISkillDetailRemoteService>skillDetailRemoteService;
@property (readonly , nonatomic) id<ISkillOperationRemoteService>skillOperationRemoteService;
@property (readonly , nonatomic) id<IWtcOperationRemoteService>wtcOperationRemoteService;



@end
