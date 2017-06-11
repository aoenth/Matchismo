//
//  PlayingCard.m
//  Matchismo
//
//  Created by Kevin on 2017-06-09.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards {
    
    if ([otherCards count] == 1) {
        return [self getScore:self :[otherCards firstObject]];
    } else if ([otherCards count] == 2) {
        if ([self getScore:self :[otherCards firstObject]]) {
            return 4 + [self getScore:self :otherCards[1]];
        } else {
            return [self getScore:[otherCards firstObject] :otherCards[1]];
        }
    }
    return 0;
}

- (int)getScore:(PlayingCard *)card1 :(PlayingCard *)card2 {
    int score = 0;
    if ([card1.suit isEqualToString:card2.suit]) {
        score = 1;
    } else if (card1.rank == card2.rank) {
        score = 4;
    }
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide getter AND setter

+ (NSArray *)validSuits {
    return @[@"❤️",@"♦️", @"♠️", @"♣️"];
}



- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}



- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count] - 1; }

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


@end
