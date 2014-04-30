//
//  GTDetailViewController.m
//  iBeauty
//
//  Created by Rafael Ferreira Silva on 08/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import "GTDetailViewController.h"
#import "GTImageSaver.h"

@interface GTDetailViewController ()<UIGestureRecognizerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

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
    [self.productImage setUserInteractionEnabled:NO];
    //self.txtImage.hidden	   = YES;
    
    ;
    // If there is an image in the object, show it.
	if ([self.product.image length] > 0) {
		// Image setup
		NSData *imgData = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:self.product.image]];
		[self setImageForProduct:[UIImage imageWithData:imgData]];
	}
    
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
    [self.productImage setHidden:NO];
    [self.productImage setUserInteractionEnabled:YES];
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
    
    // 1. Remove old image if present
	if (self.product.image) {
		[GTImageSaver deleteImageAtPath:self.product.image];
	}

    // 2. Save the image
	if ([GTImageSaver saveImageToDisk:self.productImage.image andToProduct:self.product]) {
		[self setImageForProduct:self.productImage.image];
	}

    
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
	// 1. Grab image and save to disk
	UIImage *image = info[UIImagePickerControllerOriginalImage];
	
    [self setImageForProduct:image];
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)setImageForProduct:(UIImage*)img {
	self.productImage.image		   = img;
	self.productImage.backgroundColor = [UIColor clearColor];
	self.txtImage.hidden	   = YES;
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
