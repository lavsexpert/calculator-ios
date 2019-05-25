//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Sergey Lavrov on 20.12.2018.
//  Copyright © 2018 +1. All rights reserved.
//

@interface CalculatorBrain: NSObject {
    bool newDigit;
    double currents;
    NSString *operation;
}

- (NSString*)addDigit :(NSString *)button :(NSString *)display;
- (NSString*)compute :(NSString *)button :(NSString *)display;

@property bool newDigit;
@property double currents;
@property NSString *operation;

@end
