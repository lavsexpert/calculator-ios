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
    double second = [display.text doubleValue];
    [self.brain calculate: self.brain.operation: self.brain.first: second];
    [self showMore];
}

- (IBAction)unaryPressed:(UIButton *)sender{
    appendingDigit = NO;
    NSString *operation = sender.titleLabel.text;
    double first = [display.text doubleValue];
    double result = [self.brain calculate: operation: first: 0];
    display.text = [NSString stringWithFormat:@"%g", result];
    [self showMore];
}

- (IBAction)binaryPressed:(UIButton *)sender{
    appendingDigit = NO;
    NSString *operation = sender.titleLabel.text;
    self.brain.prevOperation = operation;
    [self showMore];
}

- (IBAction)managePressed:(UIButton *)sender{
    if ([self.brain.operation isEqual:@"C"]||[self.brain.operation isEqual:@""]){
        [self.brain clear];
    }
    display.text = @"0";
    more.text = @"";
    
}

- (void)showMore{
    if ([self.brain.operation isEqual:@"C"]||[self.brain.operation isEqual:@""]){
        more.text = @"";
    } else if ([self.brain.operation isEqual:@"+"]||[self.brain.operation isEqual:@"-"]||[self.brain.operation isEqual:@"*"]||[self.brain.operation isEqual:@"/"]){
        
        more.text = [NSString stringWithFormat:@"%g %@ %g = %g", self.brain.first, self.brain.operation, self.brain.second, self.brain.result];
    } else {
        more.text = [NSString stringWithFormat:@"%@(%g) = %g", self.brain.operation, self.brain.first, self.brain.result];
    }
}

@end
