# HandleKeyboard
> 三行代码处理键盘遮挡问题

## 处理思路
当前输入框不能被遮挡，底下的输入框也不能遮挡。

## 效果

![Jan-08-2018 14-59-04](http://omup0qp0e.bkt.clouddn.com/Jan-08-2018 14-59-04.gif)


这里有三个输入框: 手机号输入框，密码输入框，验证码输入框，
一个登陆按钮

手机号输入框开始输入时，密码输入框不能被遮挡。
密码输入框开始输入时，  验证码输入框不能被遮挡。
验证码输入框开始输入时，登录按钮不能被遮挡。

## 代码

设置需要键盘遮挡处理的控件
```objc
self.keyboardViews = @[self.phoneTF,self.pwdTF,self.codeTF,self.loginBtn];
```

开始处理
```objc
[self handleKeyboard];
```

移除相关通知 dealloc 中调用
```objc
[self removeHandleKeyboard];
```


