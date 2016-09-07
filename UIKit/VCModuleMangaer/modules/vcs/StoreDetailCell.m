//
//  StoreDetailCell.m
//  mkt
//
//  Created by edwin on 14-6-17.
//  Copyright (c) 2014年 biostime. All rights reserved.
//

#import "StoreDetailCell.h"
#import "Bee.h"
@implementation StoreDetailCell
{
    UIView *lineView;
}
- (void)awakeFromNib
{
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.firstLabel.text = (NSString *)self.testData[0];
    self.secondLabel.text = (NSString *)self.testData[1];
    self.thirdLabel.text = (NSString *)self.testData[2];
    lineView = nil;
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.height-1, self.contentView.width, 0.35)];
    lineView.backgroundColor = [UIColor c3_3];
    [self.contentView addSubview:lineView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    self.contentView.backgroundColor = [UIColor c3_2];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    self.contentView.backgroundColor = [UIColor c3_2];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    self.contentView.backgroundColor = [UIColor whiteColor];
}


@end
