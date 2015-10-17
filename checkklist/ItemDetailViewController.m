//
//  ItemDetailViewController.m
//  checkklist
//
//  Created by 王新涛 on 5/10/2015.
//  Copyright © 2015 sin. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"

@implementation ItemDetailViewController

- (IBAction)cancel:(id)sender {
    [self.delegate itemDetailViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    if(self.itemToEdit == nil){
        ChecklistItem *item = [[ChecklistItem alloc]init];
        item.text = self.textField.text;
        item.checked = NO;
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    }else{
        self.itemToEdit.text = self.textField.text;
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.itemToEdit != nil){
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if([newText length] > 0){
        self.doneBarButton.enabled = YES;
    }else{
        self.doneBarButton.enabled = NO;
    }
    return YES;
}
@end
