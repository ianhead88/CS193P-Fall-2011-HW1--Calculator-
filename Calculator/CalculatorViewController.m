//
//  CalculatorViewController.m
//  Calculator
//
//  Created by ian on 12/7/12.
//  Copyright (c) 2012 ian. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL UserIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize UserIsInTheMiddleOfEnteringANumber = _UserIsInTheMiddleOfEnteringANumber;
@synthesize display = _display;
@synthesize brain = _brain;
@synthesize log_display = _log_display;

- (CalculatorBrain *) brain
{

    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    if (self.UserIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
       self.display.text = digit;
       self.UserIsInTheMiddleOfEnteringANumber = YES;
            }
}

- (IBAction)dotPressed:(UIButton *)sender
{
    self.UserIsInTheMiddleOfEnteringANumber = YES;
    NSString *dot = [sender currentTitle];
    NSString *currentlabeltext = self.display.text;
    NSRange rangeOfDot = [currentlabeltext rangeOfString:dot];
    if (rangeOfDot.location == NSNotFound) 
        self.display.text = [self.display.text stringByAppendingString:dot];    
}

- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.UserIsInTheMiddleOfEnteringANumber = NO;
    
    //this writes out the bottom display
    self.log_display.text = [self.log_display.text stringByAppendingString:@" "];
    self.log_display.text = [self.log_display.text stringByAppendingString: self.display.text];
    
}

- (IBAction)operationPressed:(UIButton *)sender
{   
    if (self.UserIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    
    //this writes out the bottom display
    self.log_display.text = [self.log_display.text stringByAppendingString:@" "];
    self.log_display.text = [self.log_display.text stringByAppendingString:operation];
    //self.log_display.text = [self.log_display.text stringByAppendingString:@" "];
    //self.log_display.text = [self.log_display.text stringByAppendingString: self.display.text];
    
}
- (IBAction)clear:(UIButton *)sender {

    self.display.text = @"0";
    self.log_display.text = @"";
    [self.brain clearOperandStack];
}

@end
