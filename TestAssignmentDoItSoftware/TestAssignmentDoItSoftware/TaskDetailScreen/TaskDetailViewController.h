//
//  TaskDetailViewController.h
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditTaskScreenViewController.h"


NS_ASSUME_NONNULL_BEGIN


@interface TaskDetailViewController : UIViewController{
    
    NSDictionary *dictionaryTask;
    
}


@property (weak, nonatomic) IBOutlet UILabel *lblTaskTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDueTo;
@property (weak, nonatomic) IBOutlet UILabel *lblPriority;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblNotification;
@property (weak, nonatomic) IBOutlet UILabel *lblLineUnderNotification;
@property (weak, nonatomic) IBOutlet UISwitch *swNotification;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteTask;


-(void)setTaskDictionary:(NSDictionary *)dictionaryTaskIn;
- (IBAction)btnDeleteTaskTapped:(id)sender;


@end

NS_ASSUME_NONNULL_END
