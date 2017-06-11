//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Kevin on 2017-06-10.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
// only use readwrite if .h file uses read only
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Cards
@property (nonatomic, readwrite) int numberOfChosenCards;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck: (Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define COST_TO_CHOOSE 1
// or
// static const int MISMATCH_PENALTY = 2;

- (void)chooseCardAtIndex:(NSUInteger)index {
    NSLog(@"%d", (int) _numberOfChosenCards);
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against another card
            for (Card *otherCard in self.cards) {
                if (_numberOfChosenCards ==  2) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            otherCard.matched = YES;
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                        }
                        break;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            if (_numberOfChosenCards > 2) {
                _numberOfChosenCards = 0;
            } else {
                NSLog(@"Before adding, numberOfChosenCards is %d", _numberOfChosenCards);

                _numberOfChosenCards++;
                NSLog(@"Just added one when numberOfChosenCards is %d", _numberOfChosenCards);
            }
        }
    }
}


- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (instancetype)init {
    return nil;
}
@end
