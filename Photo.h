//
//  Photo.h
//  Album 7Nisan
//
//  Created by Eyüp Çimen on 9.04.2015.
//  Copyright (c) 2015 Eyüp Çimen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Album;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) Album *albumBook;

@end
