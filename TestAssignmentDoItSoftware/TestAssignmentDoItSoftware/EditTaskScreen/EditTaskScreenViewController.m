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


@synthesize lblDueTo;
@synthesize btnSaveTask;
@synthesize swNotification;
@synthesize lblLineUnderNotification;
@synthesize tvTaskTitle;
@synthesize tvDescription;
@synthesize btnDateDueForTask;
@synthesize scPriority;


#pragma mark - UI view methods


- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.navigationController.navigationBar.topItem.title = @"Back";
    
    self.navigationItem.title = @"Edit task";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0];

    dateDue = [NSNumber numberWithInteger:0];
    dictionaryTask = [[NSMutableDictionary alloc] init];
    
    tid = [NSNumber numberWithUnsignedInteger:0];
    lid = [NSNumber numberWithUnsignedInteger:0];
    priority = [NSNumber numberWithUnsignedInteger:1];
    nid = [NSNumber numberWithUnsignedInteger:0];
    status = [NSNumber numberWithUnsignedInteger:1];
    title = @"";
    details = @"";
    prioritystr = @"";

    tvTaskTitle.layer.borderColor = [UIColor blackColor].CGColor;
    tvTaskTitle.layer.borderWidth = 1.0;
    tvTaskTitle.layer.cornerRadius = 2.0;
    
    tvDescription.layer.borderColor = [UIColor blackColor].CGColor;
    tvDescription.layer.borderWidth = 1.0;
    tvDescription.layer.cornerRadius = 2.0;

    shiftValue = [NSNumber numberWithInt:175];
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([dateDue unsignedIntegerValue] > 0){
        
        [self formatDueDate];
        
        return;
    }
    
    NSArray *keys = [dictionaryTask allKeys];
    
    if ([keys count] == 0){
        
        TASingleton *singleton = [[TASingleton alloc] init];
        
        if ([lid unsignedIntegerValue] == 0){
            lid = [singleton getNewId];
        }
        
        priority = [NSNumber numberWithUnsignedInteger:0];
        [self scPriorityChanged:scPriority];
        
        NSDate *from1970 = [[NSDate alloc] initWithTimeIntervalSinceNow:86400];
        dateDue = [NSNumber numberWithUnsignedInteger:[[NSNumber numberWithUnsignedInteger:[from1970 timeIntervalSince1970]] unsignedIntegerValue]];
        
    }else{

        tid = [dictionaryTask valueForKey:@"tid"];
        lid = [dictionaryTask valueForKey:@"lid"];
        priority = [dictionaryTask valueForKey:@"priority"];
        nid = [dictionaryTask valueForKey:@"nid"];
        dateDue = [dictionaryTask valueForKey:@"dateto"];
        title = [dictionaryTask valueForKey:@"title"];
        details = [dictionaryTask valueForKey:@"details"];
        prioritystr = [dictionaryTask valueForKey:@"prioritystr"];

    }

    status = [NSNumber numberWithUnsignedInteger:1];
    
    if (nid > 0){
        [swNotification setOn:YES];
    }
    
    [self formatDueDate];
    
    tvTaskTitle.text = title;
    tvDescription.text = details;
    
    scPriority.selectedSegmentIndex = [priority unsignedIntegerValue];
    
}


- (IBAction)btnDateDueTaskTapped:(id)sender{
    
    DateDueScreenViewController *dateDueScreen = [[DateDueScreenViewController alloc] init];
    
    [self.navigationController pushViewController:dateDueScreen animated:YES];
    
}


- (IBAction)scPriorityChanged:(id)sender{

    
    switch ([priority unsignedIntegerValue]) {
        case 0:{
            
            prioritystr = @"Low";
            break;
        }
        case 1:{

            prioritystr = @"Medium";
            break;
        }
        case 2:{
    
            prioritystr = @"High";
            break;
        }
    }
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}


-(void) setDateDue:(NSNumber *)dateDueIn{
    
    dateDue = dateDueIn;
    
}


- (IBAction)btnSaveTaskTapped:(id)sender{

    NSLog(@"save task tapped");

    title = tvTaskTitle.text;
    details = tvDescription.text;
    
    NSMutableDictionary *dictionaryTask = [[NSMutableDictionary alloc] init];
    
    [dictionaryTask setValue:tid forKey:@"tid"];
    [dictionaryTask setValue:lid forKey:@"lid"];
    [dictionaryTask setValue:title forKey:@"title"];

    [dictionaryTask setValue:priority forKey:@"priority"];
    [dictionaryTask setValue:nid forKey:@"nid"];
    [dictionaryTask setValue:status forKey:@"status"];

    [dictionaryTask setValue:dateDue forKey:@"dateto"];
    [dictionaryTask setValue:details forKey:@"details"];
    [dictionaryTask setValue:prioritystr forKey:@"prioritystr"];

    TASingleton *singleton = [[TASingleton alloc] init];
    [singleton addTask:dictionaryTask taskId:lid];

    //if notification date is in the past - do not save notification
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if ([[viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2] isKindOfClass:[TaskDetailViewController class]] == YES){

        TaskDetailViewController *taskDetailScreen = [viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
        [taskDetailScreen setTaskDictionary:dictionaryTask];

    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void) setDictionaryTask:(NSDictionary *)dictionaryTaskIn{
    
    dictionaryTask = [[NSMutableDictionary alloc] initWithDictionary:dictionaryTaskIn];
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView{

    if (textView.tag == 2){

        [self moveUp:shiftValue];

    }
    
}


- (void)textViewDidEndEditing:(UITextView *)textView{
    

    if (textView.tag == 2){
        
        [self moveDown:shiftValue];

    }
    
}


-(void)moveUp:(NSNumber *)moveUpValue{
    
    NSLog(@"moveUp");
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.view.frame = CGRectMake(0, self.view.frame.origin.y - [moveUpValue floatValue], self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:^(BOOL finished) {
        if (finished) {
        }
    }];
    
}


-(void)moveDown:(NSNumber *)moveDownValue{
    
    
    NSLog(@"moveDown");
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.view.frame = CGRectMake(0, self.view.frame.origin.y + [moveDownValue floatValue], self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:^(BOOL finished) {
        if (finished) {
        }
    }];
    
}


-(void)formatDueDate{
    
    NSUInteger dateDueMoment = [dateDue unsignedIntegerValue];
    NSString *dateDueMomentStr = @"Due date is not set";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    
    if (dateDueMoment > 0){
        date = [NSDate dateWithTimeIntervalSince1970:[dateDue unsignedIntegerValue]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        dateDueMomentStr = [NSString stringWithFormat:@"Date due: %@", [dateFormatter stringFromDate:date]];
        
        NSLog(@"date: %@", dateDueMomentStr);
        NSLog(@"date moment: %ld", (long) [dateDue unsignedIntegerValue]);
        
    }
    
    lblDueTo.text = dateDueMomentStr;

}

@end
