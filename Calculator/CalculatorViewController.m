//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Bartl Ramon on 29.01.12.
//  Copyright (c) 2012 nexiles GmbH. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

// creates the setter and getter methods for us.
// 
// the name _display will be used inside the getter and setter.
// it is always a good idea to set the name. Otherwise the name will
// be the same as the property
@synthesize display = _display;


// we changed from the type id -- which basically can be any Object --
// to the more specific UIButton (because we know it's a UIButton).
// This shortens the code insight suggestions given by xcode.
- (IBAction)digitPressed:(UIButton *)sender {

    NSString *digit = [sender currentTitle];
    NSLog(@"digit pressed = %@", digit);
}



@end
