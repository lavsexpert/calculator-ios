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

@synthesize first;
@synthesize operation;
@synthesize second;
@synthesize result;
@synthesize more;
@synthesize savedNumber;
@synthesize prevOperation;

// Преобразование нажатой кнопки и выведенного на экране в параметры операции с последующим её выполнением.
- (void)compute :(NSString *)button :(double)display{

    // Если нажата цифра
    if ([button isEqual:@"1"]||[button isEqual:@"2"]||[button isEqual:@"3"]
        ||[button isEqual:@"4"]||[button isEqual:@"5"]||[button isEqual:@"6"]
        ||[button isEqual:@"7"]||[button isEqual:@"8"]||[button isEqual:@"9"]
        ||[button isEqual:@"0"]){
        
        // Если ещё не указывалась операция
        if([operation isEqual:@""]||[operation isEqual:nil]){
            self.first = 0;
            self.operation = @"";
            self.second = display;
        } else {
        // Если же уже есть первый операнд и операция указывалась
            self.first = self.savedNumber;
            self.operation = self.prevOperation;
            self.second = display;
        }
        self.result = [self calculate :self.first :self.operation :self.second];
        self.prevOperation = self.operation;
    
    // Если нажата кнопка сброса - очищаем все параметры операции
    } else if ([button isEqual:@"C"]) {
        self.first = 0;
        self.operation = @"";
        self.second = 0;
        self.result = [self calculate :self.first :self.operation :self.second];
        self.prevOperation = self.operation;
        self.savedNumber = self.result;
        
    // Если нажата кнопка операции
    } else {
        // Если это первая операция с запуска или очистки
        if([operation isEqual:@""]||[operation isEqual:@"="]){
            self.first = display;
            self.operation = button;
            self.second = 0;
        // Если же эта операция не первая
        } else {
            self.first = self.result;
            self.operation = button;
            self.second = 0;
        }
        self.result = [self calculate :self.first :self.operation :self.second];
        self.prevOperation = self.operation;
        self.savedNumber = self.result;
    }
}

// Вычисление операции: a @ b = ? или @(a) = ?
- (double)calculate :(double)first :(NSString *)operation :(double)second{
    
    // Унарные операции
    if ([operation isEqual:@"1/x"]){
        if (first) {
            self.result = 1 / first;
        } else {
            self.result = 0;
        }
        [self more: YES];
        
    } else if ([operation isEqual:@"+/-"]){
        if (first){
            self.result = - first;
        } else {
            self.result = 0;
        }
        [self more: YES];
        
    } else if ([operation isEqual:@"√"]){
        if (first < 0) {
            self.first = - first;
        }
        self.result = sqrt(self.first);
        [self more: YES];
        
    // Бинарные операции
    } else if ([operation isEqual:@"+"]){
        self.result = first + second;
        [self more: NO];
        
    } else if ([operation isEqual:@"-"]){
        self.result = first - second;
        [self more: NO];
        
    } else if ([operation isEqual:@"*"]){
        self.result = first * second;
        [self more: NO];
        
    } else if ([operation isEqual:@"/"]){
        if (second) {
            self.result = first / second;
        } else {
            self.result = 0;
        }
        [self more: NO];
        
    } else if ([operation isEqual:@"="]){
        self.result = [self calculate :first :self.prevOperation :second];
        self.prevOperation = @"";
        self.operation = @"";
        
    } else {
        self.result = 0;
        self.more = @"";
        self.savedNumber = 0;

    }
    return self.result;
}

// Формирование строки с выполняемой операцией x @ y = z или @(x) = z
- (void)more :(BOOL)unary{
    if (unary){
        // Унарные операции выводятся в виде @(x) = z
        self.more = [NSString stringWithFormat:@"%@(%g) = %g", self.operation, self.first, self.result];
    } else {
        // Бинарные операции выводятся в виде x @ y = z
        self.more = [NSString stringWithFormat:@"%g %@ %g = %g", self.first, self.operation, self.second, self.result];
    }
}

@end
