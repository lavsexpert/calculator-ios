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
    // При нажатии кнопки операции нужно:
    // 1) сохранить в память 2й операнд (в мозге)
    // 2) выполнить операцию, вывести на дисплей результат и расшифровку
    // 3) поменять операцию на нажатую или очистить унарную (в мозге)
    // 4) поместить то, что на дисплее в 1й операнд (в мозге)
    // 5) очистить 2й операнд (в мозге)
    
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
    [self.brain updateOperation:operation:operand];
}

- (IBAction)digitPressed:(UIButton *)sender {
    // При нажатии на кнопку цифры нужно:
    // 1) обновить содержимое дисплея
    // 2) если операция пустая (в мозге):
    // - сохранить содержимое дисплея в 1й операнд
    // - очистить 2й операнд
    // 3) если операция заполнена (в мозге):
    // - восстановить в 1й операнд сохранённое ранее значение 2го операнда
    // - сохранить содержимое дисплея во 2й операнд
    // 4) обновить расшифровку
    
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
