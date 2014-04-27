//
//  GTDetailViewController.m
//  iBeauty
//
//  Created by Rafael Ferreira Silva on 08/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import "GTDetailViewController.h"

@interface GTDetailViewController ()
@end

@implementation GTDetailViewController

#pragma mark - Managing the detail item


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.name.text = self.product.name;
    self.price.text =  [NSString stringWithFormat: @"%@", self.product.price];
    self.stock.text = [NSString stringWithFormat: @"%@", self.product.stock];
    self.details.text = self.product.details;
    GTAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editProduct:(UIBarButtonItem *)sender
{
    NSLog(@"Metodo editProduct.");

    [self.edit setTitle:@"Salvar"];
    [self.name setEnabled:TRUE];
    [self.price setEnabled:TRUE];
    [self.stock setEnabled:TRUE];
    [self.details setEditable:TRUE];
    
    [self.edit setAction:@selector(editSaveProduct)];
}

- (IBAction)viewTouchDown:(UIControl *)sender
{
    [self.price resignFirstResponder];
    [self.name resignFirstResponder];
    [self.stock resignFirstResponder];
    [self.details resignFirstResponder];   
}

- (IBAction)inputDone:(UITextField *)sender
{
    [sender resignFirstResponder];
}

// Salva os dados editados no Core Data
- (void) editSaveProduct
{
    NSLog(@"Metodo editSaveProduct");
    self.product.name = self.name.text;
    self.product.price = [NSDecimalNumber decimalNumberWithString:self.price.text];
    self.product.stock = [NSDecimalNumber decimalNumberWithString:self.stock.text];
    self.product.details = self.details.text;
        
    NSError *upError;
    if (![self.managedObjectContext save:&upError]) {
        NSLog(@"Whoops, couldn't update: %@", [upError localizedDescription]);
    }
    self.name.text = @"";
    self.price.text = @"";
    self.stock.text = @"";
    self.details.text = @"";
    
    [self.navigationController popViewControllerAnimated:YES];

}

@end
