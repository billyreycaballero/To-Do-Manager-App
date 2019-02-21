//
//  MyUIViewController.h
//  ToDoManagerApp
//
//  Created by Billy Rey Caballero on 25/4/17.
//  Copyright © 2017 alcoderithm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPManagerMOC.h"
#import "DPHandlesToDoEntity.h"


@interface MyUIViewController : UIViewController <DPManagerMOC, DPHandlesToDoEntity>

-(void) receiveMOC:(NSManagedObjectContext *) incomingMOC;
- (void) receiveToDoEntity: (ToDoEntity *) incomingToDoEntity;

@end
