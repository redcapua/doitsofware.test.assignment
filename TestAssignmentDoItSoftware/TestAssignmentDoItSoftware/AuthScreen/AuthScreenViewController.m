//
//  AuthScreenViewController.m
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import "AuthScreenViewController.h"

@interface AuthScreenViewController ()

@end

@implementation AuthScreenViewController


@synthesize tfLogin;
@synthesize tfPassword;
@synthesize btnAuth;
@synthesize swMode;


#pragma mark - screen related

- (void)viewDidLoad {

    [super viewDidLoad];

}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    UIColor *grayColor = [[UIColor alloc] initWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:130.0/255.0];

    tfLogin.layer.cornerRadius = 2.0;
    tfLogin.layer.borderWidth = 1.0;
    tfLogin.layer.borderColor = grayColor.CGColor;

    tfPassword.layer.cornerRadius = 2.0;
    tfPassword.layer.borderWidth = 1.0;
    tfPassword.layer.borderColor = grayColor.CGColor;

    btnAuth.layer.cornerRadius = 2.0;
    btnAuth.layer.borderWidth = 1.0;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"registrationfailed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authFailed:) name:@"registrationfailed" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"registrationdone" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authCompleted:) name:@"registrationdone" object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"authfailed" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authFailed:) name:@"authfailed" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"authdone" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authCompleted:) name:@"authdone" object:nil];

}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"registerfailed" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"registrationdone" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"authfailed" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"authdone" object:nil];

}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}


#pragma mark - app flow actions

- (IBAction)btnAuthTapped:(id)sender{

    NSLog(@"btnAuth");

    if ([self checkProvidedValues] == true){
        
        [self showActivity];
        
        TASingleton *singleton = [[TASingleton alloc] init];
        
        if ([singleton isConnected] == true){
            
            NSString *userName = tfLogin.text;
            NSString *password = tfPassword.text;
            
            BOOL modeLoginRegister = false;
            modeLoginRegister = [swMode isOn];

            if (modeLoginRegister == false){

                [singleton authUser:userName password:password];

            }else{

                [singleton registerUser:userName password:password];

            }
            
        }else{
            
            [self hideActivity];
            
        };
        
    }
    
}

- (IBAction)swModeChanged:(id)sender{
    
    NSLog(@"swMode");

    BOOL modeLoginRegister = false;
    modeLoginRegister = [swMode isOn];
    
    if (modeLoginRegister == false){
        //do login
        
        [btnAuth setTitle:@"LOG IN" forState:UIControlStateNormal];
        
    }else{
        //do register

        [btnAuth setTitle:@"REGISTER" forState:UIControlStateNormal];

    }
    
}


-(BOOL)checkLogin{
    
    BOOL result = false;
    
    if ([tfLogin.text length] > 0){
        result = true;
    }
    
    return result;
}


-(BOOL)checkPassword{
    
    BOOL result = false;
    
    if ([tfPassword.text length] > 0){
        result = true;
    }
    
    return result;
}


-(BOOL)checkProvidedValues{
    
    BOOL result = false;
    int resultStatus = 0;
    NSString *statusText = @"";
    
    if ([self checkLogin] == false){
        resultStatus = resultStatus + 1;
    }
    
    
    if ([self checkPassword] == false){
        resultStatus = resultStatus + 2;
    }
    
    
    switch (resultStatus) {
        case 0:{
            
            result = true;
            break;
        }
        case 1:{
            
            statusText = @"Please provide your login";
            break;
        }
        case 2:{
            
            statusText = @"Please provide your password";
            break;
        }
        case 3:{
            
            statusText = @"That login / password combination is not valid.";
            break;
        }
    }
    
    
    if (resultStatus > 0){

        [self showAlertMessage:@"Error!" message:statusText];

    }
    
    return result;
}


-(void)showAlertMessage:(NSString *)title message:(NSString *)message{
    
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:title  message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSInteger tagTextField = textField.tag;
    
    switch (tagTextField) {
        case 1:{
            [tfPassword becomeFirstResponder];
            break;
        }
        case 2:{
            [tfPassword resignFirstResponder];
            break;
        }
            
            
        default:
            break;
    }
    
    return YES;
}


-(void)dismissKeyboard{
    
    [self.view endEditing:YES];
    
}


#pragma mark - network interacting


-(void)authCompleted:(NSNotification *)notification{
    
    NSLog(@"auth completed");
    
    [self hideActivity];
    
    tfLogin.text = @"";
    tfPassword.text = @"";
    
    MyTaskListScreenViewController *myTaskListScreen = [[MyTaskListScreenViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:myTaskListScreen];

    [self presentViewController:navigationController animated:YES completion:nil];

    
}


-(void)authFailed:(NSNotification *)notification{
    
    NSLog(@"auth failed");
    
    [self hideActivity];
    
    NSDictionary *notificationDictionary = notification.userInfo;
    
    if(notificationDictionary == nil){
        return;
    }
    
    NSString *title = [notificationDictionary valueForKey:@"title"];
    NSString *message = [notificationDictionary valueForKey:@"message"];
    
    [self showAlertMessage:title message:message];
    
}


#pragma mark - activity indicator

-(void)showActivity{
    
    if (overlayView != nil){
        return;
    }
    
    overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = overlayView.center;
    [overlayView addSubview:activityIndicator];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication].keyWindow addSubview:overlayView];
    
}


-(void)hideActivity{
    
    if (overlayView != nil){
        [overlayView removeFromSuperview];
        overlayView = nil;
    }
    
}

@end
