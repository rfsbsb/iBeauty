//
//  Product.h
//  iBeauty
//
//  Created by Rafael Ferreira Silva on 10/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * stock;

@end
