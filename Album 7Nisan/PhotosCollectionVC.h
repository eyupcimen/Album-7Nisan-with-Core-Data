//
//  PhotosCollectionVC.h
//  Album 7Nisan
//
//  Created by Eyüp Çimen on 7.04.2015.
//  Copyright (c) 2015 Eyüp Çimen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"

@interface PhotosCollectionVC : UICollectionViewController



@property (strong,nonatomic) Album *albumDetailIcin ;


- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender;















@end
