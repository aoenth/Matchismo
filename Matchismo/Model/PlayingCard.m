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
        PlayingCard *otherCard = [otherCards firstObject]; // if array is empty, it returns nil, instead of crash if accessed at index = 0
        return [self getScore:self :otherCard];
    } else if ([otherCards count] == 2) {
        if ([self getScore:self :[otherCards firstObject]] && [self getScore:self :otherCards[1]]) {
            return 16;
        }
    }
    return 0;
}

- (int)getScore:(PlayingCard *)card1 :(PlayingCard *)card2 {
    if ([card1.suit isEqualToString:card2.suit]) {
        return 1;
    } else if (card1.rank == card2.rank) {
        return 4;
    }
    return 0;
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
