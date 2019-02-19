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
