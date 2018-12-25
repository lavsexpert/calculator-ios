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
}
- (void)calculateTwo;
- (double)calculate:(NSString *)newOperation:(double)newOperand;
- (void)updateOperand:(double)newOperand;
- (NSString *)more;
@end
