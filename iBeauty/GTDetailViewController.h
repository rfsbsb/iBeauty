//
//  GTDetailViewController.h
//  iBeauty
//
//  Created by Rafael Ferreira Silva on 08/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "GTAppDelegate.h"

@interface GTDetailViewController : UIViewController

@property (strong, nonatomic) Product *product;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextField *stock;
@property (weak, nonatomic) IBOutlet UITextView *details;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *edit;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *txtImage;


- (IBAction)editProduct:(UIBarButtonItem *)sender;
- (IBAction)viewTouchDown:(UIControl *)sender;
- (IBAction)inputDone:(UITextField *)sender;
- (void) editSaveProduct;

- (IBAction)takePicture:(UITapGestureRecognizer *)sender;

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end
