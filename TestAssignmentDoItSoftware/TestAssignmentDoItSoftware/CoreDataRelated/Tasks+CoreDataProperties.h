//
//  Tasks+CoreDataProperties.h
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/18/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//
//

#import "Tasks+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Tasks (CoreDataProperties)

+ (NSFetchRequest<Tasks *> *)fetchRequest;

@property (nonatomic) int64_t tid;
@property (nonatomic) int64_t lid;
@property (nullable, nonatomic, copy) NSString *title;
@property (nonatomic) int64_t priority;
@property (nullable, nonatomic, copy) NSString *details;
@property (nonatomic) int64_t nid;
@property (nonatomic) int64_t status;
@property (nullable, nonatomic, copy) NSString *prioritystr;
@property (nonatomic) int64_t dateto;

@end

NS_ASSUME_NONNULL_END
