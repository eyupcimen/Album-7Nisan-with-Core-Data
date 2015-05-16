//
//  PhotoDetailVC.h
//  Album 7Nisan
//
//  Created by Eyüp Çimen on 10.04.2015.
//  Copyright (c) 2015 Eyüp Çimen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface PhotoDetailVC : UIViewController


@property (strong,nonatomic) Photo *photo ;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewDetail;


- (IBAction)addFilterButtonPressed:(UIButton *)sender;
- (IBAction)deleteButtonPressed:(UIButton *)sender;

@end
