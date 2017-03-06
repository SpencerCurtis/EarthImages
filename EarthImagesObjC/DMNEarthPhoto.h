//
//  DMNEarthPhoto.h
//  EarthImagesObjC
//
//  Created by Spencer Curtis on 3/5/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface DMNEarthPhoto : NSObject

- (instancetype)initWithImageURL:(NSString *)imageURL timestamp:(NSString *)timestamp identifier:(NSString *)identifier;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *identifier;

@end
