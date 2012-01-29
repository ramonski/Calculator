//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Bartl Ramon on 29.01.12.
//  Copyright (c) 2012 nexiles GmbH. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"


// place for us to put private instance variables
@interface CalculatorViewController() 
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

// creates the setter and getter methods for us.
// 
// the name _display will be used inside the getter and setter.
// it is always a good idea to set the name. Otherwise the name will
// be the same as the property
@synthesize display = _display;

@synthesize brain = _brain;

- (CalculatorBrain *) brain {
    // initialize if nil
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

// we also need get setters and getters for our private properties
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;

// we changed from the type id -- which basically can be any Object --
// to the more specific UIButton (because we know it's a UIButton).
// This shortens the code insight suggestions given by xcode.
- (IBAction)digitPressed:(UIButton *)sender {

    NSString *digit = sender.currentTitle;
    NSLog(@"digit pressed = %@", digit);
    
    // we only append the pressed digit if we typed already a number
    if (self.userIsInTheMiddleOfEnteringANumber) {
        // append the pressed digit to the display
        self.display.text = [self.display.text stringByAppendingFormat:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}


@end