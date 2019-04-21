//
//  JHBCopyableLabel.m
//  JHBCopyableLabel
//
//  Created by jianghongbing on 2019/4/21.
//  Copyright © 2019 jianghongbing. All rights reserved.
//

#import "JHBCopyableLabel.h"

@interface JHBCopyableLabel()
@property (nullable, nonatomic, strong) UILongPressGestureRecognizer *gestureRecognizer;
@property (nullable, nonatomic, strong) UIColor *originalBackgroundColor;
@end


@implementation JHBCopyableLabel
#pragma mark initializer
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

- (void)commonInit {
    self.copyabled = YES;
}



#pragma mark setter
- (void)setCopyabled:(BOOL)copyabled {
    _copyabled = copyabled;
    self.userInteractionEnabled = copyabled;
    if (copyabled) {
        [self addLongPressGestureRecognizer];
    }else {
        [self removeLongPressGestureRecognizer];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    if (backgroundColor == self.highlightedBackgroundColor || backgroundColor == self.originalBackgroundColor) return;
    self.originalBackgroundColor = backgroundColor;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self updateLabelBackgroundColor];
}

- (void)updateLabelBackgroundColor {
    if (self.isHighlighted && self.highlightedBackgroundColor) {
        self.backgroundColor = self.highlightedBackgroundColor;
    }else {
        self.backgroundColor = self.originalBackgroundColor;
    }
}
#pragma mark add or remove gesture recognizer
- (void)addLongPressGestureRecognizer {
    self.gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestureRecognizer:)];
    [self addGestureRecognizer:self.gestureRecognizer];
    [self registerNotifications];
}

- (void)removeLongPressGestureRecognizer {
    if (self.gestureRecognizer) {
        [self removeGestureRecognizer:self.gestureRecognizer];
        [self unregisterNotifications];
        self.gestureRecognizer = nil;
    }
}

- (void)dealloc {
    [self unregisterNotifications];
}


#pragma mark UIMenuController notifications
- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillHide:) name:UIMenuControllerWillHideMenuNotification object:nil];
}

- (void)unregisterNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
}

- (void)menuControllerWillHide:(NSNotification *)notification {
    [self setHighlighted:NO];
}

#pragma mark override UIResponder method
- (BOOL)canBecomeFirstResponder {
    return self.isCopyabled;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return self.isFirstResponder && self.isCopyabled && action == @selector(menuItemClicked:);
}

#pragma mark long press gesture recognizer target action
- (void)handleLongPressGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if (!self.isCopyabled) return;
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self showMenuControllerIfNeed];
        [self setHighlighted:YES];
    }
}

- (void)showMenuControllerIfNeed {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController.isMenuVisible) return;
    [self becomeFirstResponder];

    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:self.menuItemTitle ?: @"复制" action:@selector(menuItemClicked:)];
    [menuController setTargetRect:self.frame inView:self.superview];
    menuController.menuItems = @[item];
    [menuController setMenuVisible:YES animated:YES];
}

- (void)menuItemClicked:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.text;
}
@end
