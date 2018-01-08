//
//  UIViewController+Keyboard.m
//  Design
//
//  Created by boitx on 07/01/2018.
//  Copyright © 2018 boitx. All rights reserved.
//

#import "UIViewController+Keyboard.h"
#import <objc/runtime.h>

@implementation UIViewController (Keyboard)

- (void)setKeyboardViews:(NSArray *)keyboardViews
{
    objc_setAssociatedObject(self, "keyboardViews", keyboardViews, OBJC_ASSOCIATION_COPY);
}

- (NSArray *)keyboardViews
{
    return objc_getAssociatedObject(self, "keyboardViews");
}

- (CGFloat)keyboardHeight
{
    return [objc_getAssociatedObject(self, "keyboardHeight") floatValue];
}

- (void)setKeyboardHeight:(CGFloat)keyboardHeight
{
       objc_setAssociatedObject(self, "keyboardHeight", @(keyboardHeight), OBJC_ASSOCIATION_ASSIGN);
}

- (void)removeHandleKeyboard
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addKeyboardAnimationWithDuration:(CGFloat)duration
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
    UITextField *tf = [self.view.window performSelector:@selector(firstResponder)];
    if (!([tf isKindOfClass:[UITextField class]] || [tf isKindOfClass:[UITextView class]])) {
        return;
    }
    CGRect frame = tf.frame;
    
    if (tf.superview != self.view) {
        frame = [tf.superview convertRect:tf.frame toView:self.view];
    }
    
    NSInteger index = [self.keyboardViews indexOfObject:tf];
    UIView *nextView = [self.keyboardViews objectAtIndex:index + 1];
    
    // 完全显示下一个view 需要额外的高度
    CGFloat spaceH = nextView.frame.origin.y + nextView.frame.size.height
    - tf.frame.origin.y - tf.frame.size.height;
    
    // 距离底部的间距
    CGFloat bottomToSuper = self.view.frame.size.height - (frame.origin.y + frame.size.height);
    
#pragma clang diagnostic pop
    CGFloat margin  = bottomToSuper - spaceH - self.keyboardHeight;
    
    if (margin < 0) {
        [UIView animateWithDuration:duration animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = margin;
            self.view.frame = frame;
        }];
    }else{
        [UIView animateWithDuration:duration animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = 0;
            self.view.frame = frame;
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)handleKeyboard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
   }
}

- (void)configBeginEditing:(NSNotification *)notifi
{
    if (self.keyboardHeight != 0) {
        [self addKeyboardAnimationWithDuration:0.2];
    }
}

- (void)keyboardShow:(NSNotification *)notifi
{
    NSDictionary *userInfo = notifi.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (duration == 0) {
        duration =0.2;
    }
    
    CGRect keyBoardframe = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardHeight = keyBoardframe.size.height;
    
    [self addKeyboardAnimationWithDuration:duration];
}

- (void)keyboardHide:(NSNotification *)notifi
{
    NSDictionary *userInfo = notifi.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}

@end
