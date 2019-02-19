//
//  TaskDetailViewController.m
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import "TaskDetailViewController.h"

@interface TaskDetailViewController ()


@end


@implementation TaskDetailViewController


@synthesize lblTaskTitle;
@synthesize lblDueTo;
@synthesize lblPriority;
@synthesize lblDescription;
@synthesize lblNotification;
@synthesize swNotification;
@synthesize lblLineUnderNotification;
@synthesize btnDeleteTask;


#pragma mark - UI view methods


- (void)viewDidLoad {

    [super viewDidLoad];

    self.navigationController.navigationBar.topItem.title = @"Back";
    
    self.navigationItem.title = @"Tasks details";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0];

    NSString *editImage = @"edit.png";
    
    UIImage *editImg = [[UIImage imageNamed:editImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithImage:editImg style:UIBarButtonItemStylePlain target:self action:@selector(goToEditScreen)];
    
    self.navigationItem.rightBarButtonItem = editButton;

}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    lblTaskTitle.text = [dictionaryTask valueForKey:@"title"];
    lblDescription.text = [dictionaryTask valueForKey:@"details"];
    lblPriority.text = [dictionaryTask valueForKey:@"prioritystr"];

    NSNumber *dateDue = [dictionaryTask valueForKey:@"dateto"];

    if ([dateDue unsignedIntegerValue] > 0){

        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateDue unsignedIntegerValue]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE dd MMM, YYYY"];
        NSString *dateDueMomentStr = [dateFormatter stringFromDate:date];
        
        lblDueTo.text = dateDueMomentStr;
        
        NSLog(@"date: %@", dateDueMomentStr);
        NSLog(@"date moment: %ld", (long) [dateDue unsignedIntegerValue]);

    }
    
    NSNumber *nid = [dictionaryTask valueForKey:@"nid"];

    if ([nid unsignedIntegerValue] > 0){
        
        [swNotification setOn:YES];
        
    }else{
        
        [swNotification setOn:NO];

        [lblNotification setHidden:YES];
        [swNotification setHidden:YES];
        [lblLineUnderNotification setHidden:YES];
        
    }
    
    
}


-(void)goToEditScreen{
    
    EditTaskScreenViewController *editTaskScreen = [[EditTaskScreenViewController alloc] init];
    
    [editTaskScreen setDictionaryTask:dictionaryTask];
    
    [self.navigationController pushViewController:editTaskScreen animated:YES];
    
}


-(void)setTaskDictionary:(NSDictionary *)dictionaryTaskIn{
    
    dictionaryTask = [[NSDictionary alloc] initWithDictionary:dictionaryTaskIn];
    
}


- (IBAction)btnDeleteTaskTapped:(id)sender{
    
    NSLog(@"delete task tapped");
    
    NSMutableDictionary *mutableDictionaryTask = [[NSMutableDictionary alloc] initWithDictionary:dictionaryTask];
    
    NSNumber *lid = [dictionaryTask valueForKey:@"lid"];
    NSNumber *status = [NSNumber numberWithUnsignedInteger:3];
    [mutableDictionaryTask setValue:status forKey:@"status"];
    
    TASingleton *singleton = [[TASingleton alloc] init];
    [singleton addTask:mutableDictionaryTask taskId:lid];

    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
