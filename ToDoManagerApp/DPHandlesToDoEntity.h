//
//  DPHandlesToDoEntity.h
//  ToDoManagerApp
//
//  Created by Billy Rey Caballero on 25/4/17.
//  Copyright © 2017 alcoderithm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoEntity+CoreDataClass.h"


@protocol DPHandlesToDoEntity <NSObject>

- (void) receiveToDoEntity: (ToDoEntity *) incomingToDoEntity;

@end
