//
//  IconPickerViewController.h
//  checkklist
//
//  Created by 王新涛 on 18/10/2015.
//  Copyright © 2015 sin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerViewController;
@protocol IconPickerViewControllerDelegate <NSObject>
-(void)iconPicker:(IconPickerViewController*)picker didPickIcon:(NSString*)iconName;
@end

@interface IconPickerViewController : UITableViewController

@property(nonatomic,weak)id <IconPickerViewControllerDelegate> delegate;

@end