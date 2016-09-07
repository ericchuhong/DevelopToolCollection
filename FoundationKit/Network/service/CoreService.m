//
//  CoreService.m
//  mkt
//
//  Created by Harin Li on 6/16/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import "CoreService.h"
#import "TaskManageServiceImpl.h"
#import "LoginRemoteServiceImpl.h"
#import "RegisterRemoteServiceImpl.h"
#import "QueryUserInfoRemoteServiceImpl.h"
#import "MotifyUserInfoRemoteServiceImpl.h"
#import "QueryFriendsRemoteServiceImpl.h"
#import "ExchangeRemoteServiceImpl.h"
#import "BindNumberRemoteServiceImpl.h"
#import "BlackListOperationRemoteServiceImpl.h"
#import "CommentOperationRermoteServiceImpl.h"
#import "ContactOperationRemoteServiceImpl.h"
#import "FeedBackRemoteServiceImpl.h"
#import "HelpApplyRemoteServiceImpl.h"
#import "AskforHelpRemoteServiceImpl.h"
#import "ReportRemoteServiceImpl.h"
#import "ResOperationRemoteServiceImpl.h"
#import "SkillDetailRemoteServiceImpl.h"
#import "SkillOperationRemoteServiceImpl.h"
#import "WtcOperationRemoteServiceImpl.h"
@implementation CoreService
DEF_SINGLETON(CoreService)

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        _taskManagerService = [TaskManageServiceImpl sharedInstance];
        _loginRemoteService = [LoginRemoteServiceImpl sharedInstance];
        _registerRemoterService = [RegisterRemoteServiceImpl sharedInstance];
        _userInfoRemoteService = [QueryUserInfoRemoteServiceImpl sharedInstance];
        _motifyUserInfoRemoteService = [MotifyUserInfoRemoteServiceImpl sharedInstance];
        _searchExchangeListRemoteService = [QueryFriendsRemoteServiceImpl sharedInstance];
        _exchangeRemoteService = [ExchangeRemoteServiceImpl sharedInstance];
        _bindNumberRemoteService = [BindNumberRemoteServiceImpl sharedInstance];
        _blackListOperationRemoteService  =[BlackListOperationRemoteServiceImpl sharedInstance];
        _commentOperationRermoteService = [CommentOperationRermoteServiceImpl sharedInstance];
        _contactOperationRemoteService = [ContactOperationRemoteServiceImpl sharedInstance];
        _feedBackRemoteService = [FeedBackRemoteServiceImpl sharedInstance];
        _helpApplyRemoteService = [HelpApplyRemoteServiceImpl sharedInstance];
        _askforHelpRemoteService = [AskforHelpRemoteServiceImpl sharedInstance];
        _reportRemoteService = [ReportRemoteServiceImpl sharedInstance];
        _resOperationRemoteService = [ResOperationRemoteServiceImpl sharedInstance];
        _skillDetailRemoteService = [SkillDetailRemoteServiceImpl sharedInstance];
        _skillOperationRemoteService = [SkillOperationRemoteServiceImpl sharedInstance];
        _wtcOperationRemoteService = [WtcOperationRemoteServiceImpl sharedInstance];
    }
    return self;
}


@end
