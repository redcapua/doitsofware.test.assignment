//
//  AppDelegate.h
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "AuthScreen/AuthScreenViewController.h"

#define appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)


@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL localNotifications;
@property (strong, nonatomic) NSString *token;

@end

