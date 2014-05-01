//
//  GTStockManager.h
//  iBeauty
//
//  Created by Ricardo Alexandre Franco da Cruz on 01/05/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface GTStockManager : NSObject

+(BOOL) decreaseProduct:(Product*) product withContext: (NSManagedObjectContext*) context;
@end
