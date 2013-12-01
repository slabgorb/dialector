//
//  DialectorLanguage.h
//  Dialector
//
//  Created by Keith Avery on 12/1/13.
//  Copyright (c) 2013 Keith Avery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DialectorLanguage : NSManagedObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *contentList;
@end
