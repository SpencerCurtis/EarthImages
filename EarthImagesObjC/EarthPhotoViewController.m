//
//  EarthPhotoViewController.m
//  EarthImagesObjC
//
//  Created by Spencer Curtis on 3/5/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//

#import "EarthPhotoViewController.h"
#import "PhotoController.h"

@interface EarthPhotoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *earthPhotoImageView;

@property (weak, nonatomic) IBOutlet UILabel *identifierLabel;

@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;

@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;


@end

@implementation EarthPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timestampLabel.text = @"";
    self.identifierLabel.text = @"";
}

- (IBAction)searchButtonTapped:(id)sender {
    PhotoController *photoController = [PhotoController new];
    
    [photoController fetchEarthInformationForLatitude:self.latitudeTextField.text longitude:self.longitudeTextField.text completion:^(DMNEarthImage *earthImage) {
        
        if (!earthImage.imageURL) {
            UIImage *noPhotoImage = [UIImage imageNamed:@"NoImageFound"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.earthPhotoImageView.image = noPhotoImage;
                self.timestampLabel.text = @"";
                self.identifierLabel.text = @"";
            });
            return;
            
        } else {
            [photoController fetchEarthImageWithURLString:earthImage.imageURL completion:^(UIImage *image) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.earthPhotoImageView.image = image;
                    self.timestampLabel.text = earthImage.timestamp;
                    self.identifierLabel.text = earthImage.identifier;
                });
                
            }];
        }
    }];
}

@end
