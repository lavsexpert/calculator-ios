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
    IBOutlet UILabel *operation;
    IBOutlet UILabel *more;
    CalculatorBrain *brain;
    BOOL appendingDigit;
}

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)unaryPressed:(UIButton *)sender;
- (IBAction)binaryPressed:(UIButton *)sender;
- (IBAction)managePressed:(UIButton *)sender;
- (void)showMore;
@end
