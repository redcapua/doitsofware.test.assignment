//
//  MyTaskListScreenViewController.m
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import "MyTaskListScreenViewController.h"

@interface MyTaskListScreenViewController ()

@end

@implementation MyTaskListScreenViewController


@synthesize tblTasks;

- (void)viewDidLoad {

    [super viewDidLoad];

    self.navigationItem.title = @"My Tasks";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];

    NSString *alarmImage = @"alarm.png";
    NSString *sortImage = @"sort.png";
    NSString *addImage = @"add.png";

    UIImage *alarmImg = [[UIImage imageNamed:alarmImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *sortImg = [[UIImage imageNamed:sortImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *addImg = [[UIImage imageNamed:addImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UIBarButtonItem *alarmButton = [[UIBarButtonItem alloc] initWithImage:alarmImg style:UIBarButtonItemStylePlain target:self action:@selector(goToAlarmScreen)];
    UIBarButtonItem *sortButton = [[UIBarButtonItem alloc] initWithImage:sortImg style:UIBarButtonItemStylePlain target:self action:@selector(goToSortScreen)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:addImg style:UIBarButtonItemStylePlain target:self action:@selector(goAddTaskScreen)];

    NSArray *actionButtons = [[NSArray alloc] initWithObjects:alarmButton, sortButton, nil];

    self.navigationItem.leftBarButtonItem = addButton;
    self.navigationItem.rightBarButtonItems = actionButtons;

    arrTasks = [[NSMutableArray alloc] init];

    [arrTasks addObject:@"jdsjdsjd"];
    [arrTasks addObject:@"sdfsf"];
    [arrTasks addObject:@"sdfsf"];
    [arrTasks addObject:@"sdfsf"];
    [arrTasks addObject:@"sdfsf"];
    [arrTasks addObject:@"sdfsf"];
    
    if (refreshControl == nil){
        refreshControl = [[UIRefreshControl alloc] init];
    }
    
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating tasks"];
    [refreshControl addTarget:self action:@selector(doRefresh) forControlEvents:UIControlEventValueChanged];
    [tblTasks addSubview:refreshControl];
    
}


-(void)goToAlarmScreen{
    
    NSLog(@"goToAlarmScreen");

}


-(void)goToSortScreen{
    
    SortOrderForTasksViewController *sortOrderForTasks = [[SortOrderForTasksViewController alloc] init];
    
    [self.navigationController pushViewController:sortOrderForTasks animated:YES];
    
}


-(void)goAddTaskScreen{
    
    NSLog(@"goAddTaskScreen");

}


-(void)doRefresh{
    
    NSLog(@"Do refresh");
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = @"text cell";

    MyTaskTableViewCell *myTaskTableViewCell = [tblTasks dequeueReusableCellWithIdentifier:@"MyTaskTableViewCell"];
    
    if (myTaskTableViewCell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MyTaskTableViewCell" owner:self options:nil];
        myTaskTableViewCell = [topLevelObjects objectAtIndex:0];
        
    }

    myTaskTableViewCell.backgroundColor = [UIColor clearColor];
    
    if ([myTaskTableViewCell respondsToSelector:@selector(setSeparatorInset:)]) {
        [myTaskTableViewCell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([myTaskTableViewCell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [myTaskTableViewCell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([myTaskTableViewCell respondsToSelector:@selector(setLayoutMargins:)]) {
        [myTaskTableViewCell setLayoutMargins:UIEdgeInsetsZero];
    }

    myTaskTableViewCell.lblTaskNameLabel.text = @"Complete this test assignment";
    myTaskTableViewCell.lblDueToDateLabel.text = @"Due to 19/02/19";
    myTaskTableViewCell.lblPriorityLabel.text = @"High";
    
    return myTaskTableViewCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger cntEvents = [arrTasks count];
    
    return cntEvents;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightOfRow = 69.0;
    
    return heightOfRow;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tblTasks deselectRowAtIndexPath:indexPath animated:YES];

    TaskDetailViewController *taskDetailScreen = [[TaskDetailViewController alloc] init];
    
    taskDetailScreen.lblTaskTitle.text = @"Title of the task";
    
    [self.navigationController pushViewController:taskDetailScreen animated:YES];
    
}

@end
