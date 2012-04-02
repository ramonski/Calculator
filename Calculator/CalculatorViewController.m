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
//
// synthesize the display
@synthesize display = _display;
@synthesize stackdisplay = _stackdisplay;


// synthesize the calculator brain
@synthesize brain = _brain;

// we also need get setters and getters for our private properties
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;


// brain getter
- (CalculatorBrain *) brain {
    // initialize if nil
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

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
        NSLog(@"digit pressed the first time...");
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

// ENTER
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    // display contents of stack
    self.stackdisplay.text = [self.brain showStack];
}

// OPERATORS (+ - / * ...)
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];

    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
    self.stackdisplay.text = [self.brain showStack];
}

// C Pressed
- (IBAction)cPressed {
    [[self brain] clearStack];
    self.display.text = @"0";
    self.stackdisplay.text = [self.brain showStack];
}

// BACKSPACE PRESSED
- (IBAction)backspacePressed {
    
    if ([self.display.text length] > 1) {
        NSLog(@"Current text in display is %@", self.display.text);
        self.display.text = [self.display.text substringToIndex:[self.display.text length]-1];
    } else {
        NSLog(@"Current text == 0");
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringANumber = NO;
    }
}

@end