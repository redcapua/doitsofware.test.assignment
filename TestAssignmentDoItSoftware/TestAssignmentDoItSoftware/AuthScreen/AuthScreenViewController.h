//
//  AuthScreenViewController.h
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AuthScreenViewController : UIViewController<UITextFieldDelegate>{
    
    UIView *overlayView;
    UIActivityIndicatorView *activityIndicator;
    
}


@property(strong, nonatomic) IBOutlet UITextField *tfLogin;
@property(strong, nonatomic) IBOutlet UITextField *tfPassword;
@property(strong, nonatomic) IBOutlet UIButton *btnAuth;
@property(strong, nonatomic) IBOutlet UISwitch *swMode;


- (IBAction)btnAuthTapped:(id)sender;
- (IBAction)swModeChanged:(id)sender;

-(BOOL)checkLogin;
-(BOOL)checkPassword;

-(void)showAlertMessage:(NSString *)title message:(NSString *)message;

-(void)authCompleted:(NSNotification *)notification;


@end


NS_ASSUME_NONNULL_END
