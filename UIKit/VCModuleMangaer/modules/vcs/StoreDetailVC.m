//
//  StoreDetailVC.m
//  mkt
//
//  Created by edwin on 14-6-16.
//  Copyright (c) 2014年 biostime. All rights reserved.
//

#import "StoreDetailVC.h"
#import "TerminalDetailsInfo.h"
#import "DetailInfo.h"
#import "StoreDetailCell.h"
#import "AddressHelper.h"


@interface StoreDetailVC ()
{
    TerminalDetailsInfo *_terminalDetailsInfo;
}

@end

@implementation StoreDetailVC
TTS_DEF_XIB(StoreDetailVC, YES, NO)

ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        //self.view.backgroundColor = [UIColor c1_10];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        //self.tableView.allowsSelection = NO;
        [self setupDetailView];

        ((UIScrollView*)self.view).contentSize = [UILayoutHelper get5sModuleContentRect].size;

    }
    else if([signal isKindOf:BeeUIBoard.LAYOUT_VIEWS])
    {
        
    }
    else if([signal isKindOf:BeeUIBoard.DELETE_VIEWS])
    {
        
    }
    else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
	{
        self.appearBlock();
	}
	else if ( [signal is:BeeUIBoard.DID_APPEAR] )
	{
        
	}
	else if ( [signal is:BeeUIBoard.WILL_DISAPPEAR] )
	{
        
    }
	else if ( [signal is:BeeUIBoard.DID_DISAPPEAR] )
	{
	}
}

- (void)setupDetailView
{
    for (int i = 0; i < 6; i++) {
        UILabel *label = (UILabel *)[self.contentView1 viewWithTag:100+i];
        label.textColor = [UIColor c3_6];
    }
    
    for (int i = 0; i < 3; i++) {
        UILabel *label = (UILabel *)[self.contentView2 viewWithTag:100+i];
        label.textColor = [UIColor c3_10];
    }
    self.contentView1.backgroundColor = [UIColor whiteColor];
    self.contentView2.backgroundColor = [UIColor c1_10];
    self.contentView3.backgroundColor = [UIColor c1_10];
}

+(instancetype)storeDetailVC
{
    StoreDetailVC * storeDetailVC = [[StoreDetailVC alloc] init];
    storeDetailVC.view.autoresizingMask = UIViewAutoresizingNone;
    storeDetailVC.view.frame = [UILayoutHelper getModuleContentRect];

    return storeDetailVC;
}

-(void)showStoreDetail:(NSObject*)data
{
    _terminalDetailsInfo = (TerminalDetailsInfo *)data;
    self.dayPointLabel.text = _terminalDetailsInfo.noVisit;
    self.exchange1Label.text = _terminalDetailsInfo.exchangeWarm;
    self.exchange2Label.text = _terminalDetailsInfo.exchangeWarm1;
    self.milkOutFlow3Label.text = _terminalDetailsInfo.milkOutFlow2;
    self.milkOutFlow2Label.text = _terminalDetailsInfo.milkOutFlow1;
    self.milkOutFlow1Label.text = _terminalDetailsInfo.milkOutFlow;
    
    DetailInfo *detailInfo = _terminalDetailsInfo.info;
    [self.tableView reloadData];
//    if ([detailInfo.isVip isEqualToString:@"false"]) {
//        self.vipImage.hidden = YES;
//    } else {
//        self.vipImage.hidden = NO;
//    }
//    
//    if ([detailInfo.isCard isEqualToString:@"false"]) {
//        self.cardImage.hidden = YES;
//    } else {
//        self.cardImage.hidden = NO;
//    }
    
//    if ([detailInfo.isExchange isEqualToString:@"false"]) {
//        self.exchangeImage.hidden = YES;
//    } else {
//        self.exchangeImage.hidden = NO;
//    }
    
    [self setupViewWithData:detailInfo];
}

- (void)setupViewWithData:(DetailInfo *)detailInfo
{
    NSString *addressText = [NSString stringWithFormat:@"门店地址：%@",detailInfo.address];
    CGSize addressSize = [addressText sizeWithFont:[UIFont systemFontOfSize:12.0] byWidth:210];
    CGFloat addHeigth = addressSize.height - _adressLabel.height;
    self.adressLabel.text = addressText;
    self.adressLabel.frame = CGRectMake(_adressLabel.x, _adressLabel.y, addressSize.width, addressSize.height);
    self.contentView1.frame = CGRectMake(_contentView1.x, _contentView1.y, _contentView1.width, _contentView1.height+addHeigth);
    self.contentView2.frame = CGRectMake(_contentView2.x, _contentView2.y+addHeigth, _contentView2.width, _contentView2.height);
    self.contentView3.frame = CGRectMake(_contentView3.x, _contentView3.y+addHeigth, _contentView3.width, _contentView3.height);
    self.distanceView.frame = CGRectMake(_distanceView.x, _adressLabel.y+_adressLabel.height + d10, _distanceView.width, _distanceView.height);
    self.sperView.frame = CGRectMake(_sperView.x, _contentView1.height-1, _sperView.width, _sperView.height);
    self.storeNameLabel.text = detailInfo.terminalName;
    self.storeNoLabel.text = detailInfo.terminalCode;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@分",detailInfo.remainingPoint];
//    self.adressLabel.text = [AddressHelper cutProvinceAndCity:detailInfo.address];
    self.distanceLabel.text = detailInfo.location;

    if([detailInfo.chanelCode isEqualToString:@"01"]){
        self.userImage.image = [UIImage imageNamed:@"ico_baby_store.png"];
    }else if ([detailInfo.chanelCode isEqualToString:@"02"]){
        self.userImage.image = [UIImage imageNamed:@"ico_super_market.png"];
    }else if([detailInfo.chanelCode isEqualToString:@"03"]){
        self.userImage.image = [UIImage imageNamed:@"ico_medical_store.png"];
    }else if([detailInfo.chanelCode isEqualToString:@"04"]){
        self.userImage.image = [UIImage imageNamed:@"ico_SA.png"];
    }
    
    UIView *line = [self.contentView1 viewWithTag:200];
    line.height = 0.35  ;
    line.backgroundColor = [UIColor c3_3];
    for(int i = 1;i < 3;i++)
    {
        UIView *line = [self.contentView2 viewWithTag:200+i];
        line.height = 0.35;
        line.backgroundColor = [UIColor c3_3];
    }
//    self.personCountLabel.text = [NSString stringWithFormat:@"%@人",detailInfo.meberNum];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *data = @[@[@"积分",_terminalDetailsInfo.dayPointNum,_terminalDetailsInfo.pointNum],@[@"品项新客",_terminalDetailsInfo.dayNewCustomerNum,_terminalDetailsInfo.customerNewNum],@[@"客户数",_terminalDetailsInfo.dayCustomerNum,_terminalDetailsInfo.customerNum]];
    static NSString *cellIdefiny = @"storeDetai";
    StoreDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdefiny];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetailCell" owner:self options:nil] lastObject];
    }
    cell.testData = data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cellClickBlock(indexPath.row,_terminalDetailsInfo.info.terminalCode);
}

- (IBAction)clickedAction:(UIButton *)sender
{
    self.buttonClickBlock(sender.tag,_terminalDetailsInfo.info.terminalCode);
}

@end
