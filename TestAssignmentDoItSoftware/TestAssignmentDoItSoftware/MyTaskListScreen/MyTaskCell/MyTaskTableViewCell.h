//
//  TableViewCell.h
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/16/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTaskTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTaskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lblDueToDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lblPriorityLabel;


@end

NS_ASSUME_NONNULL_END
