//
//  ViewController.h
//  Calculator
//
//  Created by Sergey Lavrov on 20.12.2018.
//  Copyright © 2018 +1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface ViewController : UIViewController {
    IBOutlet UILabel *display;
    CalculatorBrain *brain;
    double currents;
    bool newDigit;
    NSString *pendingOp;
}

- (IBAction)clearPressed:(UIButton *)sender;
- (IBAction)clearEntryPressed:(UIButton *)sender;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;

- (IBAction)negativePressed:(UIButton *)sender;
- (IBAction)inversePressed:(UIButton *)sender;
- (IBAction)decimalPressed:(UIButton *)sender;
- (IBAction)percentPressed:(UIButton *)sender;

@end
