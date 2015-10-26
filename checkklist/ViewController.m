//
//  ViewController.m
//  checkklist
//
//  Created by 王新涛 on 29/9/15.
//  Copyright © 2015 sin. All rights reserved.
//

#import "ViewController.h"
#import "ChecklistItem.h"
#import "Checklist.h"

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = self.checklist.name;
    
//    NSLog(@"⽂文件夹的⺫⽬目录是:%@",[self documentsDirectory]);
//    NSLog(@"数据⽂文件的最终路径是:%@",[self dataFilePath]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.checklist.items count];
}

-(void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item{
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    if(item.checked){
        label.text = @"√";
    }else{
        label.text = @"";
    }
    
    label.textColor = self.view.tintColor;
//    if(item.checked){
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }else{
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
}

-(void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    //label.text = item.text;
    
    //label.text = [NSString stringWithFormat:@"%ld: %@",(long)item.itemId,item.text];
    label.text = [NSString stringWithFormat:@"%@",item.text];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    ChecklistItem *item = self.checklist.items[indexPath.row];
    
    [self configureTextForCell:cell withChecklistItem:item];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    
    ChecklistItem *item = self.checklist.items[indexPath.row];
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.checklist.items removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UINavigationController *navigationController = segue.destinationViewController;
    ItemDetailViewController *controller = (ItemDetailViewController*) navigationController.topViewController;
    controller.delegate = self;
    
    if([segue.identifier isEqualToString:@"AddItem"]){
        //TODO
    }else if([segue.identifier isEqualToString:@"EditItem"]){
        NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = self.checklist.items[indexPath.row];
    }
}

-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item{
    NSInteger newRowIndex = [self.checklist.items count];
    [self.checklist.items addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem: (ChecklistItem *)item{
    NSInteger index = [self.checklist.items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withChecklistItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
}


//- (IBAction)addItem:(id)sender {
//    NSInteger newRowIndex = [_items count];
//    ChecklistItem *item =[[ChecklistItem alloc]init];
//
//    item.text = @"我是新来的菜⻦鸟,求照顾求虐";
//    item.checked = NO;
//    [_items addObject:item];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
//    NSArray *indexPaths = @[indexPath];
//    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//}

//-(id)initWithCoder:(NSCoder *)aDecoder{
//    if((self = [super initWithCoder:aDecoder])){
//        [self loadChecklistItems];
//    }
//    return self;
//}

//-(NSString*)documentsDirectory{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths firstObject];
//    return documentsDirectory;
//}
//-(NSString*)dataFilePath{
//    return [[self documentsDirectory]stringByAppendingPathComponent:@"Checklists.plist"];
//}

//-(void)saveChecklistItems{
//    NSMutableData *data = [[NSMutableData alloc]init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
//    [archiver encodeObject:_items forKey:@"ChecklistItems"];
//    [archiver finishEncoding];
//    [data writeToFile:[self dataFilePath] atomically:YES];
//}

//-(void)loadChecklistItems{
//    NSString *path = [self dataFilePath];
//    if([[NSFileManager defaultManager]fileExistsAtPath:path]){
//        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
//        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
//        _items = [unarchiver decodeObjectForKey:@"ChecklistItems"];
//        [unarchiver finishDecoding];
//    }else{
//        _items = [[NSMutableArray alloc]initWithCapacity:20];
//    }
//}

@end
