//
//  LoginRemoteServiceImpl.h
//  skillChange
//
//  Created by ruanjian on 14-9-6.
//  Copyright (c) 2014年 jim. All rights reserved.
//

#import "AbstractRemoteService.h"
#import "ILoginRemoteService.h"
@interface LoginRemoteServiceImpl : AbstractRemoteService<ILoginRemoteService>
AS_SINGLETON(LoginRemoteServiceImpl)
@end
