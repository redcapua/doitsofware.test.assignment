//
//  EditTaskScreenViewController.h
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateDueScreenViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditTaskScreenViewController : UIViewController{
    
    NSNumber *dateDue;
    
}


@property (weak, nonatomic) IBOutlet UILabel *lblDueTo;
@property (weak, nonatomic) IBOutlet UIButton *btnDateDueForTask;


@property (weak, nonatomic) IBOutlet UILabel *lblTaskTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPriority;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblNotification;
@property (weak, nonatomic) IBOutlet UILabel *lblLineUnderNotification;
@property (weak, nonatomic) IBOutlet UISwitch *swNotification;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteTask;


- (IBAction)scPriorityChanged:(id)sender;
- (IBAction)btnDateDueTaskTapped:(id)sender;

-(void) setDateDue:(NSNumber *)dateDueIn;


@end

NS_ASSUME_NONNULL_END
