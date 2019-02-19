//
//  TASingleton.h
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/15/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Tasks+CoreDataClass.h"
#import "Tasks+CoreDataProperties.h"


NS_ASSUME_NONNULL_BEGIN


#define webserviceURL @"http://testapi.doitserver.in.ua/api"
#define timeoutforWebconnection 10.0f


@interface TASingleton : NSObject<NSURLSessionDelegate>{
    
    NSArray *decodedJSONArray;
    NSDictionary *decodedJSONDictionary;

}


@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@property (strong, nonatomic) NSMutableDictionary *userInfo;


+ (TASingleton *)sharedInstance;

-(NSNumber *)getNewId;
-(void)addTask:(NSMutableDictionary *)dictionaryTask taskId:(NSNumber *)lidNumber;
-(NSArray *)getTasks;
-(NSArray *)getNotifications;
-(BOOL)isConnected;
-(void)registerUser:(NSString *)userName password:(NSString *)password;
-(void)authUser:(NSString *)userName password:(NSString *)password;
    
- (void)saveContext;


@end

NS_ASSUME_NONNULL_END
