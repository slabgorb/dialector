//
//  DialectorLetterList.h
//  Dialector
//
//  Created by Keith Avery on 10/14/13.
//  Copyright (c) 2013 Keith Avery. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DefaultLookback = 2;

@interface DialectorLetterList : NSObject

@property (nonatomic) int lookback;
@property (nonatomic) NSMutableDictionary *histogram;

- (id)initWithLookback:(int)lookback;

- (void)addWord:(NSString *)word;

- (void)addText:(NSString *)corpus;

- (NSString *)makeWord;

+ (int)total:(NSMutableDictionary *)tuple;
@end
