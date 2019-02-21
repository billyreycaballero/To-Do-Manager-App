


#import <CoreData/CoreData.h>
#import "MyUITableViewController.h"
#import "ToDoEntity+CoreDataClass.h"
#import "MyTableViewCell.h"
#import "DPHandlesToDoEntity.h"
#import "DPManagerMOC.h"


@interface MyUITableViewController () <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *resultsController;

@end

@implementation MyUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializedNSFetchedResultsControllerDelegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultsController.sections[section].numberOfObjects;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ToDoEntity *item = self.resultsController.sections[indexPath.section].objects[indexPath.row];
    
    MyTableViewCell *cell = (MyTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"TableCellIdentifier" forIndexPath:indexPath];
    
    [cell setInternalFieds:item];
    
    return cell;
}


- (void) initializedNSFetchedResultsControllerDelegate {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"toDoDueDate" ascending:NO]];
    self.resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.resultsController.delegate = self;
    
    NSError *err;
    BOOL fetchSucceeded = [self.resultsController performFetch: &err];
    if(!fetchSucceeded){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Coudn't fetch" userInfo:nil];
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

- (void)controller: (NSFetchedResultsController *) controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationFade];
             break;
        case NSFetchedResultsChangeUpdate: {
            MyTableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
            ToDoEntity *item = [controller objectAtIndexPath:indexPath];
            [cell setInternalFieds:item];
            break;
        }
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    id<DPManagerMOC, DPHandlesToDoEntity> child = (id<DPManagerMOC, DPHandlesToDoEntity>)[segue destinationViewController];
    [child receiveMOC:self.managedObjectContext];
    ToDoEntity *item;
    
    if([sender isMemberOfClass:[UIBarButtonItem class]]){
        
        item = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoEntity" inManagedObjectContext:self.managedObjectContext];
    } else {
        MyTableViewCell *source = (MyTableViewCell *) sender;
        item = source.localToDoEntity;
    }
    
    [child receiveToDoEntity:item];
}

-(void) receiveMOC:(NSManagedObjectContext *) incomingMOC{
    self.managedObjectContext = incomingMOC;
}

@end
