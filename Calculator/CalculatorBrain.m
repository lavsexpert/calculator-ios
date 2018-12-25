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

- (void)calculateTwo {
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
        }
    }
}

- (double)calculate:(NSString *)newOperation:(double)newOperand{
    if ([newOperation isEqual:@"C"]||[newOperation isEqual:@""]) {
        binary = NO;
        operation = @"";
        first = 0;
        second = 0;
        display = 0;
    } else if ([newOperation isEqual:@"1/x"]){
        binary = NO;
        operation = newOperation;
        first = newOperand;
        second = 0;
        if (newOperand) {
            display = 1 / newOperand;
        }
    } else if ([newOperation isEqual:@"+/-"]){
        binary = NO;
        operation = newOperation;
        first = newOperand;
        second = 0;
        display = - newOperand;
    } else if ([newOperation isEqual:@"v"]){
        binary = NO;
        operation = newOperation;
        first = newOperand;
        second = 0;
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
        [self calculateTwo];
        operation = newOperation;
    }
    return display;
}

- (void)updateOperand:(double)newOperand{
    second = newOperand;
}

- (NSString *)more {
    if ([operation isEqual:@""]) {
        return @"";
    } else if (!binary){
        return [NSString stringWithFormat:@"%@(%g) = %g", operation, first, display];
    } else {
        return [NSString stringWithFormat:@"%g %@ %g = %g", first, operation, second, display];
    }
}

@end
