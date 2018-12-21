//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Sergey Lavrov on 20.12.2018.
//  Copyright © 2018 +1. All rights reserved.
//

@interface CalculatorBrain: NSObject {
    double operand;
    NSString *waitingOperation;
    double waitingOperand;
}
@property double operand;
- (void)performWaitingOperation;
- (double)performOperation:(NSString *)operation;
@end
