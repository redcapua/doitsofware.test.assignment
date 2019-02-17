//
//  SortOrderForTasksViewController.h
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/17/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SortOrderForTasksViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *arrSortOptions;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tblOrderOptions;


@end

NS_ASSUME_NONNULL_END
