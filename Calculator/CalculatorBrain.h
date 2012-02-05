//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Bartl Ramon on 29.01.12.
//  Copyright (c) 2012 nexiles GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

// declaration
- (void) pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clearStack;
- (NSString *)showStack;
@end
