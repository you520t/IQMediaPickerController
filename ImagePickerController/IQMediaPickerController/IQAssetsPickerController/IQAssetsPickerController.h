
#import <UIKit/UIKit.h>
#import "IQAlbumAssetsViewController.h"

@protocol IQAssetsPickerControllerDelegate;

@interface IQAssetsPickerController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) IQAssetsPickerControllerAssetType pickerType;

@property(nonatomic, assign) id<IQAssetsPickerControllerDelegate> delegate;

@end


@protocol IQAssetsPickerControllerDelegate <NSObject>

- (void)assetsPickerController:(IQAssetsPickerController*)controller didFinishMediaWithInfo:(NSDictionary *)info;
- (void)assetsPickerControllerDidCancel:(IQAssetsPickerController *)controller;

@end

extern NSString *const IQMediaImage;          // a UIImage
extern NSString *const IQMediaURL;       // an NSURL
extern NSString *const IQMediaTypeVideo;
extern NSString *const IQMediaTypeImage;
