//
//  GTAddViewController.m
//  iBeauty
//
//  Created by Rafael Ferreira Silva on 08/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import "GTAddViewController.h"

@interface GTAddViewController ()

@end

@implementation GTAddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    GTAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addBackButton:(UIBarButtonItem *)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addSaveButton:(UIBarButtonItem *)sender {
  Product * newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];

  newProduct.name = self.name.text;
  newProduct.price = [NSDecimalNumber decimalNumberWithString:self.price.text];
  newProduct.stock = [NSDecimalNumber decimalNumberWithString:self.stock.text];
  newProduct.details = self.details.text;
  
  NSError *error;
  if (![self.managedObjectContext save:&error]) {
    NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
  }
  
  self.name.text = @"";
  self.price.text = @"";
  self.stock.text = @"";
  self.details.text = @"";

  [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)viewTouched:(UIControl *)sender {
  [self.price resignFirstResponder];
  [self.name resignFirstResponder];
  [self.stock resignFirstResponder];
  [self.details resignFirstResponder];
}

- (IBAction)inputDone:(UITextField *)sender {
  [sender resignFirstResponder];
}
@end
