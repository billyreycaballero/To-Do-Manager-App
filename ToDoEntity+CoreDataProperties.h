//
//  ToDoEntity+CoreDataProperties.h
//  ToDoManagerApp
//
//  Created by Billy Rey Caballero on 28/4/17.
//  Copyright © 2017 alcoderithm. All rights reserved.
//

#import "ToDoEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ToDoEntity (CoreDataProperties)

+ (NSFetchRequest<ToDoEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *toDoDetails;
@property (nullable, nonatomic, copy) NSDate *toDoDueDate;
@property (nullable, nonatomic, copy) NSString *toDoTitle;

@end

NS_ASSUME_NONNULL_END
