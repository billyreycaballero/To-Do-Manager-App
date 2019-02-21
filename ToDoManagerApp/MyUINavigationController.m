

#import "MyUINavigationController.h"


@interface MyUINavigationController ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end


@implementation MyUINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) receiveMOC:(NSManagedObjectContext *) incomingMOC{
    self.managedObjectContext = incomingMOC;
    id<DPManagerMOC> child = (id<DPManagerMOC>) self.viewControllers[0];
    [child receiveMOC:self.managedObjectContext];
}


@end
