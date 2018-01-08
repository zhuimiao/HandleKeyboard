//
//  UIViewController+Keyboard.h
//  Design
//
//  Created by boitx on 07/01/2018.
//  Copyright © 2018 boitx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Keyboard)

@property (nonatomic,strong) NSArray *keyboardViews;

@property (nonatomic,assign) CGFloat keyboardHeight;


/**
 处理键盘遮挡
 */
- (void)handleKeyboard;

/**
 移除键盘遮挡相关通知
 dealloc 方法里调用
 */
- (void)removeHandleKeyboard;

@end
