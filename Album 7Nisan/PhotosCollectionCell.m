//
//  PhotosCollectionCell.m
//  Album 7Nisan
//
//  Created by Eyüp Çimen on 7.04.2015.
//  Copyright (c) 2015 Eyüp Çimen. All rights reserved.
//

#import "PhotosCollectionCell.h"
#define IMAGEVIEW_BORDER_LENGTH 5

@implementation PhotosCollectionCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUp];
    }
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        [self setUp];
    }
    return self;
}



-(void)setUp
{
     CGRect cercerve = CGRectMake(0, 0, 170.0 , 170.0);
     self.imageViewCell = [[UIImageView alloc]initWithFrame:CGRectInset(self.bounds, IMAGEVIEW_BORDER_LENGTH, IMAGEVIEW_BORDER_LENGTH)];
     self.frame = cercerve;
     self.imageViewCell.frame = CGRectMake(5, 5, CGRectGetWidth(cercerve), CGRectGetHeight(cercerve));
   
    self.imageViewCell.contentMode = UIViewContentModeScaleToFill ;
    // self.imageViewCell.frame = self.bounds;
    
    
    
    [self.contentView addSubview:self.imageViewCell];
}




@end
