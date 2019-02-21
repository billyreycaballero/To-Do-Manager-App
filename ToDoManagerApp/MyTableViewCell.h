//
//  MyTableViewCell.h
//  ToDoManagerApp
//
//  Created by Billy Rey Caballero on 25/4/17.
//  Copyright © 2017 alcoderithm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoEntity+CoreDataClass.h"



@interface MyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *toDoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDoDueDateLabel;

-(void) setInternalFieds:(ToDoEntity *) incomingToDoEntity;

@property (strong, nonatomic) ToDoEntity *localToDoEntity;


@end
