//
//  PhotoDetailVC.m
//  Album 7Nisan
//
//  Created by Eyüp Çimen on 10.04.2015.
//  Copyright (c) 2015 Eyüp Çimen. All rights reserved.
//

#import "PhotoDetailVC.h"
#import "Photo.h"
#import "FiltersCollectionVC.h"

@interface PhotoDetailVC ()

@end

@implementation PhotoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation


 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if ([segue.identifier isEqualToString:@"filtersSegue"])
     {
         if ([segue.destinationViewController isKindOfClass:[FiltersCollectionVC class]])
         {
             FiltersCollectionVC *targetVC = segue.destinationViewController;
             
             targetVC.photoFilters = self.photo ;
         }
     }
 }


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.imageViewDetail.image = self.photo.image ;
    
}



- (IBAction)addFilterButtonPressed:(UIButton *)sender
{
    
}


#warning CORE DATA'DAN RESİM SİLİYOR

- (IBAction)deleteButtonPressed:(UIButton *)sender
{
    [[self.photo managedObjectContext] deleteObject:self.photo];
    
    NSError *error = nil;
    
    [[self.photo managedObjectContext] save:&error];
    
    if (error)
    {
        // Kayıt olmuyorsa buraya düşecek burası da OLMAZSA OLMAZ !!!
        NSLog(@"%@",error);
    }
    
    [self.navigationController popViewControllerAnimated:YES ];
    
}












@end
