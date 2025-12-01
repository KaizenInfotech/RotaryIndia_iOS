//
//  MyCell.m
//  WYChart
//
//  Created by Umesh on 20/01/17.
//  Copyright © 2017 FreedomKing. All rights reserved.
//

#import "MyCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   // _viewCurve.layer.cornerRadius = 50;
    //_viewCurve.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
