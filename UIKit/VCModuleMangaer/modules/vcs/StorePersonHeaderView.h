//
//  StorePersonHeaderView.h
//  mkt
//
//  Created by Eastern Phoenix on 15/7/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bee.h"

@interface StorePersonHeaderView : UIView
AS_SIGNAL(SEARCH_BUTTONCLICK);
@property (weak, nonatomic) IBOutlet UITextField *terminalField;
@end
