//
//  IQAlbumsViewController.m
//  IQAudioPickerController
//
//  Created by Iftekhar on 12/08/14.
//  Copyright (c) 2014 Iftekhar. All rights reserved.
//

#import "IQSongsAlbumListViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "IQAudioPickerUtility.h"
#import "IQSongsListViewController.h"
#import "IQSongsAlbumViewCell.h"
#import "IQAudioPickerController.h"

@implementation IQSongsAlbumListViewController
{
    NSArray *collections;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Albums";
        self.tabBarItem.image = [UIImage imageNamed:@"albums"];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
    [self.tableView registerClass:[IQSongsAlbumViewCell class] forCellReuseIdentifier:NSStringFromClass([IQSongsAlbumViewCell class])];

    MPMediaQuery *query = [MPMediaQuery albumsQuery];
    collections = [query collections];

    if (self.audioPickerController.allowsPickingMultipleItems == NO)
    {
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction:)];
        self.navigationItem.rightBarButtonItem = cancelItem;
    }
    else
    {
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
        self.navigationItem.rightBarButtonItem = cancelItem;
    }
}

-(void)doneAction:(UIBarButtonItem*)item
{
    
}

-(void)cancelAction:(UIBarButtonItem*)item
{
    [self.audioPickerController dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return collections.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IQSongsAlbumViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IQSongsAlbumViewCell class]) forIndexPath:indexPath];
    
    MPMediaItemCollection *item = [collections objectAtIndex:indexPath.row];
    
    MPMediaItemArtwork *artwork = [item.representativeItem valueForProperty:MPMediaItemPropertyArtwork];
    UIImage *image = [artwork imageWithSize:artwork.bounds.size];
    cell.imageViewAlbum.image = image;
    cell.labelTitle.text = [item.representativeItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    cell.labelSubTitle.text = [item.representativeItem valueForProperty:MPMediaItemPropertyAlbumArtist];
    
    if (item.items.count == 0)
    {
        cell.labelSubSubTitle.text = [NSString stringWithFormat:@"no songs"];
    }
    else
    {
        NSUInteger totalMinutes = [IQAudioPickerUtility mediaCollectionDuration:item];
        cell.labelSubSubTitle.text = [NSString stringWithFormat:@"%lu %@, %lu %@",(unsigned long)item.count,(item.count>1?@"songs":@"song"),(unsigned long)totalMinutes,(totalMinutes>1?@"mins":@"min")];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IQSongsListViewController *controller = [[IQSongsListViewController alloc] init];
    controller.audioPickerController = self.audioPickerController;
    controller.collections = @[[collections objectAtIndex:indexPath.row]];
    
    [self.navigationController pushViewController:controller animated:YES];
}


@end
