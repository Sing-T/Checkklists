//
//  AllListsViewController.m
//  checkklist
//
//  Created by 王新涛 on 12/10/2015.
//  Copyright © 2015 sin. All rights reserved.
//

#import "AllListsViewController.h"
#import "Checklist.h"
#import "ViewController.h"
#import "ChecklistItem.h"
#import "DataModel.h"

@implementation AllListsViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowChecklist"]){
        ViewController *controller = segue.destinationViewController;
        controller.checklist = sender;
    }else if([segue.identifier isEqualToString:@"AddChecklist"]){
        UINavigationController *navigationController = segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController*)navigationController.topViewController;
        controller.delegate = self;
        controller.checklistToEdit = nil;
    }
}


-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(viewController == self){
        [self.dataModel setIndexOfSelectedChecklist:-1];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    NSInteger index = [self.dataModel indexOfSelectedChecklist];
    if(index >= 0 && index < [self.dataModel.lists count]){
        Checklist *checklist = self.dataModel.lists[index];
        [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
    }
}

#pragma mark 数据加载和保存
//-(NSString*)documentsDirectory{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths firstObject];
//    return documentsDirectory;
//}
//-(NSString*)dataFilePath{
//    return [[self documentsDirectory]stringByAppendingPathComponent:@"Checklists.plist"];
//}
//-(void)saveChecklists{
//    NSMutableData *data = [[NSMutableData alloc]init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
//    [archiver encodeObject:_lists forKey:@"Checklists"];
//    [archiver finishEncoding];
//    [data writeToFile:[self dataFilePath] atomically:YES];
//}
//-(void)loadChecklists{
//    NSString *path = [self dataFilePath];
//    if([[NSFileManager defaultManager]fileExistsAtPath:path]){
//        NSData *data =[[NSData alloc]initWithContentsOfFile:path];
//        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
//        _lists = [unarchiver decodeObjectForKey:@"Checklists"];
//        [unarchiver finishDecoding];
//    }else{
//        _lists = [[NSMutableArray alloc]initWithCapacity:20];
//    }
//}

#pragma mark 表视图数据源代理⽅方法
//-(id)initWithCoder:(NSCoder *)aDecoder{
//    if((self =[super initWithCoder:aDecoder])){
//        [self loadChecklists];
//    }
//    return self;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataModel setIndexOfSelectedChecklist:indexPath.row];
    Checklist *checklist = self.dataModel.lists[indexPath.row];
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Checklist *checklist = self.dataModel.lists[indexPath.row];
    cell.textLabel.text = checklist.name;
    //cell.accessoryType = UITableViewCellAccessoryDetailButton;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    int count = [checklist countUncheckedItems];
    if([checklist.items count] == 0){
        cell.detailTextLabel.text = @"(No Items)";
    }else if(count == 0){
        cell.detailTextLabel.text =@"全部搞定收工!";
    }else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Remaining",[checklist countUncheckedItems]];
    }
    cell.imageView.image = [UIImage imageNamed:checklist.iconName];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *)indexPath{
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    ListDetailViewController *controller = (ListDetailViewController*)navigationController.topViewController;
    controller.delegate = self;
    Checklist *checklist = self.dataModel.lists[indexPath.row];
    controller.checklistToEdit = checklist;
    [self presentViewController:navigationController animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark 代理方法
-(void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist: (Checklist *)checklist{
//    NSInteger newRowIndex = [self.dataModel.lists count];
//    [self.dataModel.lists addObject:checklist];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
//    NSArray *indexPaths = @[indexPath];
//    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.dataModel.lists addObject:checklist];
    [self.dataModel sortChecklists];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist: (Checklist *)checklist{
//    NSInteger index = [self.dataModel.lists indexOfObject:checklist];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.text = checklist.name;
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.dataModel sortChecklists];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
