//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Sergey Lavrov on 20.12.2018.
//  Copyright © 2018 +1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorBrain.h"

@implementation CalculatorBrain

@synthesize newDigit;
@synthesize currents;
@synthesize operation;

- (id) init{
    self = [super init];
    if (self){
        currents = 0;
        newDigit = true;
        operation = @"";
    }
    return self;
}

// Добавление цифр и десятичной точки
- (NSString*)addDigit :(NSString *)button :(NSString *)display{
    // Когда начинаем набирать, то пишем нажатую кнопку или "0." если нажали "." и отмечаем, что продолжаем набор
    if(newDigit){
        display = ([button isEqualToString:@"."]) ? @"0." : button;
        newDigit = false;
    // Если продолжаем набирать и нажата кнопка "." - то добавляем только если нет точки в числе
    } else if ([button isEqualToString:@"."]) {
        if([display rangeOfString:@"."].location == NSNotFound){
            display = [display stringByAppendingString:@"."];
        }
    // Продолжаем набирать цифры, но не более 10 - чтобы не вылезти за пределы экрана
    } else {
        if(display.length < 10) {
            display = [display stringByAppendingString: button];
        }
    }
    return display;
}

// Выполнение операций над числами
- (NSString*)compute :(NSString *)button :(NSString *)display{
    // Очистка операций с числами
    if ([button isEqualToString:@"C"]) {
        currents = 0;
        operation = @"";
        display = @"0";
    // Изменение знака числа
    } else if([button isEqualToString:@"+/-"]){
        display = [NSString stringWithFormat:@"%f", [display doubleValue] * (-1)];
    // Получение обратного числа с проверкой на 0 - для него возвращается 0/
    } else if([button isEqualToString:@"1/x"]){
        display = ([display doubleValue] == 0) ? @"0" : [NSString stringWithFormat:@"%f", 1 / [display doubleValue]];
    // Если операция уже была выполнена - то просто выводим результат
    } else if(newDigit && ![operation isEqualToString:@"="]){
        display = [NSString stringWithFormat:@"%f", currents];
    // А теперь бинарные операции + - * / %
    } else {
        if ([operation isEqualToString:@"+"]) {
            currents += [display doubleValue];
        }
        else if ([operation isEqualToString:@"-"]){
            currents -= [display doubleValue];
        }
        else if ([operation isEqualToString:@"*"]){
            currents *= [display doubleValue];
        }
        else if ([operation isEqualToString:@"/"]){
            currents = ([display doubleValue] == 0) ? 0 : currents / [display doubleValue];
        }
        else if ([operation isEqualToString:@"%"]){
            currents = ([display doubleValue] / 100) * currents;
        }
        else {
            currents = [display doubleValue];
        }
        display = [NSString stringWithFormat:@"%f", currents];
        operation = button;
    }
    newDigit = true;
    return display;
}

@end
