//
//  Card.h
//  Matchismo
//
//  Created by Kevin on 2017-06-09.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;

@property (nonatomic, getter=isMatched) BOOL matched;

- (int) match:(Card *)card;

@end
