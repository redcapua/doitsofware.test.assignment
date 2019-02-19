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


#pragma mark - UI view methods


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

    arrTasks = [[NSArray alloc] init];
    
    if (refreshControl == nil){
        refreshControl = [[UIRefreshControl alloc] init];
    }
    
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating tasks"];
    [refreshControl addTarget:self action:@selector(doRefresh) forControlEvents:UIControlEventValueChanged];
    [tblTasks addSubview:refreshControl];
    
}


-(void)goToAlarmScreen{
    
    RemindersScreenViewController *remindersScreen = [[RemindersScreenViewController alloc] init];
    
    [self.navigationController pushViewController:remindersScreen animated:YES];
    
}


-(void)goToSortScreen{
    
    SortOrderForTasksViewController *sortOrderForTasks = [[SortOrderForTasksViewController alloc] init];
    
    [self.navigationController pushViewController:sortOrderForTasks animated:YES];
    
}


-(void)goAddTaskScreen{
    
    NSLog(@"goAddTaskScreen");

    EditTaskScreenViewController *editTaskScreen = [[EditTaskScreenViewController alloc] init];
    
    NSMutableDictionary *dictionaryTask = [[NSMutableDictionary alloc] init];
    [editTaskScreen setDictionaryTask:dictionaryTask];

    [self.navigationController pushViewController:editTaskScreen animated:YES];
    
}


-(void)doRefresh{
    
    NSLog(@"Do refresh");
    
    TASingleton *singleton = [[TASingleton alloc] init];
    arrTasks = [singleton getTasks];
    
    [tblTasks reloadData];

    [self stopTableRefresh];
    
}


-(void)stopTableRefresh{
    
    [refreshControl endRefreshing];
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self doRefresh];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    UNUserNotificationCenter *localNotificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    
    [localNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
        if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) {
            
            appDelegate.localNotifications = false;
            
        }else{
            
            appDelegate.localNotifications = true;
            
        }
        
    }];

    NSLog(@"token: %@", appDelegate.token);
    
}


#pragma mark - UI tableview


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

    NSDictionary *task = [arrTasks objectAtIndex:indexPath.row];
    
    NSString *title = [task valueForKey:@"title"];
    NSString *priorityStr = [task valueForKey:@"prioritystr"];

    myTaskTableViewCell.lblTaskNameLabel.text = title;
    myTaskTableViewCell.lblDueToDateLabel.text = @"Due to 19/02/19";
    myTaskTableViewCell.lblPriorityLabel.text = priorityStr;
    
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
    
    NSDictionary *dictionaryTask = [arrTasks objectAtIndex:indexPath.row];
    [taskDetailScreen setTaskDictionary:dictionaryTask];
    
    [self.navigationController pushViewController:taskDetailScreen animated:YES];
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL result = YES;
    
    return result;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDictionary *dictionaryTask = [arrTasks objectAtIndex:indexPath.row];

        NSMutableDictionary *mutableDictionaryTask = [[NSMutableDictionary alloc] initWithDictionary:dictionaryTask];
        
        NSNumber *lid = [dictionaryTask valueForKey:@"lid"];
        NSNumber *status = [NSNumber numberWithUnsignedInteger:3];
        [mutableDictionaryTask setValue:status forKey:@"status"];
        
        TASingleton *singleton = [[TASingleton alloc] init];
        [singleton addTask:mutableDictionaryTask taskId:lid];

        [self doRefresh];
        
    }
}


@end
