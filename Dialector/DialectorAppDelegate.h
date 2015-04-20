//
//  DialectorAppDelegate.h
//  Dialector
//
//  Created by Keith Avery on 12/1/13.
//  Copyright (c) 2013 Keith Avery. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DialectorAppDelegate : UIResponder <UIApplicationDelegate>
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) UIWindow *window;

@end
