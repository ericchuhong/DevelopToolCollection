//
//  SearchStorePersonVC.m
//  mkt
//
//  Created by Eastern Phoenix on 2/7/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import "SearchStorePersonVC.h"

@interface SearchStorePersonVC ()

@end

@implementation SearchStorePersonVC

TTS_DEF_XIB(SearchStorePersonVC, YES, NO);

ON_SIGNAL2(BeeUIBoard, signal)
{
    [super handleUISignal:signal];
    
    if([signal isKindOf:BeeUIBoard.CREATE_VIEWS])
    {
        [self setupView];

    }
    else if([signal isKindOf:BeeUIBoard.LAYOUT_VIEWS])
    {
        
    }
    else if([signal isKindOf:BeeUIBoard.DELETE_VIEWS])
    {
        
    }
    else if ( [signal is:BeeUIBoard.WILL_APPEAR] )
	{
        
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

- (void)setupView{
    [self setupTableView];
    self.view.backgroundColor = [UIColor c1_10];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:gesture];
}

- (void)tapView{
    [self.personIdField resignFirstResponder];
}




+ (instancetype)searchStorePersonVC{
    SearchStorePersonVC *searVc = [[SearchStorePersonVC alloc] init];
    searVc.view.autoresizingMask = NO;
    searVc.view.frame = [UILayoutHelper getModuleContentRect];
    return searVc;
}
- (IBAction)SearchStorePerson:(id)sender {
}
@end
