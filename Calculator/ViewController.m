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
    // Очищаем подробное описание
    more.text = @"";
}

- (IBAction)unaryPressed:(UIButton *)sender{
    NSString *operation = sender.titleLabel.text;
    double first = [display.text doubleValue];
    double result = [self.brain calculate: operation: first: 0];
    display.text = [NSString stringWithFormat:@"%g", result];
    more.text = [NSString stringWithFormat:@"%@(%g) = %g", self.brain.operation, self.brain.first, result];
}

- (IBAction)binaryPressed:(UIButton *)sender{
    display.text = @"0";
    more.text = @"";
}

- (IBAction)managePressed:(UIButton *)sender{
    display.text = @"0";
    more.text = @"";
}

@end
