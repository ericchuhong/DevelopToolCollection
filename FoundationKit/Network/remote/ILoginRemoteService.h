//
//  ILoiginRemoteService.h
//  skillChange
//
//  Created by ruanjian on 14-9-6.
//  Copyright (c) 2014年 jim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRemoteService.h"
@protocol ILoginRemoteService <IRemoteService>
- (void)loginWithAccount:(NSString *)account andPassword:(NSString *)password;
@end
