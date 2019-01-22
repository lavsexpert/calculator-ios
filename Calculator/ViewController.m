//
//  ViewController.m
//  Calculator
//
//  Created by Sergey Lavrov on 20.12.2018.
//  Copyright © 2018 +1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (CalculatorBrain *)brain {
    if (!brain) brain = [[CalculatorBrain alloc] init];
        return brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    // Убираем лидирующий ноль
    if ([display.text isEqual:@"0"])
    {
        appendingDigit = NO;
    }
    // Сохраняем введённую цифру и добавляем её в конец
    NSString *digit = sender.titleLabel.text;
    if (appendingDigit) {
        display.text = [display.text stringByAppendingString:digit];
    // или выводим цифру на дисплей и включаем режим добавления цифр
    } else {
        display.text = digit;
        appendingDigit = YES;
    }
    [self updateDisplay: sender.titleLabel.text];
}

- (IBAction)operationPressed:(UIButton *)sender{
    appendingDigit = NO;
    [self updateDisplay: sender.titleLabel.text];
    display.text = [NSString stringWithFormat:@"%g", self.brain.result];
}

- (void)updateDisplay :(NSString *)button{
    [self.brain thinking :button :[display.text doubleValue]];
    more.text = self.brain.more;
}

@end
