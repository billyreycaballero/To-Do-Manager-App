//
//  MyUINavigationController.h
//  ToDoManagerApp
//
//  Created by Billy Rey Caballero on 25/4/17.
//  Copyright © 2017 alcoderithm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPManagerMOC.h"


@interface MyUINavigationController : UINavigationController <DPManagerMOC>

-(void) receiveMOC:(NSManagedObjectContext *) incomingMOC;

@end
