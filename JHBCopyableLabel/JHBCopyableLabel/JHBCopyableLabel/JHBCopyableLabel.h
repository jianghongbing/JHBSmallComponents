//
//  JHBCopyableLabel.h
//  JHBCopyableLabel
//
//  Created by jianghongbing on 2019/4/21.
//  Copyright © 2019 jianghongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHBCopyableLabel : UILabel
@property (nonatomic, getter=isCopyabled) BOOL copyabled;
@property (nullable, nonatomic, copy) NSString *menuItemTitle;
@property (nullable, nonatomic, strong) UIColor *highlightedBackgroundColor UI_APPEARANCE_SELECTOR;
@end

NS_ASSUME_NONNULL_END
