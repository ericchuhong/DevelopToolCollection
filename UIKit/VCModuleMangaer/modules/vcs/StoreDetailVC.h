//
//  StoreDetailVC.h
//  mkt
//
//  Created by edwin on 14-6-16.
//  Copyright (c) 2014年 biostime. All rights reserved.
//

#import "BaseModulePageVC.h"

@interface StoreDetailVC : BaseModulePageVC<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UIView *detailView;
//@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UILabel *dayPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *exchange1Label;
@property (weak, nonatomic) IBOutlet UILabel *exchange2Label;
@property (weak, nonatomic) IBOutlet UILabel *milkOutFlow3Label;
@property (weak, nonatomic) IBOutlet UILabel *milkOutFlow2Label;
@property (weak, nonatomic) IBOutlet UILabel *milkOutFlow1Label;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView1;
@property (weak, nonatomic) IBOutlet UIView *contentView2;
@property (weak, nonatomic) IBOutlet UIView *contentView3;
@property (weak, nonatomic) IBOutlet UIView *distanceView;
@property (weak, nonatomic) IBOutlet UIView *sperView;
@property (strong, nonatomic) UILabel *btnVCtitleLabel;

-(void)showStoreDetail:(NSObject*)data;
+(instancetype)storeDetailVC;

@end
