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
    if (userIsInTheMiddleOfTypingANumber){
        self.brain.operand = [display.text doubleValue];
        userIsInTheMiddleOfTypingANumber = NO;
    }
    NSString *operation = sender.titleLabel.text;
    double result = [self.brain performOperation:operation];
    display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.titleLabel.text;
    if (userIsInTheMiddleOfTypingANumber) {
        display.text = [display.text stringByAppendingString:digit];
    } else {
        display.text = digit;
        userIsInTheMiddleOfTypingANumber = YES;
    }
}

@end
