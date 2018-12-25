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
@synthesize operation;
@synthesize first;
@synthesize second;
@synthesize result;

- (double)calculate:(NSString *)operation :(double)first :(double)second{
    
    self.operation = operation;
    self.first = first;
    self.second = second;
    
    if ([operation isEqual:@"C"]||[operation isEqual:@""]) {
        self.result = 0;
    } else if ([operation isEqual:@"1/x"]){
        if (first) {
            self.result = 1 / first;
        } else {
            self.result = 0;
        }
    } else if ([operation isEqual:@"+/-"]){
        if (first){
            self.result = - first;
        } else {
            self.result = 0;
        }
    } else if ([operation isEqual:@"√"]){
        if (first < 0) {
            self.first = - first;
        }
        self.result = sqrt(self.first);
    } else {
        self.result = 0;
    }
    return self.result;
}

@end
