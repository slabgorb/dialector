//
//  DialectorLetterList
//  Dialector
//
//  Created by Keith Avery on 10/14/13.
//  Copyright (c) 2013 Keith Avery. All rights reserved.
//
/* 
Models the list of characters in the chain. The characters
each have a corresponding int value, which is the proportion of
those characters which follow the key pattern.
*/


#import "DialectorLetterList.h"

@implementation DialectorLetterList

@synthesize lookback = _lookback;

- (void) setLookback:(int)lookback
{
    if (lookback > 1) {
        _lookback = lookback;
    }
}

- (int) lookback
{
    if (_lookback > 0) {
        return _lookback;
    } else {
        return 2;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        return self;
    }
    return nil;
}
- (id)initWithLookback:(int)lookback {
    self = [super init];
    if (self) {
        [self setLookback:lookback];
        _histogram = [NSMutableDictionary dictionaryWithCapacity:28];
        return self;
    }
    return nil;
}

- (void)addText:(NSString *)string {

    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for (int i = 0; i < [array count]; i++ ) {
        [self addWord: [array objectAtIndex:i]];
    }
    // NSLog(@"%@", _histogram);
}


+ (int)total:(NSMutableDictionary *)tuple {
    NSArray *values = [tuple allValues];
    int sum = 0;
    for (NSNumber *n in values) {
        sum += [n intValue];
    }
    return sum;
}

- (NSString *)makeWord {
    // set up return value holder
    NSMutableString *word = [[NSMutableString alloc] init];
    [word setString:@"^"];
    
    // start with beginning word marker(s)
    NSMutableString *key = [[NSMutableString alloc] init];
    [key appendString:[@"" stringByPaddingToLength:_lookback withString: @"^" startingAtIndex:0]];
    NSString *endCharacter = @"";
    while (![key hasSuffix:@"$"]) {
        NSMutableDictionary *tuple = [_histogram objectForKey: key];
        int currentPlace = 0;
        int total_ = [DialectorLetterList total:tuple];
        int rand = arc4random() % total_;

        NSArray *tupleKeys = [tuple allKeys];
        
        // loop over the values of the tuple, and find out where the random number puts us
        for (NSString *tupleKey in tupleKeys) {
            NSNumber *thisValue = [tuple objectForKey:tupleKey];
            currentPlace += thisValue.intValue;
            if (currentPlace > rand) {
                [word appendString:tupleKey];
                endCharacter = tupleKey;
                // pop the first character off the key
                [key deleteCharactersInRange:NSMakeRange(0, 1)];
                // push the next character onto the key
                [key appendString:endCharacter];
                break;
            }
        }
    }
    // NSLog(@"%@", [self normalizeWord:word]);
    return [self normalizeWord:word];
}

- (NSString *)normalizeWord:(NSString *)word {
    return [[[[word decomposedStringWithCanonicalMapping]lowercaseString] componentsSeparatedByCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]] componentsJoinedByString:@""];
}

// adds a word to the chain
- (void)addWord:(NSString *)word {
    // NSLog(@"%@", word);
    if (word.length != 0) {
        
        // tell that word to be cool! Be cool, word!
        word = [self normalizeWord:word];
        
        // add a $ to the end
        NSMutableString *newWord = [[NSMutableString alloc] initWithString:word];
        [newWord appendString:@"$"];
        word = newWord; // this language is kind of annoying, really.
        
        // create a histogram keyed to a string of characters with a length of lookback
        NSMutableString *key = [[NSMutableString alloc] init];
        
        // start with beginning word marker(s)
        [key appendString:[@"" stringByPaddingToLength:_lookback withString: @"^" startingAtIndex:0]];
        for (int i = 0; i < [word length]; i++) {
            
            // get the character at this index
            NSString *thisCharacter = [NSString stringWithFormat:@"%c", [word characterAtIndex:i]];
            NSMutableDictionary *tuple;
            
            // get the sub-dictionary of the letters 'after' the key
            if ([[_histogram allKeys] containsObject:key]) {
                tuple = [_histogram objectForKey: key];
            } else {
                tuple = [[NSMutableDictionary alloc] init];
                [tuple setObject:@0 forKey:thisCharacter];
            }
            NSNumber *current = [tuple objectForKey:thisCharacter];

            // increment the count of that letter match
            [tuple setObject:@(current.intValue + 1) forKey:thisCharacter];
            
            // update the histogram
            [_histogram setObject:tuple forKey: key];
            
            // pop the first character off the key
            [key deleteCharactersInRange:NSMakeRange(0, 1)];
            // push the next character onto the key
            [key appendString:thisCharacter];

        }
        
        
    }
}
@end
