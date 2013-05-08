//
//  CalculatorBrain.m
//  Calculator
//
//  Created by ian on 12/9/12.
//  Copyright (c) 2012 ian. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic,strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

- (void) clearOperandStack
{
    [_operandStack removeAllObjects];
}

- (NSMutableArray *)operandStack
{
    if (_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    [self.operandStack addObject:([NSNumber numberWithDouble: operand])];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject]; //returns a pointer (not a copy)
    if (operandObject != nil) [self.operandStack removeLastObject];
    //the if-statement prevents an array-index out of bounds error
    return [operandObject doubleValue];
}

- (double) performOperation:(NSString *)operation
{
 
    double result = 0;
    //calculate result
    
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    
    } else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    
    } else if ([operation isEqualToString:@"-"]) {
        double subtractor = [self popOperand];
        if (subtractor) result = [self popOperand] - subtractor;
        
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    
    } else if ([operation isEqualToString:@"√"]) {
        result = sqrt([self popOperand]);
    
    } else if ([operation isEqualToString:@"π"]) {
        result = M_PI;
        
    } else if ([operation isEqualToString:@"SIN"]) {
        result = sin([self popOperand]);
        
    } else if ([operation isEqualToString:@"COS"]) {
        result = cos([self popOperand]);
    }
    

    [self pushOperand:result];
    
    return result;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"stack = %@", self.operandStack];
    //in the console type "po self"
}
@end
