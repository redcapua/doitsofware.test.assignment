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


@synthesize tblReminders;


#pragma mark - UI view methods


- (void)viewDidLoad {

    [super viewDidLoad];

    self.navigationController.navigationBar.topItem.title = @"Back";
    
    self.navigationItem.title = @"Reminders";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0];

    arrReminders = [[NSArray alloc] init];
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    TASingleton *singleton = [[TASingleton alloc] init];
    arrReminders = [singleton getNotifications];
    
    [tblReminders reloadData];

}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];

    UNUserNotificationCenter *localNotificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    
    [localNotificationCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {

        if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) {

            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Error"  message:@"Local notifications are not granted :(" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];

        }

    }];
    
    
}


#pragma mark - UI tableview


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    NSDictionary *task = [arrReminders objectAtIndex:indexPath.row];
    NSString *title = [task valueForKey:@"title"];
    cell.textLabel.text = title;
    
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


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL result = YES;
    
    return result;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSDictionary *dictionaryTask = [arrReminders objectAtIndex:indexPath.row];
        
        NSMutableDictionary *mutableDictionaryTask = [[NSMutableDictionary alloc] initWithDictionary:dictionaryTask];
        
        NSNumber *lid = [dictionaryTask valueForKey:@"lid"];
        NSNumber *nid = [NSNumber numberWithUnsignedInteger:0];
        [mutableDictionaryTask setValue:nid forKey:@"nid"];
        
        TASingleton *singleton = [[TASingleton alloc] init];
        [singleton addTask:mutableDictionaryTask taskId:lid];
        
        arrReminders = [singleton getNotifications];
        
        [tblReminders reloadData];

    }
}


@end
