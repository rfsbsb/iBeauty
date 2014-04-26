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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
