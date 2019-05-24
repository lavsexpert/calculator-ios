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

// При создании контролёра ...
- (CalculatorBrain *)brain {
    currents = 0;
    newDigit = false;
    pendingOp = @"";
    // Создаётся мозг калькулятора
    if (!brain) brain = [[CalculatorBrain alloc] init];
        return brain;
}

//  При нажатии на цифру ...
- (IBAction)digitPressed:(UIButton *)sender {
    if(newDigit){
        display.text = sender.titleLabel.text;
        newDigit = false;
    } else {
        if([display.text isEqualToString: @"0"]){
            display.text = sender.titleLabel.text;
        } else {
            display.text = [display.text stringByAppendingString: sender.titleLabel.text];
        }
    }
}

// При нажатии на операцию ...
- (IBAction)operationPressed:(UIButton *)sender{
    if(newDigit && ![pendingOp isEqualToString:@"="]){
        display.text = [NSString stringWithFormat:@"%f", currents];
    } else {
        newDigit = true;
        if ([pendingOp isEqualToString:@"+"]) {
            currents += [display.text doubleValue];
        }
        else if ([pendingOp isEqualToString:@"-"]){
            currents -= [display.text doubleValue];
        }
        else if ([pendingOp isEqualToString:@"*"]){
            currents *= [display.text doubleValue];
        }
        else if ([pendingOp isEqualToString:@"/"]){
            if ([display.text doubleValue] == 0){
                currents = 0;
            } else {
                currents /= [display.text doubleValue];
            }
        }
        else {
            currents = [display.text doubleValue];
        }
        display.text = [NSString stringWithFormat:@"%f", currents];
        pendingOp = sender.titleLabel.text;
    }
}

- (IBAction)clearPressed:(UIButton *)sender{
    currents = 0;
    pendingOp = @"";
    [self clearEntryPressed: sender];
}


- (IBAction)clearEntryPressed:(UIButton *)sender{
    display.text = @"0";
    newDigit = true;
}

- (IBAction)negativePressed:(UIButton *)sender{
    display.text = [NSString stringWithFormat:@"%f", [display.text doubleValue] * (-1)];
    newDigit = true;
}

- (IBAction)inversePressed:(UIButton *)sender{
    if([display.text doubleValue] == 0){
        display.text = @"0";
    } else {
        display.text = [NSString stringWithFormat:@"%f", 1 / [display.text doubleValue]];
    }
    newDigit = true;
}

- (IBAction)decimalPressed:(UIButton *)sender{
    NSString *currentDisplay = display.text;
    if(newDigit){
        currentDisplay = @"0.";
        newDigit = false;
    } else {
        NSRange findPoint = [currentDisplay rangeOfString:@"."];
        if(findPoint.location == NSNotFound){
            currentDisplay = [currentDisplay stringByAppendingString:@"."];
        }
    }
    display.text = currentDisplay;
}

- (IBAction)percentPressed:(UIButton *)sender{
    display.text = [NSString stringWithFormat:@"%f", ([display.text doubleValue] / 100) * currents];
    newDigit = true;
}

@end
