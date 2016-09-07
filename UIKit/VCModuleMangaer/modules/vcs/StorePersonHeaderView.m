//
//  StorePersonHeaderView.m
//  mkt
//
//  Created by Eastern Phoenix on 15/7/14.
//  Copyright (c) 2014 biostime. All rights reserved.
//

#import "StorePersonHeaderView.h"
#import "NVUIGradientButton.h"
@implementation StorePersonHeaderView
DEF_SIGNAL(SEARCH_BUTTONCLICK)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    NVUIGradientButton *button = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(213, 6, 87, 30) cornerRadius:1 borderWidth:1 andText:@"搜索"];
    [button addTarget:self action:@selector(searchAct) forControlEvents:UIControlEventTouchUpInside];
    [button greenTheme];
    [self addSubview:button];
}

- (IBAction)searchAct:(id)sender {
    [self sendUISignal:[StorePersonHeaderView SEARCH_BUTTONCLICK] withObject:self.terminalField.text];
}
- (void)searchAct{
    [self sendUISignal:[StorePersonHeaderView SEARCH_BUTTONCLICK] withObject:self.terminalField.text];
}

@end
