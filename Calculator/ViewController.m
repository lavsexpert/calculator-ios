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

- (IBAction)operationPressed:(UIButton *)sender{
    // Выключаем добавление цифр на дисплее
    if (appendingDigit){
        appendingDigit = NO;
    }
    // Сохраняем операцию и операнд, просим мозг посчитать
    double operand = [display.text doubleValue];
    NSString *operation = sender.titleLabel.text;
    double result = [self.brain calculate:operation:operand];
    // Выводим результат вычислений
    display.text = [NSString stringWithFormat:@"%g", result];
    more.text = [self.brain more];
}

- (IBAction)digitPressed:(UIButton *)sender {
    // Сохраняем введённую цифру и добавляем её в конец
    NSString *digit = sender.titleLabel.text;
    if (appendingDigit) {
        display.text = [display.text stringByAppendingString:digit];
    // или выводим цифру на дисплей и включаем режим добавления цифр
    } else {
        display.text = digit;
        appendingDigit = YES;
    }
    [self.brain updateOperand:[display.text doubleValue]];
    more.text = [self.brain more];
}

@end
