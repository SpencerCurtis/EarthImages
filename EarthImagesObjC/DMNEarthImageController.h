//
//  PhotoController.h
//  EarthImagesObjC
//
//  Created by Spencer Curtis on 3/2/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DMNEarthImage.h"

@interface DMNEarthImageController : NSObject

+ (void)fetchEarthInformationForLatitude:(NSString *)latitude longitude:(NSString *)longitude completion: (void(^)(DMNEarthImage *earthImage))completion;

+ (void)fetchEarthImageWithURLString:(NSString *)imageURLString completion: (void(^)(UIImage *image))completion;

+ (NSString *)fetchAPIKeyFromPlist;

@end
