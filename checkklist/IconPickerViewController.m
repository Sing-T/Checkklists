//
//  IconPickerViewController.m
//  checkklist
//
//  Created by 王新涛 on 18/10/2015.
//  Copyright © 2015 sin. All rights reserved.
//

#import "IconPickerViewController.h"

@implementation IconPickerViewController{
    NSArray *_icons;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _icons = @[
               @"No Icon",
               @"Appointments",
               @"Birthdays",
               @"Chores",
               @"Drinks",
               @"Folder",
               @"Groceries",
               @"Inbox",
               @"Photos",
               @"Trips"
               ];
}

#pragma mark - Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_icons count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"IconCell"];
    NSString *icon = _icons[indexPath.row];
    cell.textLabel.text = icon;
    cell.imageView.image = [UIImage imageNamed:icon];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *iconName = _icons[indexPath.row];
    [self.delegate iconPicker:self didPickIcon:iconName];
}

@end
