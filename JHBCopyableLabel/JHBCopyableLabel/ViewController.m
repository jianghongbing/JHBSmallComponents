//
//  ViewController.m
//  JHBCopyableLabel
//
//  Created by jianghongbing on 2019/4/21.
//  Copyright © 2019 jianghongbing. All rights reserved.
//

#import "ViewController.h"
#import "JHBCopyableLabel/JHBCopyableLabel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = CGRectMake(20, 100, 200, 40);
    JHBCopyableLabel *label = [[JHBCopyableLabel alloc] initWithFrame:frame];
    label.text = @"Hello,World";
    [self.view addSubview:label];
    [label sizeToFit];

    frame.origin.y += 30;
    label = [[JHBCopyableLabel alloc] initWithFrame:frame];
    label.text = @"Hello,World";
    label.textColor = [UIColor redColor];
    label.highlightedTextColor = [UIColor greenColor];
    label.backgroundColor = [UIColor blackColor];
    label.highlightedBackgroundColor = [UIColor orangeColor];
    [self.view addSubview:label];
    [label sizeToFit];

    frame.origin.y += 30;
    label = [[JHBCopyableLabel alloc] initWithFrame:frame];
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:@"Hello,world" attributes:nil];
    [attributeText addAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor], NSFontAttributeName:[UIFont systemFontOfSize:20]} range:NSMakeRange(0, 5)];
    label.attributedText = attributeText.copy;
    label.highlightedTextColor = [UIColor greenColor];
    label.backgroundColor = [UIColor purpleColor];
    label.highlightedBackgroundColor = [UIColor orangeColor];
    label.menuItemTitle = @"拷贝";
    [self.view addSubview:label];
    [label sizeToFit];

    frame.origin.y += 100;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, frame.origin.y, 200, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"请粘贴复制的文本";
    [self.view addSubview:textField];
}


@end
