//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Kevin on 2017-06-10.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// how many cards we're playing with?
// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck: (Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

// read only, nobody should set the score, in other words, the setter is disabled
@property (nonatomic, readonly) int score;


@end
