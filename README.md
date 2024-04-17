# HarmonyDemo

这个项目对鸿蒙移动端的开发进行了研究。包含以下内容：

- 基础认证教学示例的整合。
- 一些问题的研究。

### 一、基础认证教学示例的整合：

将官网上的教学示例进行了整合，修改了一些bug、优化了某些流程的处理（比如在EntryAbility中不使用await进行耗时操作）。

其中“WebView示例”与“新闻客户端示例”需要本地服务，代码中也有提供，分别位于HttpServerOfWeb和HttpServerOfNews文件夹内。


#### 鸿蒙平台建立组件间的依赖关系：

在鸿蒙平台，应用通过oh-package.json5配置文件来管理组件间的依赖关系，相关配置举例如下：

**（1）library组件配置：**

作为库组件的oh-package.json5配置如下：

```
{
  "name": "library",
  "version": "1.0.0",
  "description": "This is a library.",
  "main": "index.ets", // 注：此处指名library对外开放的接口文件。
  "author": "",
  "license": "Apache-2.0",
  "dependencies": {} // 组件间还可以进一步配置更深层的依赖关系。
}
```

根据配置文件中“main”字段的描述，对应index.ets内容如下：

```
export { SomePart } from './src/main/ets/components/librarys/...'
```

这样“SomePart”就向外公开出去了。

**（2）应用上层可执行组件：**

这种组件一般用作应用的入口，其oh-package.json5通常会引用其他组件：

```
{
  "name": "entry",
  "version": "1.0.0",
  "description": "Main application.",
  "main": "",
  "author": "",
  "license": "",
  "dependencies": {
    "@ohos/library": "file:../library", // 引入本地其他组件。
    "@ohos/lottie": "2.0.0" // 引入第三方库，直接写版本号。
  }
}
```

通过其“dependencies”确立了library组件与entry组件的依赖关系，接下来在entry组件中，就可以使用library公开的SomePart功能了。

### 二、一些问题的研究：

比如：

- @State、@Prop、@Link三者数据传递的规则。
- @Observed、@ObjectLink、@Provide、@Consume数据传递的规则。
- 状态持久化的用法。
- LazyForEach的用法。