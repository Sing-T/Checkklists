//
//  Checklist.h
//  checkklist
//
//  Created by 王新涛 on 12/10/2015.
//  Copyright © 2015 sin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject<NSCoding>

@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,copy)NSString *iconName;
-(int)countUncheckedItems;

@end
