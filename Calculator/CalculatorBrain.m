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

- (double)preformOperation:(NSString *)operation{
    if ([operation isEqual:@"v"])
    {
        operand = sqrt(operand);
    } else {
        [self performWaitingOperation];
        waitingOperation = operation;
        waitingOperand = operand;
    }
    return operand;
}

@end
