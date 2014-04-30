//
//  GTImageSaver.m
//  iBeauty
//
//  Created by Ricardo Alexandre Franco da Cruz on 28/04/14.
//  Copyright (c) 2014 GroupOfTwo. All rights reserved.
//

#import "GTImageSaver.h"

@implementation GTImageSaver


+ (BOOL)saveImageToDisk:(UIImage*)image andToProduct:(Product*)product {
	NSData *imgData   = UIImageJPEGRepresentation(image, 0.5);
	NSString *name    = [[NSUUID UUID] UUIDString];
	NSString *path	  = [NSString stringWithFormat:@"Documents/%@.jpg", name];
	NSString *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:path];
	if ([imgData writeToFile:jpgPath atomically:YES]) {
		product.image = path;
	} else {
		[[[UIAlertView alloc] initWithTitle:@"Error"
									message:@"There was an error saving your photo. Try again."
								   delegate:nil
						  cancelButtonTitle:@"OK"
						  otherButtonTitles: nil] show];
		return NO;
	}
	return YES;
}

+ (void)deleteImageAtPath:(NSString *)path {
	NSError *error;
	NSString *imgToRemove = [NSHomeDirectory() stringByAppendingPathComponent:path];
	[[NSFileManager defaultManager] removeItemAtPath:imgToRemove error:&error];
}

@end
