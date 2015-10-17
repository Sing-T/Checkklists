//
//  ViewController.h
//  checkklist
//
//  Created by 王新涛 on 29/9/15.
//  Copyright © 2015 sin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;


@interface ViewController : UITableViewController<ItemDetailViewControllerDelegate>

@property(nonatomic,strong) Checklist *checklist;

@end

