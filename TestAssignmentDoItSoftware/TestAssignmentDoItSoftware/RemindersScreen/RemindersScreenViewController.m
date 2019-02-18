//
//  RemindersScreenViewController.m
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/18/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import "RemindersScreenViewController.h"

@interface RemindersScreenViewController ()

@end

@implementation RemindersScreenViewController


#pragma mark - UI view methods


- (void)viewDidLoad {

    [super viewDidLoad];

    self.navigationController.navigationBar.topItem.title = @"Back";
    
    self.navigationItem.title = @"Reminders";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0];

    arrReminders = [[NSMutableArray alloc] init];
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [arrReminders removeAllObjects];
    
    [arrReminders addObject:@"Title #1"];
    [arrReminders addObject:@"Title #2"];
    [arrReminders addObject:@"Title #3"];
    [arrReminders addObject:@"Title #4"];
    [arrReminders addObject:@"Title #5"];

}


#pragma mark - UI tableview


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    NSInteger indexPosition = indexPath.row;
    NSString *orderName = [arrReminders objectAtIndex:indexPosition];
    
    cell.textLabel.text = orderName;
    
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger cntEvents = [arrReminders count];
    
    return cntEvents;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightOfRow = 37.0;
    
    return heightOfRow;
}

@end
