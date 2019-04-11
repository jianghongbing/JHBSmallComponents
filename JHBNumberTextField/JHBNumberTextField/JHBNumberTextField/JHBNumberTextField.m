//
//  JHBNumberTextField.m
//  JHBNumberTextField
//
//  Created by pantosoft on 2019/4/9.
//  Copyright © 2019 jianghongbing. All rights reserved.
//

#import "JHBNumberTextField.h"
@interface JHBNumberTextField() <UITextFieldDelegate>
@end

@implementation JHBNumberTextField
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}


- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    if (self.numberOfDecimals > 0) {
        [super setKeyboardType:UIKeyboardTypeDecimalPad];
    }else {
        [super setKeyboardType:UIKeyboardTypeNumberPad];
    }
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
    [super setDelegate:self];
}

- (void)setNumberOfDecimals:(NSUInteger)numberOfDecimals {
    _numberOfDecimals = numberOfDecimals;
    [self setKeyboardType:0];
}

- (void)commonInit {
    [self removeObserver];
    [self addObserver];
    self.delegate = nil;
    self.delegate = self;
    [self setKeyboardType:UIKeyboardTypeNumberPad];
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textDidChange) name:UITextFieldTextDidChangeNotification object:self];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
}


- (void)_textDidChange {
    double value = [self.text doubleValue];
    if (self.maxInputValue > 0 && value > self.maxInputValue) {
        self.text = [self _formatMaxInputValue];
        value = self.maxInputValue;
    }
    if (self.valueDidChangeBlock) {
        self.valueDidChangeBlock(value, self.text);
    }

}

- (void)dealloc {
    [self removeObserver];
}

- (NSString *)_formatMaxInputValue {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingMode = NSNumberFormatterRoundDown;
    formatter.maximumFractionDigits = self.numberOfDecimals >= 6 ? 6 : self.numberOfDecimals;
    NSNumber *number = [NSNumber numberWithDouble:self.maxInputValue];
    return [formatter stringFromNumber:number];
}

#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL isBlank = [string isEqualToString:@""];
    if (isBlank) return YES;
    
    NSString *text = textField.text;
    double value = [text doubleValue];
    BOOL isDot = [string isEqualToString:@"."];
    BOOL allowsDecimal = self.numberOfDecimals > 0;
    
    if (!allowsDecimal) {
        BOOL isZero = [string isEqualToString:@"0"];
        if ((text == nil || text.length == 0) && isZero) return NO;
    }else {
        if ((text == nil || text.length == 0) && isDot) return NO;
        NSInteger dotLocation = [text rangeOfString:@"."].location;
        if (dotLocation != NSNotFound && isDot) return NO;
        if (dotLocation == NSNotFound && !isDot && [text hasPrefix:@"0"]) return NO;
        if (dotLocation == text.length - self.numberOfDecimals - 1 && !isBlank) return NO;
    }
    
    if (self.maxInputValue <= 0) return YES;
    if (value >= self.maxInputValue && !isBlank) return NO;
    return YES;
}
@end
