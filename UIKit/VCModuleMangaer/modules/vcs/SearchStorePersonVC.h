//
//  SearchStorePersonVC.h
//  mkt
//
//  Created by Eastern Phoenix on 2/7/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import "AutoRefreshPageVC.h"

@interface SearchStorePersonVC : AutoRefreshPageVC
@property (weak, nonatomic) IBOutlet UITextField *personIdField;
- (IBAction)SearchStorePerson:(id)sender;
+ (instancetype)searchStorePersonVC;
@end
