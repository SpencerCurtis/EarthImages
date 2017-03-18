//
//  DMNEarthPhoto.m
//  EarthImagesObjC
//
//  Created by Spencer Curtis on 3/5/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//

#import "DMNEarthImage.h"

@implementation DMNEarthImage

-(instancetype)initWithImageURL:(NSString *)imageURL timestamp:(NSString *)timestamp identifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        _imageURL = [imageURL copy];
        _timestamp = [timestamp copy];
        _identifier = [identifier copy];
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *imageURL = dictionary[@"url"];
    NSString *timestamp = dictionary[@"date"];
    NSString *identifier = dictionary[@"id"];
    
    return [self initWithImageURL:imageURL timestamp:timestamp identifier:identifier];
}

@end
