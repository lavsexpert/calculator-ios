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

// При создании контролёра ...
- (CalculatorBrain *)brain {
    // Создаётся мозг калькулятора
    if (!brain) brain = [[CalculatorBrain alloc] init];
        return brain;
}

//  При нажатии на цифру ...
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

// При нажатии на операцию ...
- (IBAction)operationPressed:(UIButton *)sender{
    // Выключается добавление цифр и обновляются дисплеи
    appendingDigit = NO;
    [self updateDisplay: sender.titleLabel.text];
    display.text = [NSString stringWithFormat:@"%g", self.brain.result];
}

// При обновлении дисплея ...
- (void)updateDisplay :(NSString *)button{
    // Мозг начинает думать и обновляет отображенное
    [self.brain thinking :button :[display.text doubleValue]];
    more.text = self.brain.more;
}

@end
