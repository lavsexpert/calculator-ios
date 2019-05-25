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
        newDigit = false;
        operation = @"";
    }
    return self;
}

- (NSString*)addDigit :(NSString *)button :(NSString *)display{
    if(newDigit){
        display = ([button isEqualToString:@"."]) ? @"0." : button;
        newDigit = false;
    } else if ([button isEqualToString:@"."]) {
        if([display rangeOfString:@"."].location == NSNotFound){
            display = [display stringByAppendingString:@"."];
        }
    } else {
        if([display isEqualToString: @"0"]){
            display = button;
        } else if(display.length < 10) {
            display = [display stringByAppendingString: button];
        }
    }
    return display;
}

- (NSString*)compute :(NSString *)button :(NSString *)display{
    if ([button isEqualToString:@"C"]) {
        currents = 0;
        operation = @"";
        display = @"0";
        newDigit = true;
    } else if([button isEqualToString:@"+/-"]){
        display = [NSString stringWithFormat:@"%f", [display doubleValue] * (-1)];
        newDigit = true;
    } else if([button isEqualToString:@"1/x"]){
        if([display doubleValue] == 0){
            display = @"0";
        } else {
            display = [NSString stringWithFormat:@"%f", 1 / [display doubleValue]];
        }
        newDigit = true;
    } else if(newDigit && ![operation isEqualToString:@"="]){
        display = [NSString stringWithFormat:@"%f", currents];
    } else {
        newDigit = true;
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
            if ([display doubleValue] == 0){
                currents = 0;
            } else {
                currents /= [display doubleValue];
            }
        }
        else if ([operation isEqualToString:@"%"]){
            currents = ([display doubleValue] / 100) * currents;
            newDigit = true;
        }
        else {
            currents = [display doubleValue];
        }
        display = [NSString stringWithFormat:@"%f", currents];
        operation = button;
    }
    return display;
}

@end
