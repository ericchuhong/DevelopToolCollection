//
//  LoginRemoteServiceImpl.m
//  skillChange
//
//  Created by ruanjian on 14-9-6.
//  Copyright (c) 2014年 jim. All rights reserved.
//

#import "LoginRemoteServiceImpl.h"
#import "BaseResponse.h"
#import "LoginEvent.h"
#import "SKCModel.h"
#import "LoginResponse.h"
@implementation LoginRemoteServiceImpl
DEF_SINGLETON(LoginRemoteServiceImpl)

- (instancetype)init{
    if(self = [super init]){
        [self resetBlocks];
    }
    return self;
}

- (void)resetBlocks{
    __block LoginRemoteServiceImpl *loginRemoteServiceImpl = self;
    self.executeBlock = ^(){
        NSString *url = [[SKCModel sharedInstance].serverRootURL stringByAppendingString:@"login"];
        NSMutableDictionary *postParams = [[NSMutableDictionary alloc] init];
        [postParams addEntriesFromDictionary:loginRemoteServiceImpl.params];
        [loginRemoteServiceImpl executeWithUrl:url andHttpMethod:HttpTaskData.POST AndUrlParams:postParams andPostParams:nil andToken:nil];
        
        
        return 0;
    };
    
    self.parseBlock = ^(TaskInfo *taskInfo , id request , NSObject **data){
        NSString *responseString = ((ASIHTTPRequest *)request).responseString;
        NSDictionary *responseDictionary = [responseString objectFromJSONString];
        if(responseDictionary && responseDictionary.allKeys.count > 0){
            LoginResponse *loginResponse = [LoginResponse objectFromDictionary:responseDictionary];
            *data = loginResponse;
            if([loginResponse.code isEqualToString:@"1"]){
                [SKCModel sharedInstance].userId = loginResponse.user_id;
                return 0;
            }else{
                loginRemoteServiceImpl.postFailedMessage = YES;
                loginRemoteServiceImpl.failedMessage = loginResponse.info;
                return -1;
            }
        }else{
            return -2;
        }
    };
    self.successBlock = ^(NSObject *data){
        [loginRemoteServiceImpl postNotification:LoginEvent.LOGIN_SUCCESS];
        return 0;
    };
}





- (void)loginWithAccount:(NSString *)account andPassword:(NSString *)password{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSDictionary *jsonArray = @{@"login":account,@"password":password};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject: jsonArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString  = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    params[@"content"] = jsonString;
    self.params = params;
    [self execute];
}
@end

