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
    operation = @"";
    button = @"";
    display = @"0";
    // Создаётся мозг калькулятора
    if (!brain) brain = [[CalculatorBrain alloc] init];
        return brain;
}

//  При нажатии на цифру ...
- (IBAction)digitPressed:(UIButton *)sender {
    display = displayLabel.text;
    button = sender.titleLabel.text;
    if(newDigit){
        display = ([display isEqualToString:@"."]) ? @"0." : button;
        newDigit = false;
    } else if ([display isEqualToString:@"."]) {
        NSRange findPoint = [display rangeOfString:@"."];
        if(findPoint.location == NSNotFound){
            display = [display stringByAppendingString:@"."];
        }
    } else {
        if([display isEqualToString: @"0"]){
            display = button;
        } else if(display.length < 10) {
            display = [display stringByAppendingString: button];
        }
    }
    displayLabel.text = display;
}

// При нажатии на операцию ...
- (IBAction)operationPressed:(UIButton *)sender{
    display = displayLabel.text;
    button = sender.titleLabel.text;
    if ([button isEqualToString:@"C"]) {
        currents = 0;
        operation = @"";
        displayLabel.text = @"0";
        newDigit = true;
    } else if([button isEqualToString:@"+/-"]){
        displayLabel.text = [NSString stringWithFormat:@"%f", [display doubleValue] * (-1)];
        newDigit = true;
    } else if([button isEqualToString:@"1/x"]){
        if([displayLabel.text doubleValue] == 0){
            displayLabel.text = @"0";
        } else {
            displayLabel.text = [NSString stringWithFormat:@"%f", 1 / [displayLabel.text doubleValue]];
        }
        newDigit = true;
    } else if(newDigit && ![operation isEqualToString:@"="]){
        displayLabel.text = [NSString stringWithFormat:@"%f", currents];
    } else {
        newDigit = true;
        if ([operation isEqualToString:@"+"]) {
            currents += [displayLabel.text doubleValue];
        }
        else if ([operation isEqualToString:@"-"]){
            currents -= [displayLabel.text doubleValue];
        }
        else if ([operation isEqualToString:@"*"]){
            currents *= [displayLabel.text doubleValue];
        }
        else if ([operation isEqualToString:@"/"]){
            if ([displayLabel.text doubleValue] == 0){
                currents = 0;
            } else {
                currents /= [displayLabel.text doubleValue];
            }
        }
        else if ([operation isEqualToString:@"%"]){
            currents = ([displayLabel.text doubleValue] / 100) * currents;
            newDigit = true;
        }
        else {
            currents = [displayLabel.text doubleValue];
        }
        displayLabel.text = [NSString stringWithFormat:@"%f", currents];
        operation = sender.titleLabel.text;
    }
}

@end
