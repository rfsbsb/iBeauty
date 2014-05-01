//
//  GTStockManager.m
//  iBeauty
//
//  Created by Ricardo Alexandre Franco da Cruz on 01/05/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import "GTStockManager.h"

@implementation GTStockManager

+(BOOL)decreaseProduct:(Product *)product withContext:(NSManagedObjectContext *)context
{
    NSNumber *stock = product.stock;
    long lStock = [stock longValue];
    
    if (lStock > 0) {
        stock = [NSNumber numberWithLong:lStock - 1];
        
        product.stock = stock;
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        [[[UIAlertView alloc] initWithTitle:@"Aviso"
									message:[NSString stringWithFormat:@"Produto %@ vendido com sucesso! Restam %li unidades", product.name, lStock-1]
								   delegate:nil
						  cancelButtonTitle:@"OK"
						  otherButtonTitles: nil] show];
        return TRUE;
        
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Aviso"
                                message:[NSString stringWithFormat:@"Não existe mais estoque do produto %@", product.name]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles: nil] show];

        return FALSE;
    }
    return TRUE;
}

@end
