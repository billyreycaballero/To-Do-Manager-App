//
//  MyTableViewCell.m
//  ToDoManagerApp
//
//  Created by Billy Rey Caballero on 25/4/17.
//  Copyright © 2017 alcoderithm. All rights reserved.
//

#import "MyTableViewCell.h"


@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void) setInternalFieds:(ToDoEntity *) incomingToDoEntity{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    self.toDoTitleLabel.text = incomingToDoEntity.toDoTitle;
    self.localToDoEntity = incomingToDoEntity;

    NSString *temp = [dateFormatter stringFromDate:incomingToDoEntity.toDoDueDate];
    self.toDoDueDateLabel.text = temp;
    
    //self.toDoDueDateLabel.text = [dateFormatter stringFromDate:incomingToDoEntity.toDoDueDate];

}

@end
