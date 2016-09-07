//
//  BaseResponse.h
//  skillChange
//
//  Created by ruanjian on 14-9-4.
//  Copyright (c) 2014年 jim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponse : NSObject
@property (strong , nonatomic) NSString *code;
@property (strong , nonatomic) NSString *info;
@property (strong  ,nonatomic) NSString *httpCode;
@property (strong , nonatomic) NSString *desc;
@property (strong , nonatomic) NSString *errorCode;
@end
