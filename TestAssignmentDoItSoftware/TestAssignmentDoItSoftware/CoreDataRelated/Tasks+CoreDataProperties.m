//
//  Tasks+CoreDataProperties.m
//  TestAssignmentDoItSoftware
//
//  Created by Vladimir Samoylenko on 2/18/19.
//  Copyright © 2019 TheRedQueen. All rights reserved.
//
//

#import "Tasks+CoreDataProperties.h"

@implementation Tasks (CoreDataProperties)

+ (NSFetchRequest<Tasks *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Tasks"];
}

@dynamic tid;
@dynamic lid;
@dynamic title;
@dynamic priority;
@dynamic details;
@dynamic nid;
@dynamic status;
@dynamic prioritystr;
@dynamic dateto;

@end
