//
//  TASingleton.h
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Tasks+CoreDataClass.h"
#import "Tasks+CoreDataProperties.h"


NS_ASSUME_NONNULL_BEGIN

@interface TASingleton : NSObject


@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;


+ (TASingleton *)sharedInstance;

-(NSNumber *)getNewId;
-(void)addTask:(NSMutableDictionary *)dictionaryTask taskId:(NSNumber *)lidNumber;
-(NSArray *)getTasks;
-(NSArray *)getNotifications;

- (void)saveContext;


@end

NS_ASSUME_NONNULL_END
