//
//  DateDueScreenViewController.m
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/18/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import "DateDueScreenViewController.h"

@interface DateDueScreenViewController ()

@end

@implementation DateDueScreenViewController


@synthesize btnSetDateDueForTask;
@synthesize dpDateDue;


- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationController.navigationBar.topItem.title = @"Back";
    
    self.navigationItem.title = @"Edit task";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0];

}


- (IBAction)btnSetDateDueForTask:(id)sender{
    
#warning add check if date is in the past login has not been provided in description so it not implemented
    
    NSLog(@"set due date tapped");

    NSDate *dateMoment = dpDateDue.date;
    NSNumber *dueDateMoment = [NSNumber numberWithUnsignedInteger:[dateMoment timeIntervalSince1970]];
    
    NSLog(@"date moment is: %ld", (long)[dueDateMoment unsignedIntegerValue]);

    
    NSArray *viewControllers = self.navigationController.viewControllers;
    EditTaskScreenViewController *editTaskScreen = [viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
    [editTaskScreen setDateDue:dueDateMoment];

    [self.navigationController popViewControllerAnimated:YES];
    
    
}


@end
