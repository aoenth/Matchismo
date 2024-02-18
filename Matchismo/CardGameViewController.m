//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Kevin on 2017-06-09.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic)  NSArray<UIButton *> *cardButtons;
@property (strong, nonatomic) UILabel *scoreLabel;

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [self addButtons];
    [self addScoreLabel];
}

- (void)addScoreLabel
{
    UILabel *label = UILabel.new;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    [self.view addSubview:label];

    [NSLayoutConstraint activateConstraints:@[
        [label.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [label.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-64]
    ]];

    self.scoreLabel = label;
}

- (void)addButtons
{
    UIStackView *vStack = UIStackView.new;
    vStack.axis = UILayoutConstraintAxisVertical;
    vStack.translatesAutoresizingMaskIntoConstraints = NO;
    vStack.spacing = 8;

    NSMutableArray<UIButton *> *buttons = NSMutableArray.new;

    for (NSInteger i = 0; i < 3; i++) {
        UIStackView *hStack = UIStackView.new;
        hStack.axis = UILayoutConstraintAxisHorizontal;
        hStack.spacing = 8;
        for (NSInteger j = 0; j < 4; j++) {
            UIButton *card = [[UIButton alloc] initWithFrame:CGRectZero];
            UIImage *image = [UIImage imageNamed:@"Card Back"];
            [card setBackgroundImage:image forState:UIControlStateNormal];
            card.translatesAutoresizingMaskIntoConstraints = NO;

            [NSLayoutConstraint activateConstraints:@[
            ]];

            [card addTarget:self action:@selector(touchCardButton:) forControlEvents:UIControlEventTouchUpInside];
            [hStack addArrangedSubview:card];
            [buttons addObject:card];
        }
        [vStack addArrangedSubview:hStack];
    }

    [self.view addSubview:vStack];

    [NSLayoutConstraint activateConstraints:@[
        [vStack.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [vStack.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
    ]];

    self.cardButtons = buttons;
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)deck {
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck { // abstract
    return nil;
}



- (void)touchCardButton:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"Card Front" : @"Card Back"];
}


@end
