//
//  PhotoController.m
//  EarthImagesObjC
//
//  Created by Spencer Curtis on 3/2/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//

#import "PhotoController.h"
#import "DMNEarthImage.h"

@interface PhotoController ()

@property (nonatomic, copy) NSString *baseURLString;

@end

@implementation PhotoController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseURLString = @"https://api.nasa.gov/planetary/earth/imagery";
    }
    return self;
}


- (void)fetchEarthInformationForLatitude:(NSString *)latitude longitude:(NSString *)longitude completion:(void (^)(DMNEarthImage *))completion
{
    // Get the url, and add on to it (with parameters usually)
    NSURL *baseURL = [[NSURL alloc] initWithString:self.baseURLString];
    
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:baseURL resolvingAgainstBaseURL:YES];
    
    NSURLQueryItem *apiKeyItem = [NSURLQueryItem queryItemWithName:@"api_key" value:[self fetchAPIKeyFromPlist]];
    NSURLQueryItem *latitudeItem = [NSURLQueryItem queryItemWithName:@"lat" value:latitude];
    NSURLQueryItem *longitudeItem = [NSURLQueryItem queryItemWithName:@"lon" value:longitude];
    NSArray *queryItems = @[apiKeyItem, latitudeItem, longitudeItem];
    
    urlComponents.queryItems = queryItems;
    
    NSURL *earthPhotoEndpoint = urlComponents.URL;
    
    //     NSURLSession - Used for making a URL request.
    
    [[[NSURLSession sharedSession] dataTaskWithURL:earthPhotoEndpoint completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { NSLog(@"Error: %@", error); completion(nil); return; }
        
        if (!data) { NSLog(@"Error: No data returned from data task"); completion(nil); return; }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error: Could not parse JSON correctly; json is not of type NSDictionary");
            completion(nil);
            return;
        }
        
        NSString *errorString = jsonDictionary[@"error"];
        
        if (errorString) { NSLog(@"%@", errorString); completion(nil); return; }
        
        DMNEarthImage *earthImage = [[DMNEarthImage alloc] initWithDictionary:jsonDictionary];
        completion(earthImage);
        
    }] resume];
}

- (void)fetchEarthImageWithURLString:(NSString *)imageURLString completion:(void (^)(UIImage *))completion
{
    
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { NSLog(@"Error: %@", error); completion(nil); }
        
        if (!data) { NSLog(@"Error: No data returned from data task"); completion(nil); }
        
        UIImage *earthPhoto = [[UIImage alloc] initWithData:data];
        
        completion(earthPhoto);
        
    }] resume];
    
    
}

- (NSString *)fetchAPIKeyFromPlist
{
    // Get the url of the file (in this case, the plist)
    
    NSURL *apiKeyPlistURL = [[NSBundle mainBundle] URLForResource:@"APIKeys" withExtension:@"plist"];
    if (!apiKeyPlistURL) { NSLog(@"Error: APIKeys plist not found"); return nil; }
    
    // Initialize a new object (usually a dictionary) from the contents of that url
    
    NSDictionary *apiKeys = [[NSDictionary alloc] initWithContentsOfURL:apiKeyPlistURL];
    
    // Parse through the dictionary for the values you want
    
    NSString *apiKey = apiKeys[@"APIKey"];
    
    return apiKey;
}


@end
