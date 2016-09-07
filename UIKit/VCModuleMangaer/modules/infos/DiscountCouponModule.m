//
//  DiscountCouponInfo.m
//  mkt
//
//  Created by edwin on 14-7-3.
//  Copyright (c) 2014年 biostime. All rights reserved.
//

#import "DiscountCouponModule.h"
#import "BaseHeaderVC.h"
#import "ModuleSignal.h"
#import "DiscountCouponVC.h"
#import "DiscountCouponUseSuccessVC.h"
#import "BaseScanBarCodeVC.h"
#import "InputManualVC.h"

@implementation DiscountCouponModule

+(ModulePagesInfo*)modulePagesInfo:(ModuleVC*)moduleVC andData:(NSObject*)data
{
    __block NSMutableDictionary * moduleData = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * modulePageInfos = [[NSMutableDictionary alloc] init];
    ModulePageInfo * firstPageInfo = [[ModulePageInfo alloc] init];
    
    DiscountCouponVC *discountCouponVC = [DiscountCouponVC discountCouponVC];
    __block DiscountCouponVC *discountCouponVCInBlock = discountCouponVC;
    discountCouponVC.parentBoard = moduleVC;
//    discountCouponVC.queryMemberBtnClicked = ^{
//        [discountCouponVCInBlock sendUISignal:ModuleSignal.MODULE_VIEW_CHANGE withObject:@"discountCouponUseSuccess"];
//    };
    discountCouponVC.buttonClickBlock = ^(NSInteger tag,NSObject *data)
    {
        [discountCouponVCInBlock sendUISignal:ModuleSignal.MODULE_VIEW_CHANGE withObject:@"baseScanBarCodeVC"];
    };
    
    BaseHeaderVC *headerVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
        [discountCouponVC sendUISignal:ModuleSignal.MODULE_CLOSE];
    } andLeftButtonIcon:@"ico_back.png"];
    headerVc.titleLabel.text = @"优惠券";
    
    firstPageInfo.boards = @{@"header":headerVc,@"content":discountCouponVC};
    [modulePageInfos setObject:firstPageInfo forKey:@"attendRecord"];
    
    BaseScanBarCodeVC *baseScanBarCodeVC = [BaseScanBarCodeVC baseScanBarCodeVC];
    __block BaseScanBarCodeVC *baseScanBarCodeVCInBlock = baseScanBarCodeVC;
    baseScanBarCodeVC.parentBoard = moduleVC;
    baseScanBarCodeVC.appearBlock = ^{
        [baseScanBarCodeVCInBlock setupBarCode];
        [baseScanBarCodeVCInBlock addCreditAndExchangButton];
    };
    baseScanBarCodeVC.scanFinish = ^(NSObject *code)
    {
        [baseScanBarCodeVCInBlock sendUISignal:ModuleSignal.MODULE_VIEW_CHANGE withObject:@"discountCouponUseSuccess"];
    };
    baseScanBarCodeVC.buttonClickBlock = ^(NSInteger tag,NSObject *data)
    {
        if (tag == 400)
        {
            [baseScanBarCodeVCInBlock sendUISignal:ModuleSignal.MODULE_VIEW_CHANGE withObject:@"inputManualVC"];
        }
    };
    
    BaseHeaderVC *baseScanBarCodeHeaderVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
        [baseScanBarCodeVCInBlock sendUISignal:ModuleSignal.MODULE_VIEW_CHANGE withObject:@"attendRecord"];
    } andLeftButtonIcon:@"ico_back.png"];
    baseScanBarCodeHeaderVc.titleLabel.text = @"扫码";
    ModulePageInfo * baseScanBarCodePageInfo = [[ModulePageInfo alloc] init];
    baseScanBarCodePageInfo.boards = @{@"header":baseScanBarCodeHeaderVc,@"content":baseScanBarCodeVC};
    [modulePageInfos setObject:baseScanBarCodePageInfo forKey:@"baseScanBarCodeVC"];
    
    DiscountCouponUseSuccessVC *discountCouponUseSuccessVC = [DiscountCouponUseSuccessVC discountCouponUseSuccess];
    
    discountCouponUseSuccessVC.parentBoard = moduleVC;
    
    BaseHeaderVC *successHeaderVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
        [discountCouponUseSuccessVC sendUISignal:ModuleSignal.MODULE_VIEW_CHANGE withObject:@"attendRecord"];
    } andLeftButtonIcon:@"ico_back.png"];
    successHeaderVc.titleLabel.text = @"优惠券兑换成功";
    ModulePageInfo * successPageInfo = [[ModulePageInfo alloc] init];
    successPageInfo.boards = @{@"header":successHeaderVc,@"content":discountCouponUseSuccessVC};
    [modulePageInfos setObject:successPageInfo forKey:@"discountCouponUseSuccess"];
    
    InputManualVC * inputManualVC = [InputManualVC inputManualVC];
    //    __block InputManualVC *inputManualVCInBlock = inputManualVC;
    inputManualVC.parentBoard = moduleVC;
    
    BaseHeaderVC *inputManualHeaderVc = [BaseHeaderVC headerVCWithLeftButtonBlock:^(id sender) {
        [inputManualVC sendUISignal:ModuleSignal.MODULE_VIEW_CHANGE withObject:@"baseScanBarCodeVC"];
    } andLeftButtonIcon:@"ico_back.png" andRightButtonBlock:^(id sender) {
        [inputManualVC sendUISignal:ModuleSignal.MODULE_VIEW_CHANGE withObject:@"baseScanBarCodeVC"];
    } andRightButtonIcon:nil];
    inputManualHeaderVc.titleLabel.text = @"搜索会员";
    [inputManualHeaderVc.rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    ModulePageInfo * inputManualPageInfo = [[ModulePageInfo alloc] init];
    inputManualPageInfo.boards =  @{@"header":inputManualHeaderVc,@"content":inputManualVC};
    [modulePageInfos setObject:inputManualPageInfo forKey:@"inputManualVC"];
    
    
    
    ModulePagesInfo * modulePagesInfo = [[ModulePagesInfo alloc] initWithData:moduleData andPages:modulePageInfos andFirstPage:firstPageInfo];
    return modulePagesInfo;
}


@end
