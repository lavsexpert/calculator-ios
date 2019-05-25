//
//  ViewController.m
//  Calculator
//
//  Created by Sergey Lavrov on 20.12.2018.
//  Copyright © 2018 +1. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// При создании контролёра ...
- (void)viewDidLoad {
    [super viewDidLoad];
    // Создаётся мозг калькулятора
    if (!brain) brain = [[CalculatorBrain alloc] init];
}

- (void)dealloc{
    brain = nil;
}

//  При нажатии на цифру или десятичную точку ...
- (IBAction)digitPressed:(UIButton *)sender {
    displayLabel.text = [brain addDigit :sender.titleLabel.text :displayLabel.text];
}

// При нажатии на операцию, т.е. любую кнопку кроме цифр и десятичной точки ...
- (IBAction)operationPressed:(UIButton *)sender{
    displayLabel.text = [brain compute :sender.titleLabel.text :displayLabel.text];
}

@end
