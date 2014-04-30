//
//  GTImageSaver.h
//  iBeauty
//
//  Created by Ricardo Alexandre Franco da Cruz on 28/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface GTImageSaver : NSObject

+ (BOOL)saveImageToDisk:(UIImage*)image andToProduct:(Product*)product;
+ (void)deleteImageAtPath:(NSString *)path;
@end
