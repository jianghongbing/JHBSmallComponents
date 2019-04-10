//
//  ViewController.m
//  JHBNumberTextField
//
//  Created by pantosoft on 2019/4/9.
//  Copyright © 2019 jianghongbing. All rights reserved.
//

#import "ViewController.h"
#import "JHBNumberTextField/JHBNumberTextField.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet JHBNumberTextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.maxInputValue = 100;
    self.textField.numberOfDecimals = 2;
    CGFloat margin = 10;
    CGFloat x = margin;
    CGFloat y = 60;
    CGFloat width = CGRectGetWidth(self.view.bounds) - x * 2;
    CGFloat height = 30;
    CGRect frame = CGRectMake(x, y, width, height);
    JHBNumberTextField *textField = [self textFieldWithFrame:frame maxInputValue:0 numberOfDecimals:0 placeholder:@"不能输入小数,大小无限制"];
    
    frame.origin.y = CGRectGetMaxY(frame) + margin;
    textField = [self textFieldWithFrame:frame maxInputValue:100  numberOfDecimals:0 placeholder:@"不能输入小数,最大数100"];

    frame.origin.y = CGRectGetMaxY(frame) + margin;
    textField = [self textFieldWithFrame:frame maxInputValue:0  numberOfDecimals:3 placeholder:@"保留3位小数,最大数无限制"];
    
    frame.origin.y = CGRectGetMaxY(frame) + margin;
    textField = [self textFieldWithFrame:frame maxInputValue:100  numberOfDecimals:2 placeholder:@"保留2位小数,最大数100"];
    
    frame.origin.y = CGRectGetMaxY(frame) + margin;
    textField = [self textFieldWithFrame:frame maxInputValue:0  numberOfDecimals:NSIntegerMax placeholder:@"小数位无限制,最大数无限制"];
    
    frame.origin.y = CGRectGetMaxY(frame) + margin;
    textField = [self textFieldWithFrame:frame maxInputValue:100  numberOfDecimals:NSIntegerMax placeholder:@"小数位无限制,最大数100"];
    frame.origin.y = CGRectGetMaxY(frame) + margin;
    textField = [self textFieldWithFrame:frame maxInputValue:99.99  numberOfDecimals:NSIntegerMax placeholder:@"小数位无限制,最大数99.99"];
    frame.origin.y = CGRectGetMaxY(frame) + margin;
    textField = [self textFieldWithFrame:frame maxInputValue:99.95  numberOfDecimals:3 placeholder:@"保留3位小数,最大数99.95"];
    [self addKeyboardObserver];
}

- (JHBNumberTextField *)textFieldWithFrame: (CGRect)frame
                             maxInputValue:(double)maxInputValue
                          numberOfDecimals:(NSInteger)numberOfDecimals
                               placeholder:(NSString *)placeholder {
    JHBNumberTextField *textField = [[JHBNumberTextField alloc] initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = placeholder;
    textField.maxInputValue = maxInputValue;
    textField.numberOfDecimals = numberOfDecimals;
    textField.valueDidChangeBlock = ^(double value, double maxValue, NSString *text) {
        NSLog(@"value:%f, maxValue:%f, text:%@", value, maxValue, text);
    };
    [self.view addSubview:textField];
    return textField;
}

- (void)addKeyboardObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)removeKeyboardObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)_keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat beginY = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].origin.y;
    CGFloat endY = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat translationY = endY - beginY;
    [UIView animateWithDuration:duration animations:^{
        self.textField.transform = CGAffineTransformTranslate(self.textField.transform, 0, translationY);
    }];
}


- (void)dealloc {
    [self removeKeyboardObserver];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
