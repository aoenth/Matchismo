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
@property (nonatomic) int numberOfCardsChosen;

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
    NSLog(@"Number of Cards Chosen before at %d: %d", index, _numberOfCardsChosen);
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against another card
            _numberOfCardsChosen++;
            card.chosen = YES;
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched && _numberOfCardsChosen == 3) {
                    for (Card *chosenCards in self.cards) {
                        if (chosenCards.isChosen) chosenCards.matched = YES;
                    }
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        for (Card *chosenCards in self.cards) {
                            if (chosenCards.isChosen) chosenCards.matched = YES;
                        }
                        NSLog(@"Matched! Scored %d", matchScore);
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *chosenCards in self.cards) {
                            if (!chosenCards.isMatched) chosenCards.chosen = NO;
                        }
                        NSLog(@"No Match! Scored %d", matchScore);
                        _numberOfCardsChosen = 0;
                        return;
                    }
                    _numberOfCardsChosen = 0;
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
        }
    }
    NSLog(@"Number of Cards Chosen after at %d: %d", index, _numberOfCardsChosen);
}


- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (instancetype)init {
    return nil;
}
@end
