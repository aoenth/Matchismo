//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Kevin on 2017-06-13.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}
@end
