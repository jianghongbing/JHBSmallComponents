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
@property (nullable, nonatomic, copy) void(^valueDidChangeBlock)(double value,  NSString * _Nullable text); //输入发生变化的回调
@end

NS_ASSUME_NONNULL_END
