//
//  PhotosCollectionVC.m
//  Album 7Nisan
//
//  Created by Eyüp Çimen on 7.04.2015.
//  Copyright (c) 2015 Eyüp Çimen. All rights reserved.
//

#import "PhotosCollectionVC.h"
#import "PhotosCollectionCell.h"
#import "Photo.h"
#import "PictureDataTransformer.h"
#import "CoreDataHelper.h"
#import "PhotoDetailVC.h"

@interface PhotosCollectionVC () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic) NSMutableArray *photos;


@end

@implementation PhotosCollectionVC
@synthesize photos;




- (void)viewDidLoad {
    [super viewDidLoad];
    // self.photos = [[NSMutableArray alloc]init];
    
}


#warning NSSET VE SORT DESCRİPTOR

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // BURASI VERİLERİ BELLİ ÖLÇÜLERE GÖRE SIRALAYIP EKRANA YAZDIRDIĞIMIZ YER

    NSSet *unorderedPhotos = self.albumDetailIcin.photos ;
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray *sortedPhotos = [unorderedPhotos sortedArrayUsingDescriptors:@[dateDescriptor]];
    self.photos = [sortedPhotos mutableCopy];
    
    [self.collectionView reloadData];
}
 


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Prepare for Segue


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailSegue"])
    {
        if ([segue.destinationViewController isKindOfClass:[PhotoDetailVC class]])
        {
            PhotoDetailVC *targetVC = segue.destinationViewController;
            NSIndexPath *path = [[self.collectionView indexPathsForSelectedItems] lastObject];
            
            Photo *selectedPhoto = self.photos[path.row];
            targetVC.photo = selectedPhoto;
        }
    }
}


#pragma mark - Image Picker

- (IBAction)cameraBarButtonItemPressed:(UIBarButtonItem *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self ;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.editing = YES ;
    }
    
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
    
}



#pragma mark - Yardımcı Metodlar ve Core Data'ya yazılan kısım

#warning CORE DATA'YA YAZILAN KISIM

- (Photo *)photoFromImage:(UIImage *)image
{
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[CoreDataHelper managedObjectContext ]];
    photo.image = image ;
    photo.date = [NSDate date];
    photo.albumBook = self.albumDetailIcin ;
    
    NSError *error = nil ;
    
    if (![[photo managedObjectContext] save:&error])
    {   // kayıt olmamışsa
        // kayıt ederken hata veren kısım burayda yazılır
        NSLog(@"%@",error);
    }
    
    return photo;
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const reuseIdentifier = @"PhotoCell";
    PhotosCollectionCell *cell = (PhotosCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Photo *photo =  self.photos[indexPath.row];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageViewCell.image =  photo.image ;
    
    return cell;
}




#pragma mark - Image Picker Controller Delegate Metodları

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    [self.photos addObject:[self photoFromImage:image]];
    
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}








@end
