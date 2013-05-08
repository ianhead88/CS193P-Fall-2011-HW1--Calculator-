//
//  CalculatorBrain.h
//  Calculator
//
//  Created by ian on 12/9/12.
//  Copyright (c) 2012 ian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;  //minus sign means instance method
- (double)performOperation:(NSString *) operation;
- (void)clearOperandStack;


@end
