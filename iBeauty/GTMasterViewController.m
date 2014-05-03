//
//  GTMasterViewController.m
//  iBeauty
//
//  Created by Rafael Ferreira Silva on 08/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import "GTMasterViewController.h"
#import "GTDetailViewController.h"

@implementation GTMasterViewController

- (void)awakeFromNib
{
  [super awakeFromNib];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  GTAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
  self.managedObjectContext = appDelegate.managedObjectContext;
}

- (void) viewWillAppear:(BOOL)animated {
  GTAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
  
  self.products = [appDelegate getAllProducts];
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
  Product *product = self.products[indexPath.row];
  // If there is an image in the object, show it.
  if ([product.image length] > 0) {
    // Image setup
    NSData *imgData = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:product.image]];
    cell.imageView.image = [UIImage imageWithData:imgData];
  }
  cell.textLabel.text = product.name;
  cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"Estoque: %@. Preço: R$ %@", product.stock, product.price];
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [tableView beginUpdates];
    Product *product = [self.products objectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    if (product.image) {
      [GTImageSaver deleteImageAtPath:product.image];
    }
    [self.managedObjectContext deleteObject:product];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
      NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    
    GTAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.products = [appDelegate getAllProducts];
    [tableView endUpdates];
    
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"showDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Product *object = self.products[indexPath.row];
    [[segue destinationViewController] setProduct:object];
  }
}

@end
