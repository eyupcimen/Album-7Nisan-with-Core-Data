//
//  PictureDataTransformer.m
//  Album 7Nisan
//
//  Created by Eyüp Çimen on 8.04.2015.
//  Copyright (c) 2015 Eyüp Çimen. All rights reserved.
//

#import "PictureDataTransformer.h"
#import <UIKit/UIKit.h>

@implementation PictureDataTransformer


+(Class)transformedValueClass
{
    return [NSData class];
}


+(BOOL)allowsReverseTransformation
{
    return YES;
}


-(id)transformedValue:(id)value
{
    return UIImagePNGRepresentation(value);
}


-(id)reverseTransformedValue:(id)value
{
    UIImage *image = [UIImage imageWithData:value];
    return image;
}












@end
