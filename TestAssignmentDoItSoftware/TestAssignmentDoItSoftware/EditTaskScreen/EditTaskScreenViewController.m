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


#pragma mark - UI view methods


- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.navigationController.navigationBar.topItem.title = @"Back";
    
    self.navigationItem.title = @"Edit task";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0];

}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
}


- (IBAction)scPriorityChanged:(id)sender{
    
    NSLog(@"Priority changed");
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}


@end
