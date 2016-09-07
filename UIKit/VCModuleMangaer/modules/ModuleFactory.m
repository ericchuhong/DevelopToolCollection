//
//  ModuleFactory.m
//  mkt
//
//  Created by Harin Li on 6/12/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import "ModuleFactory.h"
#import "ModuleEvent.h"
#import "ModuleSignal.h"
#import "ModuleVC.h"
#import "BaseHeaderVC.h"
#import "ResetPasswordVC.h"
#import "MyAccountNoVC.h"
#import "StoreDetailVC.h"
#import "SearchMemberVC.h"
#import "FollowUpDetailVC.h"
#import "StoreDetailVC.h"
#import "QueryCustomersDetailResponse.h"
#import "FeedBackVC.h"
#import "LeadVC.h"
#import "MouthKPIVC.h"
#import "FillFinishCountVC.h"
#import "FillCommentVC.h"
#import "MouthCommentVC.h"
#import "AppGatherWorkVC.h"
#import "AppGatherMeetVC.h"
#import "DepartsSelectVC.h"
#import "AreaTerminalVC.h"

#import "CoreService.h"

#import "SearchTerminalsModule.h"
#import "MyTerminalsModule.h"
#import "NearTerminalsModule.h"
#import "SearchAreaTerminalsModule.h"

#import "SearchCustomersModule.h"
#import "MyCustomersModule.h"
#import "FollowUpModule.h"

#import "CreditsModule.h"
#import "SingleCreditsModule.h"
#import "BoxCreditsModule.h"

#import "AppGatherModule.h"
#import "ForgetPassWordVC.h"
#import "ForgetWebViewVC.h"
#import "LossClientWarmVC.h"
#import "ExchangeModule.h"
#import "ActivitySignInVC.h"
#import "ActivitySignInModule.h"
#import "AttendRecordVC.h"
#import "AttendRecordPopUpVC.h"
#import "AttendRecordModule.h"

#import "LossClientModuleInfo.h"
#import "DiscountCouponModule.h"
#import "MyCustomersModule.h"
#import "SearchCustomersModule.h"
#import "WebViewModule.h"
#import "TestModule.h"
#import "AIDataDefaultModule.h"
#import "KPIDataDefaultModule.h"
#import "MessageSendVC.h"
#import "BarModule.h"
#import "ChildConsultantModule.h"
#import "SceneReportModule.h"
#import "CheckAttendanceModule.h"
#import "SendMemberCardModule.h"
#import "FollowupAppGetherModule.h"
#import "ReturnProgressAndResultModule.h"
#import "ViolationSaleModule.h"
#import "CheckPassWordModule.h"
#import "TCMessageBox.h"
#import "CompetitiveProductModule.h"


@implementation ModuleFactory

+(NSDictionary*)getNameToModulePagesInfoClass
{
    return @{
         //terminal modules
         ModuleEvent.SEARCH_TERMINALS: [SearchTerminalsModule class],
         ModuleEvent.MY_TERMINAL: [MyTerminalsModule class],
         ModuleEvent.SEARCH_AREA_TERMINALS: [SearchAreaTerminalsModule class],
         ModuleEvent.NEAR_TERMINALS: [NearTerminalsModule class],
         //customer modules
         ModuleEvent.MY_CUSTOMERS: [MyCustomersModule class],
         ModuleEvent.FOLLOW_UP: [FollowUpModule class],
         ModuleEvent.SEARCH_CUSTOMER :[SearchCustomersModule class],
         
         ModuleEvent.CREDITS:[CreditsModule class],
         ModuleEvent.SINGLE_CREDITS:[SingleCreditsModule class],
         ModuleEvent.BOX_CREDITS:[BoxCreditsModule class],
         
         ModuleEvent.APP_GETHER: [AppGatherModule class],
         ModuleEvent.EXCHANGE:[ExchangeModule class],
         ModuleEvent.ACTIVITY_SIGNIN:[ActivitySignInModule class],
         
         ModuleEvent.LOSS_CLIENTS_RECORD:[LossClientModuleInfo class],
         ModuleEvent.ATTEND_RECORD:[AttendRecordModule class],
         ModuleEvent.DISCOUNT_COUPON:[DiscountCouponModule class],
         ModuleEvent.WEBVIEW_MODULE:[WebViewModule class],
         ModuleEvent.MODULE_TEST:[TestModule class],
         ModuleEvent.AI_DATA_MODULE:[AIDataDefaultModule class],
         ModuleEvent.KPI_DATA_MODULE:[KPIDataDefaultModule class],
         ModuleEvent.BAR_QUERY:[BarModule class],
         ModuleEvent.CHILD_CONSULTANT:[ChildConsultantModule class],
         ModuleEvent.SCENE_REPORT:[SceneReportModule class],
         ModuleEvent.CHECK_ATTENDANCE:[CheckAttendanceModule class],
         ModuleEvent.REPORT_QUERY:[AIDataDefaultModule class],
         ModuleEvent.SEND_CARD:[SendMemberCardModule class],
         ModuleEvent.FOLLOWUP_APPGETHER:[FollowupAppGetherModule class],
         ModuleEvent.RETURN_RESULT:[AIDataDefaultModule class],
         ModuleEvent.VIOLATION_SALE:[ViolationSaleModule class],
         ModuleEvent.CHECK_PASSWORD:[CheckPassWordModule class],
         ModuleEvent.COMPETITIVE_PRODUCT:[CompetitiveProductModule class]

         };
         //};
}

+(ModulePagesInfo*)createModuleInfoByName:(NSString*)name andModuleVC:(ModuleVC*)moduleVC andData:(NSObject*)data
{
    if([BeeSystemInfo isPhone35] || [BeeSystemInfo isPhoneRetina35])
    {
        [TCMessageBox showMessage:@"正在加载模块" hideByTouch:NO];
    }
    ModulePagesInfo * modulePagesInfo;
    NSDictionary * nameToModulePagesInfoClass = [self getNameToModulePagesInfoClass];
    if(nameToModulePagesInfoClass[name]!=nil)
    {
        Class modulePagesInfoClass = nameToModulePagesInfoClass[name];
        modulePagesInfo = [modulePagesInfoClass modulePagesInfo:moduleVC andData:data];
    }
    else if([name isEqualToString:ModuleEvent.RESET_PASSWORD])
        modulePagesInfo = [self createResetPasswordModuleByModuleVC:moduleVC];
    else if([name isEqualToString:ModuleEvent.NEW_VERSION])
        modulePagesInfo = [self createNewVersionModuleByModuleVC:moduleVC];
    else if([name isEqualToString:ModuleEvent.ACCOUNT_INFO])
        modulePagesInfo = [self createAccountInfoModuleByModuleVC:moduleVC];
    else if([name isEqualToString:ModuleEvent.FEED_BACK])
        modulePagesInfo = [self createFeedbackModuleByModuleVC:moduleVC];
    else if([name isEqualToString:ModuleEvent.LEAD])
        modulePagesInfo = [self createLeadModuleByModuleVC:moduleVC];
    else if([name isEqualToString:ModuleEvent.MOUTH_KPI])
        modulePagesInfo = [self createMouthKPIModuleByModuleVC:moduleVC];
    else if([name isEqualToString:ModuleEvent.FORGET_PASSWORD])
        modulePagesInfo = [self createForgetPasswordModuleByModuleVC:moduleVC];
    if([BeeSystemInfo isPhone35] || [BeeSystemInfo isPhoneRetina35])
    {
        [TCMessageBox hide];
    }
    modulePagesInfo.moduleName = name;
    return modulePagesInfo;
}

+(ModulePagesInfo*)createResetPasswordModuleByModuleVC:(ModuleVC*)moduleVC
{
    NSMutableDictionary * moduleData = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * modulePageInfos = [[NSMutableDictionary alloc] init];
    ModulePageInfo * firstPageInfo = [[ModulePageInfo alloc] init];
    
    ResetPasswordVC * resetPasswordVC = [[ResetPasswordVC alloc] init];
    resetPasswordVC.parentBoard = moduleVC;
    resetPasswordVC.pswState = ePasswordUnset;
    firstPageInfo.boards = @{@"content":resetPasswordVC};
    [modulePageInfos setObject:firstPageInfo forKey:@"resetPassword"];
    
    ModulePagesInfo * modulePagesInfo = [[ModulePagesInfo alloc] initWithData:moduleData andPages:modulePageInfos andFirstPage:firstPageInfo];
    return modulePagesInfo;
}

+(ModulePagesInfo*)createAccountInfoModuleByModuleVC:(ModuleVC*)moduleVC
{
    NSMutableDictionary * moduleData = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * modulePageInfos = [[NSMutableDictionary alloc] init];
    ModulePageInfo * firstPageInfo = [[ModulePageInfo alloc] init];
    
    MyAccountNoVC * accountInfoVC = [MyAccountNoVC accountInfoVC];
    __block MyAccountNoVC *accountInfoVCBlock = accountInfoVC;
    accountInfoVC.parentBoard = moduleVC;
    accountInfoVC.appearBlock = ^{
        [accountInfoVCBlock showAccountInfo];
    };
    
    BaseHeaderVC * headerVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
        [accountInfoVC sendUISignal:ModuleSignal.MODULE_CLOSE];
    } andLeftButtonIcon:@"ico_back.png"];
    headerVc.titleLabel.text = @"我的账号";
    
    
    firstPageInfo.boards = @{@"header":headerVc,@"content":accountInfoVC};
    [modulePageInfos setObject:firstPageInfo forKey:@"accountInfo"];
    
    ModulePagesInfo * modulePagesInfo = [[ModulePagesInfo alloc] initWithData:moduleData andPages:modulePageInfos andFirstPage:firstPageInfo];
    return modulePagesInfo;
}

+(ModulePagesInfo*)createForgetPasswordModuleByModuleVC:(ModuleVC*)moduleVC
{
    NSMutableDictionary * moduleData = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * modulePageInfos = [[NSMutableDictionary alloc] init];
    ModulePageInfo * firstPageInfo = [[ModulePageInfo alloc] init];
    
    ForgetPassWordVC * forgetPassWordVC = [ForgetPassWordVC forgetPassWordVC];
    __block ForgetPassWordVC *forgetPassWordVCBlock = forgetPassWordVC;
    forgetPassWordVC.parentBoard = moduleVC;
    forgetPassWordVC.openWebViewClicked = ^{
        [forgetPassWordVCBlock sendUISignal:ModuleSignal.MODULE_VIEW_CHANGE withObject:@"forgetwebview"];
    };
    
    BaseHeaderVC * headerVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
        [forgetPassWordVC sendUISignal:ModuleSignal.MODULE_CLOSE];
    } andLeftButtonIcon:@"ico_back.png"];
    headerVc.titleLabel.text = @"忘记密码";
    
    
    firstPageInfo.boards = @{@"header":headerVc,@"content":forgetPassWordVC};
    [modulePageInfos setObject:firstPageInfo forKey:@"forgetpassword"];
    
    ForgetWebViewVC * forgetWebViewVC = [ForgetWebViewVC forgetWebViewVC];
    forgetWebViewVC.parentBoard = moduleVC;
    
    
    BaseHeaderVC *forgetWebViewHeaderVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
        [forgetWebViewVC sendUISignal:ModuleSignal.MODULE_VIEW_CHANGE withObject:@"forgetpassword"];
    } andLeftButtonIcon:@"ico_back.png"];
    forgetWebViewHeaderVc.titleLabel.text = @"忘记密码";
    ModulePageInfo * terminalDetailPangeInfo = [[ModulePageInfo alloc] init];
    terminalDetailPangeInfo.boards =  @{@"header":forgetWebViewHeaderVc,@"content":forgetWebViewVC};
    
    [modulePageInfos setObject:terminalDetailPangeInfo forKey:@"forgetwebview"];
    
    ModulePagesInfo * modulePagesInfo = [[ModulePagesInfo alloc] initWithData:moduleData andPages:modulePageInfos andFirstPage:firstPageInfo];
    return modulePagesInfo;
}


+(ModulePagesInfo*)createFeedbackModuleByModuleVC:(ModuleVC*)moduleVC
{
    NSMutableDictionary * moduleData = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * modulePageInfos = [[NSMutableDictionary alloc] init];
    ModulePageInfo * firstPageInfo = [[ModulePageInfo alloc] init];
    
    __block FeedBackVC * feedbackVC = [FeedBackVC feedbackVC];
    feedbackVC.parentBoard = moduleVC;
    feedbackVC.btnClickBlock = ^{
        
    };
    
    BaseHeaderVC * headerVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
        [feedbackVC sendUISignal:ModuleSignal.MODULE_CLOSE];
    } andLeftButtonIcon:@"ico_back.png"];
    headerVc.titleLabel.text = @"用户反馈";
    
    
    firstPageInfo.boards = @{@"header":headerVc,@"content":feedbackVC};
    [modulePageInfos setObject:firstPageInfo forKey:@"feedback"];
    
    ModulePagesInfo * modulePagesInfo = [[ModulePagesInfo alloc] initWithData:moduleData andPages:modulePageInfos andFirstPage:firstPageInfo];
    return modulePagesInfo;
}

+(ModulePagesInfo*)createLeadModuleByModuleVC:(ModuleVC*)moduleVC
{
    NSMutableDictionary * moduleData = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * modulePageInfos = [[NSMutableDictionary alloc] init];
    ModulePageInfo * firstPageInfo = [[ModulePageInfo alloc] init];
    
    __block LeadVC * leadVC = [[LeadVC alloc] init];
    leadVC.parentBoard = moduleVC;
    
    firstPageInfo.boards = @{@"content":leadVC};
    [modulePageInfos setObject:firstPageInfo forKey:@"lead"];
    
    ModulePagesInfo * modulePagesInfo = [[ModulePagesInfo alloc] initWithData:moduleData andPages:modulePageInfos andFirstPage:firstPageInfo];
    return modulePagesInfo;
}


+(ModulePagesInfo*)createFollowUpModuleByModuleVC:(ModuleVC*)moduleVC andFollowUpType:(NSString*)followUpType{
    return [FollowUpModule modulePagesInfo:moduleVC andData:followUpType];
}

+(ModulePagesInfo*)createMouthKPIModuleByModuleVC:(ModuleVC*)moduleVC
{
    NSMutableDictionary * moduleData = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * modulePageInfos = [[NSMutableDictionary alloc] init];
    ModulePageInfo * firstPageInfo = [[ModulePageInfo alloc] init];
    
//    __block MouthKPIVC *mouthKPIVC = [MouthKPIVC mouthKPIVC];
//    mouthKPIVC.parentBoard = moduleVC;
//    
//    BaseHeaderVC *headerVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
//        [mouthKPIVC sendUISignal:ModuleSignal.MODULE_CLOSE];
//    } andLeftButtonIcon:@"ico_back.png"];
//    headerVc.titleLabel.text = @"打月度KPI";
//    
//    firstPageInfo.boards = @{@"header":headerVc,@"content":mouthKPIVC};
//    [modulePageInfos setObject:firstPageInfo forKey:@"mouthKPI"];
    
//    __block FillFinishCountVC *fillFinishCountVC = [FillFinishCountVC fillFinishCountVC];
//    fillFinishCountVC.parentBoard = moduleVC;
//    
//    BaseHeaderVC *headerVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
//        [fillFinishCountVC sendUISignal:ModuleSignal.MODULE_CLOSE];
//    } andLeftButtonIcon:@"ico_back.png"];
//    headerVc.titleLabel.text = @"打月度KPI";
//    
//    firstPageInfo.boards = @{@"header":headerVc,@"content":fillFinishCountVC};
//    [modulePageInfos setObject:firstPageInfo forKey:@"fillFinishCount"];
    
//    __block FillCommentVC *fillCommentVC = [FillCommentVC fillCommentVC];
//    fillCommentVC.parentBoard = moduleVC;
//    
//    BaseHeaderVC *headerVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
//        [fillCommentVC sendUISignal:ModuleSignal.MODULE_CLOSE];
//    } andLeftButtonIcon:@"ico_back.png"];
//    headerVc.titleLabel.text = @"打月度KPI";
//    
//    firstPageInfo.boards = @{@"header":headerVc,@"content":fillCommentVC};
//    [modulePageInfos setObject:firstPageInfo forKey:@"fillComment"];
    
//    __block MouthCommentVC *mouthCommentVC = [MouthCommentVC mouthCommentVC];
//    mouthCommentVC.parentBoard = moduleVC;
//    
//    BaseHeaderVC *headerVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
//        [mouthCommentVC sendUISignal:ModuleSignal.MODULE_CLOSE];
//    } andLeftButtonIcon:@"ico_back.png"];
//    headerVc.titleLabel.text = @"打月度KPI";
//    
//    firstPageInfo.boards = @{@"header":headerVc,@"content":mouthCommentVC};
//    [modulePageInfos setObject:firstPageInfo forKey:@"mouthComment"];
    
//    __block AppGatherMeetVC *appGatherMeetVC = [AppGatherMeetVC appGatherMeetVC];
//    appGatherMeetVC.parentBoard = moduleVC;
//    
//    BaseHeaderVC *headerVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
//        [appGatherMeetVC sendUISignal:ModuleSignal.MODULE_CLOSE];
//    } andLeftButtonIcon:@"ico_back.png"];
//    headerVc.titleLabel.text = @"工作管理";
//    
//    firstPageInfo.boards = @{@"header":headerVc,@"content":appGatherMeetVC};
//    [modulePageInfos setObject:firstPageInfo forKey:@"appGatherMeet"];
    
    __block DepartsSelectVC *departsSelectVC = [DepartsSelectVC departsSelectVC];
    departsSelectVC.parentBoard = moduleVC;
    
    BaseHeaderVC *headerVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
        [departsSelectVC sendUISignal:ModuleSignal.MODULE_CLOSE];
    } andLeftButtonIcon:@"ico_back.png"];
    headerVc.titleLabel.text = @"区域查询";
    
    firstPageInfo.boards = @{@"header":headerVc,@"content":departsSelectVC};
    [modulePageInfos setObject:firstPageInfo forKey:@"officeQuery"];
    
    ModulePagesInfo * modulePagesInfo = [[ModulePagesInfo alloc] initWithData:moduleData andPages:modulePageInfos andFirstPage:firstPageInfo];
    return modulePagesInfo;
}

+(ModulePagesInfo*)createNewVersionModuleByModuleVC:(ModuleVC*)moduleVC
{
    NSMutableDictionary * moduleData = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * modulePageInfos = [[NSMutableDictionary alloc] init];
    ModulePageInfo * firstPageInfo = [[ModulePageInfo alloc] init];
    
    MessageSendVC *messageSendVC = [MessageSendVC messageSendVC];
    MessageSendVC *messageSendVCInBlock = messageSendVC;
    messageSendVC.parentBoard = moduleVC;
    messageSendVC.diappearBlock = ^()
    {
        [messageSendVCInBlock sendUISignal:ModuleSignal.MODULE_VIEW_CHANGE withObject:@"customerDetailVC"];
    };
    ModulePageInfo * messageSendPageInfo = [[ModulePageInfo alloc] init];
    messageSendPageInfo.boards = @{@"content":messageSendVC};
    [modulePageInfos setObject:messageSendPageInfo forKey:@"messageSendVC"];
    
//    firstPageInfo.boards = @{@"header":headerVc,@"content":attendRecordVC};
//    [modulePageInfos setObject:firstPageInfo forKey:@"attendRecord"];
    
    
    
    ModulePagesInfo * modulePagesInfo = [[ModulePagesInfo alloc] initWithData:moduleData andPages:modulePageInfos andFirstPage:messageSendPageInfo];
    return modulePagesInfo;
}


@end
