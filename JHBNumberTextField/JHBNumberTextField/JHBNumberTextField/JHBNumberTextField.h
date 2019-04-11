//
//  JHBNumberTextField.h
//  JHBNumberTextField
//
//  Created by pantosoft on 2019/4/9.
//  Copyright © 2019 jianghongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHBNumberTextField : UITextField
@property (nonatomic) double maxInputValue; //最大输入值,默认无限制
@property (nonatomic) NSUInteger numberOfDecimals; //可输入小数的位数,默认值为0,不开启输入小数
//@property (nonatomic) NSUInteger numberOfDecimalsWhenFormatMaxInputValue; //当允许输入小数并且当输入的值超过最大值的时候,格式化最大值保留的小数位的位数,默认为2,如果该属性设置的值大于numberOfDecimals的值,使用numberOfDecimals作为格式化最大值保留的小数位的位数.
@property (nullable, nonatomic, copy) void(^valueDidChangeBlock)(double value,  NSString * _Nullable text); //输入发生变化的回调
@end

NS_ASSUME_NONNULL_END
