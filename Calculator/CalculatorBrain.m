//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Bartl Ramon on 29.01.12.
//  Copyright (c) 2012 nexiles GmbH. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end


@implementation CalculatorBrain

@synthesize operandStack = _operandStack;


// setter for our stack
- (NSMutableArray *)operandStack {
    // we check that the stack is never uninitialized.
    // MESSAGES TO NULLPOINTERS RETURN NONE
    if(_operandStack == nil) _operandStack = [[NSMutableArray alloc] init];
    return _operandStack;
}

- (void)setOperandStack:(NSMutableArray *)operandStack {
    _operandStack = operandStack;
}

- (void)pushOperand:(double)operand {
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (void)clearStack {
    NSLog(@"CLEAR STACK! Items = %d", [self.operandStack count]);
    [self.operandStack removeAllObjects];
    NSLog(@"DONE");
}

// the logic is implemented here
- (double)performOperation:(NSString *)operation {
    double result = 0;

    if([operation isEqualToString:@"+"]) {
        // plus
        result = self.popOperand + self.popOperand;
    } else if ([operation isEqualToString:@"-"]) {
        // minus
        result = self.popOperand - self.popOperand;
    } else if ([operation isEqualToString:@"*"]) {
        // multiplicate
        result = self.popOperand * self.popOperand;
    } else if ([operation isEqualToString:@"/"]) {
        // divide
        result = self.popOperand / self.popOperand;
    }
    // put result back to the stack
    
    [self pushOperand:result];
    
    // return the result
    return result;
}

@end
