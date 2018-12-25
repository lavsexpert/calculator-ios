//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Sergey Lavrov on 20.12.2018.
//  Copyright © 2018 +1. All rights reserved.
//

@interface CalculatorBrain: NSObject {
    BOOL binary;
    NSString *operation;
    double first;
    double second;
    double display;
    double saved;
}
- (void)setUnary:(NSString *)newOperation:(double)newOperand;
- (double)calculate:(NSString *)newOperation:(double)newOperand;
- (void)updateOperand:(double)newOperand;
- (void)updateOperation:(NSString *)newOperation:(double)newOperand;
- (NSString *)more;
@end
