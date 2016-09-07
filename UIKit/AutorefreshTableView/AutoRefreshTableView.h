//
//  AutoRefreshTableView.h
//  mkt
//
//  Created by Harin Li on 6/18/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AutoRefreshTableView;

typedef void(^ChooseItemBlock)(NSString * dataId);
typedef void(^ItemClickedBlock)(NSInteger index,NSObject *data);
typedef void(^GetNextListBlock)(NSString * pangeNo,NSString * pangeSize);

typedef CGFloat(^CellHeightBlock)(AutoRefreshTableView * tableView,NSInteger index);
typedef UITableViewCell*(^CellCreateBlock)(AutoRefreshTableView * tableView,NSInteger index);

@interface AutoRefreshTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSString * pangeNo;
@property(nonatomic,strong) NSString * pangeSize;
@property(nonatomic,strong) NSMutableArray * listData;

-(void)setupTableView;
-(void)setupTableViewWithCellHeightBlock:(CellHeightBlock)cellHeight andCellCreateBlock:(CellCreateBlock)createBlock;

-(void)showList:(NSArray*)customers;
-(void)addList:(NSArray*)customers;

@property (nonatomic, strong) ItemClickedBlock itemClickedBlock;
@property (nonatomic, strong) GetNextListBlock getNextListBlock;


@end
