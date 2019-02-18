//
//  EditTaskScreenViewController.m
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import "EditTaskScreenViewController.h"

@interface EditTaskScreenViewController ()

@end

@implementation EditTaskScreenViewController


@synthesize lblDueTo;


#pragma mark - UI view methods


- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.navigationController.navigationBar.topItem.title = @"Back";
    
    self.navigationItem.title = @"Edit task";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0];

    dateDue = [NSNumber numberWithInteger:0];
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSUInteger dateDueMoment = [dateDue unsignedIntegerValue];
    NSString *dateDueMomentStr = @"";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    
    if (dateDueMoment > 0){
        date = [NSDate dateWithTimeIntervalSince1970:[dateDue unsignedIntegerValue]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        dateDueMomentStr = [NSString stringWithFormat:@"Date due: %@", [dateFormatter stringFromDate:date]];
        
        NSLog(@"date: %@", dateDueMomentStr);

    }
    
    lblDueTo.text = dateDueMomentStr;
    
}


- (IBAction)btnDateDueTaskTapped:(id)sender{
    
    DateDueScreenViewController *dateDueScreen = [[DateDueScreenViewController alloc] init];
    
    [self.navigationController pushViewController:dateDueScreen animated:YES];
    
}


- (IBAction)scPriorityChanged:(id)sender{
    
    NSLog(@"Priority changed");
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}


-(void) setDateDue:(NSNumber *)dateDueIn{
    
    dateDue = dateDueIn;
    
}

@end
