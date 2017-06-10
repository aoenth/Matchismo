//
//  ViewController.m
//  Matchismo
//
//  Created by Kevin on 2017-06-09.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) PlayingCardDeck *playingCardDeck;
@end

@implementation ViewController

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount = %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    PlayingCardDeck *newCard = [[PlayingCardDeck alloc]init];
    // It actually returns nothing ( a void method )
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"Card Back"] forState:UIControlStateNormal];
        [sender setTitle:nil forState:UIControlStateNormal];
    } else {
        [sender setBackgroundImage:[UIImage imageNamed:@"Card Front"] forState:UIControlStateNormal];
        [sender setTitle:[[newCard drawRandomCard] contents] forState:UIControlStateNormal];
    }
    self.flipCount++;

}




@end
