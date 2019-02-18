//
//  DateDueScreenViewController.h
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/18/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditTaskScreenViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DateDueScreenViewController : UIViewController
//<UIPickerViewDelegate, UIPickerViewDataSource>


@property (weak, nonatomic) IBOutlet UIButton *btnSetDateDueForTask;
@property (weak, nonatomic) IBOutlet UIDatePicker *dpDateDue;


- (IBAction)btnSetDateDueForTask:(id)sender;


@end

NS_ASSUME_NONNULL_END
