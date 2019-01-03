//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Sergey Lavrov on 20.12.2018.
//  Copyright © 2018 +1. All rights reserved.
//

@interface CalculatorBrain: NSObject {
    NSString *operation;
    NSString *prevOperation;
    double first;
    double second;
    double result;
}
- (double)calculate :(NSString *)operation :(double)first :(double)second;
- (void)clear;

@property NSString *operation;
@property NSString *prevOperation;
@property double first;
@property double second;
@property double result;

@end
