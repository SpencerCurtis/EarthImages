//
//  PhotoController.h
//  EarthImagesObjC
//
//  Created by Spencer Curtis on 3/2/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DMNEarthPhoto.h"

@interface PhotoController : NSObject

- (void)fetchEarthInformationForLatitude:(NSString *)latitude longitude:(NSString *)longitude completion: (void(^)(DMNEarthPhoto *earthPhoto))completion;

- (void)fetchEarthPhotoWithURLString:(NSString *)imageURLString completion: (void(^)(UIImage *image))completion;

- (NSString *)fetchAPIKeyFromPlist;

@end
