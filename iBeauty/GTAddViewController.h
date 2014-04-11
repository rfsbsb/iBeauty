//
//  GTAddViewController.h
//  iBeauty
//
//  Created by Rafael Ferreira Silva on 08/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "GTAppDelegate.h"

@interface GTAddViewController : UIViewController
- (IBAction)addBackButton:(UIBarButtonItem *)sender;
- (IBAction)addSaveButton:(UIBarButtonItem *)sender;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextField *stock;
@property (weak, nonatomic) IBOutlet UITextView *details;
- (IBAction)viewTouched:(UIControl *)sender;
- (IBAction)inputDone:(UITextField *)sender;


@end
