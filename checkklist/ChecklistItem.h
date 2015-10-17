//
//  ChecklistItem.h
//  checkklist
//
//  Created by 王新涛 on 3/10/15.
//  Copyright © 2015 sin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject<NSCoding>

@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)BOOL checked;

-(void)toggleChecked;

@end
