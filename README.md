# ZBFPSLabel_Demo
简单的fps测试标签

## 调用方法
+ 导入头文件
在 Appdelegate.m中导入 ```#import "ZBFPSLabel.h"``` 
然后添加
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[ZBFPSLabel standardInstance] open];
    return YES;
}
```
即可。
