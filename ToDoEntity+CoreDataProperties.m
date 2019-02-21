//
//  ToDoEntity+CoreDataProperties.m
//  ToDoManagerApp
//
//  Created by Billy Rey Caballero on 28/4/17.
//  Copyright © 2017 alcoderithm. All rights reserved.
//

#import "ToDoEntity+CoreDataProperties.h"

@implementation ToDoEntity (CoreDataProperties)

+ (NSFetchRequest<ToDoEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ToDoEntity"];
}

@dynamic toDoDetails;
@dynamic toDoDueDate;
@dynamic toDoTitle;

@end
