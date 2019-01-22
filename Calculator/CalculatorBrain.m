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

- (void)thinking :(NSString *)button :(double)display{

    if ([button isEqual:@"1"]||[button isEqual:@"2"]||[button isEqual:@"3"]
        ||[button isEqual:@"4"]||[button isEqual:@"5"]||[button isEqual:@"6"]
        ||[button isEqual:@"7"]||[button isEqual:@"8"]||[button isEqual:@"9"]
        ||[button isEqual:@"0"]){
        
        if([operation isEqual:@""]||[operation isEqual:nil]){
            self.first = self.result;
            self.operation = @"";
            self.second = display;
        } else {
            self.first = self.savedNumber;
            self.operation = self.prevOperation;
            self.second = display;
        }
    } else if ([button isEqual:@"C"]) {
        self.first = 0;
        self.operation = @"";
        self.second = 0;
    } else {
        if([operation isEqual:@""]||[operation isEqual:@"="]){
            self.first = display;
            self.operation = button;
            self.second = 0;
        } else {
            self.first = display;
            self.operation = button;
            self.second = 0;
        }
    }
    self.result = [self calculate :self.first :self.operation :self.second];
    self.prevOperation = self.operation;
    self.savedNumber = self.result;
}

- (double)calculate :(double)first :(NSString *)operation :(double)second{
    
    // Унарные операции
    if ([operation isEqual:@"1/x"]){
        if (second) {
            self.result = 1 / second;
        } else {
            self.result = 0;
        }
        [self more: YES];
        
    } else if ([operation isEqual:@"+/-"]){
        if (second){
            self.result = - second;
        } else {
            self.result = 0;
        }
        [self more: YES];
        
    } else if ([operation isEqual:@"√"]){
        if (second < 0) {
            self.first = - second;
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
        
    } else {
        self.result = 0;
        self.more = @"";
        self.savedNumber = 0;

    }
    return self.result;
}

- (void)more :(BOOL)unary{
    if (unary){
        self.more = [NSString stringWithFormat:@"%@(%g) = %g", self.operation, self.first, self.result];
    } else {
        self.more = [NSString stringWithFormat:@"%g %@ %g = %g", self.first, self.operation, self.second, self.result];
    }
}

@end
