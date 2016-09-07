//
//  StoreDetailCell.h
//  mkt
//
//  Created by edwin on 14-6-17.
//  Copyright (c) 2014年 biostime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property(nonatomic, retain)NSArray *testData;

@end
