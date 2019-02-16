//
//  TableViewCell.m
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/16/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import "MyTaskTableViewCell.h"

@implementation MyTaskTableViewCell


@synthesize lblTaskNameLabel;
@synthesize lblDueToDateLabel;
@synthesize lblPriorityLabel;



- (void)awakeFromNib {

    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

}

@end
