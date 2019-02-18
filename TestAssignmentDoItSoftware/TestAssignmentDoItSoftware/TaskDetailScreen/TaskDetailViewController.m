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
    
    lblTaskTitle.text = @"task title";
    
}


-(void)goToEditScreen{
    
    EditTaskScreenViewController *editTaskScreen = [[EditTaskScreenViewController alloc] init];
    
    [self.navigationController pushViewController:editTaskScreen animated:YES];
    
}


-(void)setTaskDictionary:(NSDictionary *)dictionaryTask{
    
    dicTask = [[NSDictionary alloc] initWithDictionary:dictionaryTask];
    
}


- (IBAction)btnDeleteTaskTapped:(id)sender{
    
    NSLog(@"delete task tapped");
    
}


@end
