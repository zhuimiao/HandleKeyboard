//
//  ViewController.m
//  HandleKeyboard
//
//  Created by boitx on 08/01/2018.
//  Copyright © 2018 boitx. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Keyboard.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.keyboardViews = @[self.phoneTF,self.pwdTF,self.codeTF,self.loginBtn];
    [self handleKeyboard];
}

- (void)dealloc
{
    [self removeHandleKeyboard];
}


@end
