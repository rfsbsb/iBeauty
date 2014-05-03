//
//  GTMasterViewController.h
//  iBeauty
//
//  Created by Rafael Ferreira Silva on 08/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GTAppDelegate.h"
#import "Product.h"
#import "GTImageSaver.h"

@interface GTMasterViewController : UITableViewController

@property (nonatomic) NSMutableArray * products;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
