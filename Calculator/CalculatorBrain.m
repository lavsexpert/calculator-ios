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

- (void)setUnary:(NSString *)newOperation:(double)newOperand;
{
    binary = NO;
    operation = newOperation;
    first = newOperand;
    second = 0;
}

- (double)calculate:(NSString *)newOperation:(double)newOperand{
    // После нажатия кнопки операции выполним:
    // 1) сохранить в память 2й операнд
    // 2) выполнить операцию, вывести на дисплей результат
    saved = second;
    if ([newOperation isEqual:@"C"]||[newOperation isEqual:@""]) {
        
        [self setUnary:@"":newOperand];
        display = 0;
        
    } else if ([newOperation isEqual:@"1/x"]){
        
        [self setUnary:newOperation:newOperand];
        if (newOperand) {
            display = 1 / newOperand;
        } else {
            display = 0;
        }
        
    } else if ([newOperation isEqual:@"+/-"]){
        
        [self setUnary:newOperation:newOperand];
        display = - newOperand;
        
    } else if ([newOperation isEqual:@"√"]){
        
        [self setUnary:newOperation:newOperand];
        if (newOperand >= 0) {
            display = sqrt(newOperand);
        }
        else{
            display = sqrt(- newOperand);
        }
        
    } else if ([newOperation isEqual:@"="]){
        
        [self calculate:operation:display];
        
    } else {
        
        binary = YES;
        first = display;
        second = newOperand;
        
        if([@"+" isEqual:operation])
        {
            display = first + second;
        } else if ([@"*" isEqual:operation]){
            display = first * second;
        } else if ([@"-" isEqual:operation]){
            display = first - second;
        } else if ([@"/" isEqual:operation]){
            if (second) {
                display = first / second;
            } else {
                display = 0;
            }
        }
        
    }
    return display;
}

- (void)updateOperand:(double)newOperand{
    // После нажатия цифры в мозге осталось сделать:
    // 2) если операция пустая:
    // - сохранить содержимое дисплея в 1й операнд
    // - очистить 2й операнд
    // 3) если операция заполнена:
    // - восстановить в 1й операнд сохранённое ранее значение 2го операнда
    // - сохранить содержимое дисплея во 2й операнд
    if ([operation isEqual:@""]){
        first = newOperand;
        second = 0;
    } else {
        first = saved;
        second = newOperand;
    }
}

- (void)updateOperation:(NSString *)newOperation:(double)newOperand{
    // После нажатия кнопки операции и вывода результата осталось:
    // 3) поменять операцию на нажатую или очистить унарную
    // 4) поместить то, что на дисплее в 1й операнд
    // 5) очистить 2й операнд
    first = newOperand;
    if (binary) {
        operation = @"";
    } else {
        operation = newOperation;
    }
    second = 0;
}

- (NSString *)more {
    if ([operation isEqual:@""]) {
        return @"";
    // Если операция унарная, то выводим в формате @(a) = z
    } else if (!binary){
        return [NSString stringWithFormat:@"%@(%g) = %g", operation, first, display];
    // Если операция бинарная, то выводим в формате a @ b = z
    } else {
        return [NSString stringWithFormat:@"%g %@ %g = %g", first, operation, second, display];
    }
}

@end
