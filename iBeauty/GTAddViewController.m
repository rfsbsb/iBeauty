//
//  GTAddViewController.m
//  iBeauty
//
//  Created by Rafael Ferreira Silva on 08/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import "GTAddViewController.h"
#import "GTImageSaver.h"

@interface GTAddViewController () <UIGestureRecognizerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

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
  
  // 1. Save the image
  if (self.productImage.image) {
    if ([GTImageSaver saveImageToDisk:self.productImage.image andToProduct:newProduct]) {
      [self setImageForProduct:self.productImage.image];
    }
  }
  
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

- (IBAction)takePicture:(UITapGestureRecognizer *)sender
{
  UIActionSheet *sheet;
	sheet = [[UIActionSheet alloc] initWithTitle:@"Escolha a Foto"
                                      delegate:self
                             cancelButtonTitle:@"Cancelar"
                        destructiveButtonTitle:nil
                             otherButtonTitles:@"Tirar Foto", @"Escolher Foto", nil];
	
	[sheet showInView:self.navigationController.view];
  
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *image = info[UIImagePickerControllerOriginalImage];
	
  [self setImageForProduct:image];
  [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)setImageForProduct:(UIImage*)img {
	self.productImage.image		   = img;
	self.productImage.backgroundColor = [UIColor clearColor];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	switch (buttonIndex) {
		case 0: {
			if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
				imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
				[self presentViewController:imagePicker animated:YES completion:nil];
			}
		}
			break;
		case 1: {
			imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			[self presentViewController:imagePicker animated:YES completion:nil];
		}
			break;
		default:
			break;
	}
  
}


@end
