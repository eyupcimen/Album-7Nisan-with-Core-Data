//
//  AlbumTableVC.h
//  Album 7Nisan
//
//  Created by Eyüp Çimen on 7.04.2015.
//  Copyright (c) 2015 Eyüp Çimen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumTableVC : UITableViewController


@property (strong,nonatomic) NSMutableArray *albums;


- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender;


@end
