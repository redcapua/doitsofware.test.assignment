//
//  EditTaskScreenViewController.h
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TASingleton.h"
#import "DateDueScreenViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditTaskScreenViewController : UIViewController{
    
    NSNumber *dateDue;
    NSMutableDictionary *dictionaryTask;
    NSNumber *tid;
    NSNumber *lid;
    NSNumber *priority;
    NSNumber *nid;
    NSNumber *status;
    NSString *title;
    NSString *details;
    NSString *prioritystr;
    NSNumber *shiftValue;
    
}


@property (weak, nonatomic) IBOutlet UILabel *lblDueTo;
@property (weak, nonatomic) IBOutlet UIButton *btnDateDueForTask;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveTask;
@property (weak, nonatomic) IBOutlet UITextView *tvTaskTitle;
@property (weak, nonatomic) IBOutlet UITextView *tvDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblLineUnderNotification;
@property (weak, nonatomic) IBOutlet UISwitch *swNotification;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scPriority;


- (IBAction)scPriorityChanged:(id)sender;
- (IBAction)btnDateDueTaskTapped:(id)sender;
- (IBAction)btnSaveTaskTapped:(id)sender;

-(void) setDateDue:(NSNumber *)dateDueIn;
-(void) setDictionaryTask:(NSDictionary *)dictionaryTaskIn;


@end

NS_ASSUME_NONNULL_END
