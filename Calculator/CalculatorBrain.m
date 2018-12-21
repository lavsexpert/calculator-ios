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
@synthesize operand;

- (void)performWaitingOperation {
    if([@"+" isEqual:waitingOperation])
    {
        operand = waitingOperand + operand;
    } else if ([@"*" isEqual:waitingOperation]){
        operand = waitingOperand * operand;
    } else if ([@"-" isEqual:waitingOperation]){
        operand = waitingOperand - operand;
    } else if ([@"/" isEqual:waitingOperation]){
        if (operand) {
            operand = waitingOperand / operand;
        }
    }
}

- (double)performOperation:(NSString *)operation{
    if ([operation isEqual:@"C"]) {
        operand = 0;
    } else if ([operation isEqual:@"1/x"]){
        if (operand) {
            operand = 1 / operand;
        }
    } else if ([operation isEqual:@"+/-"]){
        operand = 0 - operand;
    } else if ([operation isEqual:@"v"]){
        operand = sqrt(operand);
    } else if ([operation isEqual:@"="]){
        [self performWaitingOperation];
        waitingOperation = operation;
        waitingOperand = operand;
    } else {
        [self performWaitingOperation];
        waitingOperand = operand;
    }
    return operand;
}

@end
