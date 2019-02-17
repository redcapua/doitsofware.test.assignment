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

- (void)viewDidLoad {

    [super viewDidLoad];

    self.navigationItem.title = @"Tasks details";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    
//    NSString *editImage = @"edit.png";
//
//    UIImage *editImg = [[UIImage imageNamed:editImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithImage:editImg style:UIBarButtonItemStylePlain target:self action:@selector(goToEditScreen)];
//
//    self.navigationItem.rightBarButtonItem = editButton;

}



@end
