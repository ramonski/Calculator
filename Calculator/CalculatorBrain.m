//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Bartl Ramon on 29.01.12.
//  Copyright (c) 2012 nexiles GmbH. All rights reserved.
//

#import "CalculatorBrain.h"
#import "math.h"


// private variables get declared here
@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

// Class implementation
@implementation CalculatorBrain

// synthesize programStack
@synthesize programStack = _programStack;

// getter of the program property
- (id)program {
    return [self.programStack copy];
}

// getter of the programStack property
- (NSMutableArray *)programStack {
    // we check that the stack is never uninitialized.
    // NOTE: MESSAGES TO NULLPOINTERS RETURN NONE
    if(_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

// ADD TO STACK
- (void)pushOperand:(double)operand {
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

// PERFORM OPERATION
- (double)performOperation:(NSString *)operation {
    [self.programStack addObject:operation];
    double result = [CalculatorBrain runProgram:self.program];
    return result;
}

+ (NSString *)descriptionOfProgram:(id)program {
    return @"Implement this in Assignment 2";
}

+ (double)runProgram:(id)program {
    NSMutableArray *stack;
    if([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

+ (double)popOperandOffStack:(NSMutableArray *)stack {
    double result = 0;

    // last object of stack
    id topOfStack = [stack lastObject];
    
    // remove last object of stack
    if (topOfStack) [stack removeLastObject];
 
    if([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    } else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack; 

        double a = [self popOperandOffStack:stack];
        double b = [self popOperandOffStack:stack];
        
        if([operation isEqualToString:@"+"]) {
            NSLog(@"Add: %g + %g", a, b);
            result = a + b;
        } else if ([operation isEqualToString:@"-"]) {
            NSLog(@"Subtract: %g - %g", b, a);
            result = b - a;
        } else if ([operation isEqualToString:@"*"]) {
            NSLog(@"Multiplicate: %g * %g", a, b);
            result = a * b;
        } else if ([operation isEqualToString:@"/"]) {
            NSLog(@"Divide: %g / %g", b, a);
            result = b / a;
        } else if ([operation isEqualToString:@"sin"]) {
            NSLog(@"sin(%g)", a);
            result = sin(a);
        } else if ([operation isEqualToString:@"cos"]) {
            NSLog(@"cos(%g)", a);
            result = cos(a);
        }
    }
    return result;
}

// returns content of stack as string
- (NSString *)showStack {
    return [self.programStack componentsJoinedByString:@", "];
}

// clear stack
- (void)clearStack {
    NSLog(@"CLEAR STACK! Items = %d", [self.programStack count]);
    [self.programStack removeAllObjects];
}

@end