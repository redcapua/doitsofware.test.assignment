//
//  MyTaskListScreenViewController.h
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTaskCell/MyTaskTableViewCell.h"
#import "TaskDetailViewController.h"
#import "SortOrderForTasksViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface MyTaskListScreenViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
 
    UIRefreshControl *refreshControl;
    NSMutableArray *arrTasks;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tblTasks;


@end

NS_ASSUME_NONNULL_END
