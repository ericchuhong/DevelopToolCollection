//
//  AutoRefreshTableView.m
//  mkt
//
//  Created by Harin Li on 6/18/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import "AutoRefreshTableView.h"

@implementation AutoRefreshTableView
{
    CellHeightBlock _cellHeightBlock;
    CellCreateBlock _cellCreateBlock;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupTableView];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        [self setupTableView];
    }
    return self;
}

-(void)setupTableView
{
    _listData = [NSMutableArray array];
    self.dataSource = self;
    self.delegate = self;
}

-(void)setupTableViewWithCellHeightBlock:(CellHeightBlock)cellHeight andCellCreateBlock:(CellCreateBlock)createBlock
{
    _listData = [NSMutableArray array];
    self.dataSource = self;
    self.delegate = self;
    _cellHeightBlock = cellHeight;
    _cellCreateBlock = createBlock;
}

-(void)showList:(NSArray*)customers
{
    [_listData removeAllObjects];
    [_listData addObjectsFromArray:customers];
    [self reloadData];
}

-(void)addList:(NSArray*)customers
{
    NSMutableArray * indexPaths = [NSMutableArray arrayWithCapacity:customers.count];
    for (int i = 0; i<customers.count; i++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:_listData.count+i inSection:0];
        [indexPaths addObject:indexPath];
    }
    if (indexPaths.count>0) {
        [_listData addObjectsFromArray:customers];
        [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        [self scrollToRowAtIndexPath:indexPaths[0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.itemClickedBlock)
        self.itemClickedBlock(indexPath.row, self.listData[indexPath.row]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_cellHeightBlock)
        return _cellHeightBlock(self,indexPath.row);
    return 69;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_cellCreateBlock)
        return _cellCreateBlock(self,indexPath.row);
    return nil;
}
@end
