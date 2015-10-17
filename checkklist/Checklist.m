//
//  Checklist.m
//  checkklist
//
//  Created by 王新涛 on 12/10/2015.
//  Copyright © 2015 sin. All rights reserved.
//

#import "Checklist.h"
#import "ChecklistItem.h"

@implementation Checklist

-(id)init{
    if((self = [super init])){
        self.items = [[NSMutableArray alloc]initWithCapacity:20];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super init])){
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
}

-(int)countUncheckedItems{
    int count = 0;
    for(ChecklistItem *item in self.items){
        if(!item.checked){
            count += 1;
        }
    }
    return count;
}

-(NSComparisonResult)compare:(Checklist*)otherChecklist{
    return [self.name localizedStandardCompare:otherChecklist.name];
}

@end