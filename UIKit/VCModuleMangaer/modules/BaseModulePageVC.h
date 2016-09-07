//
//  BaseModulePageVC.h
//  mkt
//
//  Created by Harin Li on 6/13/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import "Bee_UIBoard.h"
#import "Bee.h"
#import "UILayoutHelper.h"

typedef void (^WillAppearBlock)();
typedef void (^WillDisappearBlock)();
typedef void (^OnCellClickBlock)(NSInteger row,NSObject* data);
typedef void (^OnButtonClickBlock)(NSInteger tag,NSObject* data);

typedef void (^QueryMemberBtnClicked)();
typedef void (^SearchNextPageBlock)(NSInteger tag,NSObject * data,NSString * pageNo,NSString *pageSize);

@interface BaseModulePageVC : BeeUIBoard
@property (nonatomic, strong) SearchNextPageBlock searchNextPageBlock;
@property (nonatomic, strong) WillAppearBlock appearBlock;
@property (nonatomic, strong) WillDisappearBlock diappearBlock;
@property (nonatomic, strong) OnCellClickBlock cellClickBlock;
@property (nonatomic, strong) OnButtonClickBlock buttonClickBlock;
@property(nonatomic, strong)QueryMemberBtnClicked queryMemberBtnClicked;
@property(strong,nonatomic) NSMutableDictionary * moduleData;


@end
