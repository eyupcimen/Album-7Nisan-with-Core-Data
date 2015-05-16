//
//  AlbumTableVC.m
//  Album 7Nisan
//
//  Created by Eyüp Çimen on 7.04.2015.
//  Copyright (c) 2015 Eyüp Çimen. All rights reserved.
//

#import "AlbumTableVC.h"
#import "Album.h"
#import "CoreDataHelper.h"
#import "PhotosCollectionVC.h"

@interface AlbumTableVC () <UIAlertViewDelegate>

@end

@implementation AlbumTableVC

-(NSMutableArray *)albums
{
    if (!_albums) _albums = [[NSMutableArray alloc]init];
    return _albums ;
}


#pragma mark - IBAction
- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender
{
    UIAlertView *addAlertView = [[UIAlertView alloc]initWithTitle:@"Albüm Eklemek İçin İsim Giriniz" message:nil delegate:self cancelButtonTitle:@"Kapat" otherButtonTitles:@"Ekle", nil];
    [addAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [addAlertView show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString *alertText = [alertView textFieldAtIndex:0].text;
        
        [self.albums addObject:[self albumWithName:alertText]];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.albums count]-1 inSection:0];
        
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
}

#pragma mark - Yardımcı Metodlar

#warning CORE DATA'YA YAZILAN YER

-(Album *)albumWithName:(NSString *)name
{
    
    NSManagedObjectContext *context = [CoreDataHelper managedObjectContext];
    
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    
    album.name = name ;
    album.date = [NSDate date];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Hatalar buraya yazılacak");
    }
    return album;
}


#pragma mark - ViewWillAppear    

#warning  CORE DATA'DAN ALINAN YER

-(void)viewWillAppear:(BOOL)animated
{
    // BURASI CORE DATA'DAN VERİLERİ ALIP GÖSTERDİĞİ YER ÇOK ÖNEMLİ
    
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    
    
    NSError *error = nil ;
    NSArray *fetchedAlbums = [[CoreDataHelper managedObjectContext]  executeFetchRequest:fetchRequest error:&error];
    
    self.albums = [fetchedAlbums mutableCopy];
    
    [self.tableView reloadData];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [self.albums count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Album *selectedAlbum = self.albums[indexPath.row];
    cell.textLabel.text = selectedAlbum.name    ;
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Album chosen"])
    {
        if ([segue.destinationViewController isKindOfClass:[PhotosCollectionVC class]])
        {   // aşağıdaki kod secilen satırdın index'inin veriyor
            NSIndexPath *path = [self.tableView indexPathForSelectedRow];
            
            PhotosCollectionVC *targetVC = segue.destinationViewController;
            targetVC.albumDetailIcin = self.albums[path.row];
        }
    }
    
}


@end
