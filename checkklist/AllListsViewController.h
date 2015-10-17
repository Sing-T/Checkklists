//
//  AllListsViewController.h
//  checkklist
//
//  Created by 王新涛 on 12/10/2015.
//  Copyright © 2015 sin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"

@class DataModel;

@interface AllListsViewController : UITableViewController<ListDetailViewControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)DataModel *dataModel;
//-(void)saveChecklists;

@end
