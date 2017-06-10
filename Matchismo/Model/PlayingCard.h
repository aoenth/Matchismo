//
//  PlayingCard.h
//  Matchismo
//
//  Created by Kevin on 2017-06-09.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayingCard : NSObject

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
