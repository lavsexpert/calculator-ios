//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Sergey Lavrov on 20.12.2018.
//  Copyright © 2018 +1. All rights reserved.
//

@interface CalculatorBrain: NSObject {
    double first;
    NSString *operation;
    double second;
    double result;
    NSString *more;
    double savedNumber;
    NSString *prevOperation;
}

- (void)thinking :(NSString *)button :(double)display;
- (double)calculate :(double)first :(NSString *)operation :(double)second;
- (void)more:(BOOL)unary;

@property NSString *operation;
@property double first;
@property double second;
@property double result;
@property NSString *more;
@property double savedNumber;
@property NSString *prevOperation;

@end
