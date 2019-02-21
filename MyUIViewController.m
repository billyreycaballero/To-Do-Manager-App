//
//  MyUIViewController.m
//  ToDoManagerApp
//
//  Created by Billy Rey Caballero on 25/4/17.
//  Copyright © 2017 alcoderithm. All rights reserved.
//

#import "MyUIViewController.h"

@interface MyUIViewController ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) ToDoEntity *localToDoEntity;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *detailsField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDateField;
@property (nonatomic, assign) BOOL wasDeleted;

@end

@implementation MyUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void) saveMyToDoEntity {
    NSError *err;
    BOOL saveSuccess = [self.managedObjectContext save:&err];
    if(!saveSuccess) {
        @throw [NSException exceptionWithName:NSGenericException reason:@"Couldn't save" userInfo:@{NSUnderlyingErrorKey:err}];
    }
}

- (void) textViewDidEndEditing:(NSNotification *) notification {
    if ([notification object] == self) {
        self.localToDoEntity.toDoDetails = self.detailsField.text;
        [self saveMyToDoEntity];
    }
}

- (IBAction)trashTapped:(id)sender {
    self.wasDeleted = YES;
    [self.managedObjectContext deleteObject:self.localToDoEntity];
    [self saveMyToDoEntity];
    [self.navigationController popToRootViewControllerAnimated:YES];

}


-(void) viewWillAppear:(BOOL)animated {
    self.wasDeleted = NO;
    
    self.titleField.text = self.localToDoEntity.toDoTitle;
    self.detailsField.text = self.localToDoEntity.toDoDetails;
    
    NSDate *dueDate = self.localToDoEntity.toDoDueDate;
    if(dueDate != nil) {
        [self.dueDateField setDate:dueDate];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

- (void) viewWillDisappear:(BOOL)animated {
    if(self.wasDeleted == NO) {
        self.localToDoEntity.toDoTitle = self.titleField.text;
        self.localToDoEntity.toDoDetails = self.detailsField.text;
        self.localToDoEntity.toDoDueDate = self.dueDateField.date;
        [self saveMyToDoEntity];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
    
}

- (IBAction)titleFieldEditted:(id)sender {
    
    self.localToDoEntity.toDoTitle = self.titleField.text;
    [self saveMyToDoEntity];
}


- (IBAction)duedateEditted:(id)sender {
    self.localToDoEntity.toDoDueDate = self.dueDateField.date;
    [self saveMyToDoEntity];
}


- (void) receiveMOC:(NSManagedObjectContext *) incomingMOC{
    
    self.managedObjectContext = incomingMOC;
}

- (void) receiveToDoEntity: (ToDoEntity *) incomingToDoEntity {
    self.localToDoEntity = incomingToDoEntity;
}

@end
