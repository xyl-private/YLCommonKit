# YLCommonKit
通用库



上传新内容到 Pod的操作步骤
1.  修改*.podspec文件中的版本号(s.version)
2.  将更新内容上传到 GitHub,然后给这个更新内容设置标签,标签的版本号要和*.podspec文件中的版本号一致.
3.  打开终端,来到项目的根目录下,远程检测代码仓库是否有问题
项目未引用第三方库时
```pod spec lint --allow-warnings --use-libraries```
当项目引用第三方库时（在后面加上--use-libraries，后面的pod trunk push也是一样）
```pod spec lint --allow-warnings --use-libraries```
当出现*.podspec passed validation.时，证明没有问题，可以继续提交。
4.  向远程代码索引库提交spec
```
pod trunk push --allow-warnings
pod trunk push --allow-warnings --use-libraries
```
出现以下内容时,证明已经上传成功了
```
Congrats

.... successfully published
是个日期
提交的地址
Tell your friends!

```
大概就是这些内容


5. 搜索自己创建的库
```
pod search 库名
```
如果刚刚上传完，你可能搜索不到，执行下面的操作
```
rm ~/Library/Caches/CocoaPods/search_index.json

pod search 库名
```

# 参考资料
https://www.jianshu.com/p/c5487c225a36

https://www.jianshu.com/p/7672943d8808
