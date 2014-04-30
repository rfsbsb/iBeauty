//
//  Product.h
//  iBeauty
//
//  Created by Ricardo Alexandre Franco da Cruz on 28/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * stock;
@property (nonatomic, retain) NSString * image;

@end
