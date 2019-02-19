//
//  SortOrderForTasksViewController.m
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/17/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import "SortOrderForTasksViewController.h"

@interface SortOrderForTasksViewController ()


@end


@implementation SortOrderForTasksViewController


@synthesize tblOrderOptions;


#pragma mark - UI view methods


- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationController.navigationBar.topItem.title = @"Back";
    
    self.navigationItem.title = @"Task order";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0];

    arrSortOptions = [[NSMutableArray alloc] init];
    
    [arrSortOptions addObject:@"Name (asc)"];
    [arrSortOptions addObject:@"Name (desc)"];
    [arrSortOptions addObject:@"Priotiry (asc)"];
    [arrSortOptions addObject:@"Priotiry (desc)"];
    [arrSortOptions addObject:@"Date (asc)"];
    [arrSortOptions addObject:@"Date (desc)"];
    
}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSInteger indexPathRow = [[NSUserDefaults standardUserDefaults] integerForKey:@"sortOrder"];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexPathRow inSection:0];
    [tblOrderOptions selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    
}


#pragma mark - UI tableview


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    NSInteger indexPosition = indexPath.row;
    NSString *orderName = [arrSortOptions objectAtIndex:indexPosition];
    
    cell.textLabel.text = orderName;
    
    return cell;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger cntEvents = [arrSortOptions count];
    
    return cntEvents;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat heightOfRow = 37.0;
    
    return heightOfRow;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"sortOrder"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


@end
