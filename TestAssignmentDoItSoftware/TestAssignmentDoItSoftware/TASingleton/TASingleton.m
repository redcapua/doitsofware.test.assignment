//
//  TASingleton.m
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import "TASingleton.h"

@implementation TASingleton

@synthesize managedObjectModel;
@synthesize managedObjectContext;
@synthesize persistentContainer = _persistentContainer;
@synthesize userInfo;

#pragma mark - singleton global procedures

+ (TASingleton *)sharedInstance{

    static TASingleton *sharedInstance = nil;
    
    static dispatch_once_t predicate;
    dispatch_once( &predicate, ^{
        sharedInstance = [[ self alloc ] init];
    });
    
    return sharedInstance;
}

#pragma mark - Core Data procedures

-(NSNumber *)getNewId{
    
    NSDate *from1970 = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    NSNumber *newid = [NSNumber numberWithUnsignedInteger:[[NSNumber numberWithUnsignedInteger:[from1970 timeIntervalSince1970]] unsignedIntegerValue]];

    return newid;
}


-(void)addTask:(NSMutableDictionary *)dictionaryTask taskId:(NSNumber *)lidNumber{
    
    Tasks *task;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tasks" inManagedObjectContext:self.managedObjectContext];

    NSPredicate *predicateLid = [NSPredicate predicateWithFormat:@"lid = %@", [dictionaryTask valueForKey:@"lid"]];

    NSPredicate *compPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicateLid, nil]];
    [fetchRequest setPredicate:compPredicate];

    NSError *requestError = nil;
    
    [fetchRequest setIncludesPendingChanges:YES];
    [fetchRequest setEntity:entity];
    
    NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    NSLog(@"records in Tasks: %ld", (long) [items count]);

    if ([items count] > 0){
        task = [items objectAtIndex:0];
    }else{
        task = [NSEntityDescription insertNewObjectForEntityForName:@"Tasks" inManagedObjectContext:self.managedObjectContext];
    }
    
    [task setValuesForKeysWithDictionary:[NSDictionary dictionaryWithDictionary:dictionaryTask]];
    
    NSError *savingError;
    
    @try {
        
        if ([self.managedObjectContext save:&savingError]){
            NSLog(@"Tasks saved Ok");
        }else{
            NSLog(@"error %@", savingError);
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"exception: %@", [exception debugDescription]);
        
    }

}


-(NSArray *)getTasks{
    
    NSArray *resultArray;
    NSMutableArray *fetchedTasks = [[NSMutableArray alloc] init];
    Tasks *task;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tasks" inManagedObjectContext:self.managedObjectContext];
    
    NSNumber *status = [NSNumber numberWithUnsignedInteger:3];

    NSPredicate *predicateLid = [NSPredicate predicateWithFormat:@"status < %@", status];
    
    NSPredicate *compPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicateLid, nil]];
    [fetchRequest setPredicate:compPredicate];
    
    NSInteger sortOrder = [[NSUserDefaults standardUserDefaults] integerForKey:@"sortOrder"];

    NSSortDescriptor *sortingPredicate;

    
    switch (sortOrder) {
        case 0:{
            
            sortingPredicate = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
            break;
        }
        case 1:{
            sortingPredicate = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];
            break;
        }
        case 2:{

            sortingPredicate = [[NSSortDescriptor alloc] initWithKey:@"priority" ascending:YES];
            break;
        }
        case 3:{
            
            sortingPredicate = [[NSSortDescriptor alloc] initWithKey:@"priority" ascending:NO];
            break;
        }
        case 4:{
            
            sortingPredicate = [[NSSortDescriptor alloc] initWithKey:@"dateto" ascending:YES];
            break;
        }
        case 5:{
            
            sortingPredicate = [[NSSortDescriptor alloc] initWithKey:@"dateto" ascending:NO];
            break;
        }

    }

    NSArray *arrSortOrder = [[NSArray alloc] initWithObjects:sortingPredicate, nil];
    fetchRequest.sortDescriptors = arrSortOrder;

    
    NSError *requestError = nil;
    
    [fetchRequest setIncludesPendingChanges:YES];
    [fetchRequest setEntity:entity];
    
    NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    NSLog(@"records in Tasks: %ld", (long) [items count]);

    for (task in items) {

        NSArray *keys = [[[task entity] attributesByName] allKeys];
        NSMutableDictionary *fetchedTask = [NSMutableDictionary dictionaryWithDictionary:[task dictionaryWithValuesForKeys:keys]];
       
        [fetchedTasks addObject:fetchedTask];
        
    }
    
    resultArray = [[NSArray alloc] initWithArray:fetchedTasks];
    
    return resultArray;
}


-(NSArray *)getNotifications{
    
    NSArray *resultArray;
    NSMutableArray *fetchedTasks = [[NSMutableArray alloc] init];
    Tasks *task;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tasks" inManagedObjectContext:self.managedObjectContext];
    
    NSNumber *nid = [NSNumber numberWithUnsignedInteger:0];
    
    NSPredicate *predicateLid = [NSPredicate predicateWithFormat:@"nid > %@", nid];
    
    NSPredicate *compPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicateLid, nil]];
    [fetchRequest setPredicate:compPredicate];
    
    NSError *requestError = nil;
    
    [fetchRequest setIncludesPendingChanges:YES];
    [fetchRequest setEntity:entity];
    
    NSArray *items = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    NSLog(@"records with notifications in Tasks: %ld", (long) [items count]);
    
    for (task in items) {
        
        NSArray *keys = [[[task entity] attributesByName] allKeys];
        NSMutableDictionary *fetchedTask = [NSMutableDictionary dictionaryWithDictionary:[task dictionaryWithValuesForKeys:keys]];
        
        [fetchedTasks addObject:fetchedTask];
        
    }
    
    resultArray = [[NSArray alloc] initWithArray:fetchedTasks];
    
    return resultArray;
}

#pragma mark - Network interactions


-(BOOL)isConnected{
    
    BOOL connected;
    
    connected = NO;
    
    NSURL *scriptUrl = [NSURL URLWithString:@"http://google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data){
        connected = YES;
    }
    
    return connected;
}


-(void)registerUser:(NSString *)userName password:(NSString *)password{

    NSString *post = @"/users";

    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    [postDic setValue:userName forKey:@"email"];
    [postDic setValue:password forKey:@"password"];
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"JSON: %@", jsonString);
    
    if (error != nil){
        
        NSString *errorDescrition = [error description];
        [self uniNotification:@"JSON Error" message:errorDescrition notifName:@"registrationfailed" notifData:[[NSDictionary alloc] init]];
        
        NSLog(@"JSON seralisation error");
        
        return;
    }

    NSData *postData = [jsonString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[jsonString length]];
    
    NSString *requestURL = [webserviceURL stringByAppendingString:post];
    
    NSURL *url = [NSURL URLWithString:requestURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutforWebconnection];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = postData;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        
        if (([data length] > 0) && (connectionError == nil)){
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"html = %@", html);
            
            NSError *localError = nil;
            NSDictionary *deserializedDictionary;
            
            id parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&localError];
            
            if (localError != nil){
                
                NSString *deparseError = [connectionError description];
                
                [self uniNotification:@"JSON Error" message:deparseError notifName:@"registrationfailed" notifData:[[NSDictionary alloc] init]];
                
                NSLog(@"JSON deSeralisation error");
                return;
            }
            
            
            if ([parsedObject isKindOfClass:[NSDictionary class]]){
                
                deserializedDictionary = (NSDictionary *)parsedObject;
                self->decodedJSONDictionary = [NSDictionary dictionaryWithDictionary:deserializedDictionary];
                
            }
            
            
            NSString *token = [self->decodedJSONDictionary valueForKey:@"token"];
            NSString *message = [self->decodedJSONDictionary valueForKey:@"message"];

            if (token == nil){
                
                NSString *errorMessage = @"User registration error";
                
                if (message !=  nil){
                    
                    errorMessage = message;
                    
                }
                
                [self uniNotification:@"Registration error" message:errorMessage notifName:@"registrationfailed" notifData:nil];
                return;
            }
            
            self->userInfo = [[NSMutableDictionary alloc] initWithDictionary:self->decodedJSONDictionary];
            
            appDelegate.token = token;
            
            [self uniNotification:@"Registration" message:@"Registration successful" notifName:@"registrationdone" notifData:nil];
            
        }else if (([data length] == 0) && (connectionError == 0)){
            NSLog(@"result is empty");
            
            [self uniNotification:@"Connection error" message:@"Empty responce from server" notifName:@"registrationfailed" notifData:nil];
            
        }else if (connectionError != nil){
            
            NSLog(@"error happend: %@", connectionError);
            
            NSString *connectionErrorDescription = [connectionError description];
            
            [self uniNotification:@"Connection error" message:connectionErrorDescription notifName:@"registrationfailed" notifData:nil];
            
        }
        
    }];
    
    [postDataTask resume];
    
}


-(void)authUser:(NSString *)userName password:(NSString *)password{
    
    NSString *post = @"/auth";
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    [postDic setValue:userName forKey:@"email"];
    [postDic setValue:password forKey:@"password"];
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"JSON: %@", jsonString);
    
    if (error != nil){
        
        NSString *errorDescrition = [error description];
        [self uniNotification:@"JSON Error" message:errorDescrition notifName:@"authfailed" notifData:[[NSDictionary alloc] init]];
        
        NSLog(@"JSON seralisation error");
        
        return;
    }
    
    NSData *postData = [jsonString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[jsonString length]];
    
    NSString *requestURL = [webserviceURL stringByAppendingString:post];
    
    NSURL *url = [NSURL URLWithString:requestURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeoutforWebconnection];
    
    request.HTTPMethod = @"POST";
    request.HTTPBody = postData;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        
        if (([data length] > 0) && (connectionError == nil)){
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"html = %@", html);
            
            NSError *localError = nil;
            NSDictionary *deserializedDictionary;
            
            id parsedObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&localError];
            
            if (localError != nil){
                
                NSString *deparseError = [connectionError description];
                
                [self uniNotification:@"JSON Error" message:deparseError notifName:@"authfailed" notifData:[[NSDictionary alloc] init]];
                
                NSLog(@"JSON deSeralisation error");
                return;
            }
            
            
            if ([parsedObject isKindOfClass:[NSDictionary class]]){
                
                deserializedDictionary = (NSDictionary *)parsedObject;
                self->decodedJSONDictionary = [NSDictionary dictionaryWithDictionary:deserializedDictionary];
                
            }
            
            
            NSString *token = [self->decodedJSONDictionary valueForKey:@"token"];
            NSString *message = [self->decodedJSONDictionary valueForKey:@"message"];
            
            if (token == nil){
                
                NSString *errorMessage = @"User registration error";
                
                if (message !=  nil){
                    
                    errorMessage = message;
                    
                }
                
                [self uniNotification:@"Registration error" message:errorMessage notifName:@"authfailed" notifData:nil];
                return;
            }
            
            self->userInfo = [[NSMutableDictionary alloc] initWithDictionary:self->decodedJSONDictionary];
            
            appDelegate.token = token;
            
            [self uniNotification:@"Registration" message:@"Registration successful" notifName:@"authdone" notifData:nil];
            
        }else if (([data length] == 0) && (connectionError == 0)){
            NSLog(@"result is empty");
            
            [self uniNotification:@"Connection error" message:@"Empty responce from server" notifName:@"authfailed" notifData:nil];
            
        }else if (connectionError != nil){
            
            NSLog(@"error happend: %@", connectionError);
            
            NSString *connectionErrorDescription = [connectionError description];
            
            [self uniNotification:@"Connection error" message:connectionErrorDescription notifName:@"authfailed" notifData:nil];
            
        }
        
    }];
    
    [postDataTask resume];
    
}


#pragma mark - Notifications


-(void)uniNotification:(NSString *)title message:(NSString *)message notifName:(NSString *)notifNname notifData:(NSDictionary *)notifData{
    
    //NS Log(@"cookie login ok");
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    
    [userInfo setValue:title forKey:@"title"];
    [userInfo setValue:message forKey:@"message"];
    
    if (notifData != nil){
        [userInfo setValue:notifData forKey:@"dictionary"];
    }
    
    if (![NSThread isMainThread])
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            NSNotification *notification = [NSNotification notificationWithName:notifNname object:self userInfo:userInfo];
            
            [self sendNorification:notification];
            
        });
        return;
    }else{
        
        NSNotification *notification = [NSNotification notificationWithName:notifNname object:self userInfo:userInfo];
        
        [self sendNorification:notification];
        
    }
    
}



-(void)sendNorification:(NSNotification *)notification
{
    
    [[NSNotificationQueue defaultQueue]
     enqueueNotification:notification
     postingStyle:NSPostNow];
    
}


#pragma mark - Core Data stack


- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {

        if (_persistentContainer == nil) {

            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"TestAssignmentDoItSoftware"];
            
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}


// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel{
    
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TestAssignmentDoItSoftware" withExtension:@"momd"];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return managedObjectModel;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentContainer *persistentContainer = [self persistentContainer];

    if (persistentContainer != nil) {
            managedObjectContext = self.persistentContainer.viewContext;
    }

    return managedObjectContext;
}



@end
