# CI 文档
CI 是什么？它意为*持续集成*。用通俗易懂的话来讲，就是可以调用一台机器，使其编译代码或干更多的事。

Darock 使用的 CI 来自 GitHub Actions 和 Xcode Cloud。Xcode Cloud 的调用是自动的，并且您没有权限手动调用它，因此本文档主要介绍 GitHub Actions。
## 调用
您可以通过在 Pull Request 下方发送评论的方式来调用 CI。
### 可编译性检查
我们要求所有向**main**分支合并的 Pull Request 必须在合并之前完成可编译性检查。此操作由 CI 完成。

发送`!Run check`以执行可编译性检查工作流。
### 导出 IPA
您可以通过 CI 导出一个经过签名的 IPA 以便测试，但不能用于分发。

发送`!Export IPA`以运行导出 IPA 工作流。
### 上传到 TestFlight
您可以通过 CI 将某分支的代码编译并上传到 TestFlight 以便测试，不得用于分发。

**此工作流会导致整个项目的构建版本号+1**

发送`!Deploy TF`以运行上传工作流
## 查看状态
一旦工作流程开始运行，你便可以在 Pull Request 的下方或 Actions 页找到对应的运行状态。

在 Action 的 **Summary** 页中，如果此操作流程包含附件(例如`导出 IPA`操作)，您可以在下方获取其附件。
