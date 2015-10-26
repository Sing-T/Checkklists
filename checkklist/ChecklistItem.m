//
//  ChecklistItem.m
//  checkklist
//
//  Created by 王新涛 on 3/10/15.
//  Copyright © 2015 sin. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"

@implementation ChecklistItem

-(void)toggleChecked{
    self.checked = !self.checked;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super init]))
    {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [aDecoder decodeIntegerForKey:@"ItemID"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeBool:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeBool:self.itemId forKey:@"ItemID"];
}

-(id)init{
    if((self =[super init])){
        self.itemId = [DataModel nextChecklistItemId];
    }
    return self;
}

-(UILocalNotification*)notificationForThisItem{
    NSArray *allNotifications = [[UIApplication sharedApplication]scheduledLocalNotifications];
    for(UILocalNotification *notification in allNotifications){
        NSNumber *number = [notification.userInfo objectForKey:@"ItemID"];
        if(number != nil &&[number integerValue] == self.itemId){
            return notification;
        }
    }
    return nil;
}

-(void)scheduleNotification{
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if(existingNotification != nil){
        //NSLog(@"Found an exisint notification %@",existingNotification);
        [[UIApplication sharedApplication]cancelLocalNotification:existingNotification];
    }
    
    if(self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending){
        UILocalNotification *localNotification = [[UILocalNotification alloc]init];
        localNotification.fireDate = self.dueDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        
        localNotification.alertBody = self.text;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.userInfo = @{@"ItemID" : @(self.itemId)};
        [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
        //NSLog(@"Scheduled notification %@ for itemId %ld",localNotification,(long)self.itemId);
    }
}

-(void)dealloc{
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if(existingNotification !=nil){
        //NSLog(@"Removing exisint notification %@",existingNotification);
        [[UIApplication sharedApplication]cancelLocalNotification:existingNotification];
    }
}

@end