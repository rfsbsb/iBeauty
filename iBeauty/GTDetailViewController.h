//
//  GTDetailViewController.h
//  iBeauty
//
//  Created by Rafael Ferreira Silva on 08/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface GTDetailViewController : UIViewController

@property (strong, nonatomic) Product *product;

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *price;

@property (weak, nonatomic) IBOutlet UITextField *stock;

@property (weak, nonatomic) IBOutlet UITextView *details;

@end
