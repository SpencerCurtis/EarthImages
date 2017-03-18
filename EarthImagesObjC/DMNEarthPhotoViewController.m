//
//  EarthPhotoViewController.m
//  EarthImagesObjC
//
//  Created by Spencer Curtis on 3/5/17.
//  Copyright © 2017 Spencer Curtis. All rights reserved.
//

#import "DMNEarthPhotoViewController.h"
#import "DMNEarthImageController.h"

@interface DMNEarthPhotoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *earthPhotoImageView;

@property (weak, nonatomic) IBOutlet UILabel *identifierLabel;

@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (weak, nonatomic) IBOutlet UITextField *latitudeTextField;

@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;

@end

@implementation DMNEarthPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timestampLabel.text = @"";
    self.identifierLabel.text = @"";
}

- (IBAction)searchButtonTapped:(id)sender {
    
    
    [DMNEarthImageController fetchEarthInformationForLatitude:self.latitudeTextField.text longitude:self.longitudeTextField.text completion:^(DMNEarthImage *earthImage) {
        
        if (!earthImage.imageURL) {
            UIImage *noPhotoImage = [UIImage imageNamed:@"NoImageFound"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.earthPhotoImageView.image = noPhotoImage;
                self.timestampLabel.text = @"";
                self.identifierLabel.text = @"";
            });
            
            return;
            
        } else {
            [DMNEarthImageController fetchEarthImageWithURLString:earthImage.imageURL completion:^(UIImage *image) {
                
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
