//
//  DataModel.h
//  checkklist
//
//  Created by 王新涛 on 14/10/2015.
//  Copyright © 2015 sin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property(nonatomic,strong)NSMutableArray *lists;
-(void)saveChecklists;
-(NSInteger)indexOfSelectedChecklist;
-(void)setIndexOfSelectedChecklist:(NSInteger)index;
-(void)sortChecklists;
@end
