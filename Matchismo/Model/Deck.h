//
//  Deck.h
//  Matchismo
//
//  Created by Kevin on 2017-06-09.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void) addCard:(Card *)card atTop:(BOOL)atTop;
- (void) addCard:(id)card;

-(Card *)drawRandomCard;
@end
