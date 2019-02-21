
#import "AppDelegate.h"
#import "DPManagerMOC.h"


@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    id<DPManagerMOC> child = (id<DPManagerMOC>)self.window.rootViewController;
    [child receiveMOC:self.managedObjectContext];
    [self managedObjectModel];
    [self persistentStoreCoordinator];
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSAssert(moc != nil, @"Unable to create Managed Object Context");
    return YES;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if(_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL =[[NSBundle mainBundle] URLForResource:@"ToDoManagerApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {
    if(_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ToDoManagerApp.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error loading";
    
    if(![_persistentStoreCoordinator addPersistentStoreWithType: NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict [NSLocalizedDescriptionKey] = @"Failed to initialized";
        dict [NSLocalizedFailureReasonErrorKey] = failureReason;
        dict [NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if(!coordinator) {
        return nil;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]){
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}

@end
