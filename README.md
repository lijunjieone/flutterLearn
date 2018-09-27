# 目标
  集成flutter程序到已有的ios和android程序中

# 结构
  > flutter 工程
  >> host目录
  >>> android宿主程序
  >>> ios宿主程序

# 参考
  - [官网文档](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps)

# android

## 集成步骤
  - 创建flutter工程
  - 创建host目录
  - 在host内创建android工程
  - 复制工程下的bin目录到flutter工程下
  - 执行bin/build_android.sh
  - 在android/app/libs下找到aar文件
  - 根据集成aar的方式集成目录
     - 修改build.gradle的repositories 支持libs目录
     - 依赖中增加aar
     - 明确ndk架构,避免架构不一致导致的运行问题


### build_android.sh的处理步骤
  - 修改flutter的android编译文件,支持打包aar
  - 编译aar文件
  - 复制aar到android目录下的libs目录
  - 复制icudtl.dat到/assets/flutter_shared

### 修改aar的集成

```

  apply plugin: 'com.android.application'

  android {
      compileSdkVersion 27
      defaultConfig {

          //确认编译架构,编译架构不一致导致的运行问题
          ndk {
              // 设置支持的 SO 库构架，一般而言，取你所有的库支持的构架的`交集`。
              abiFilters 'armeabi-v7a'// 'armeabi-v7a', 'arm64-v8a', 'x86', 'x86_64', 'mips', 'mips64'
          }
      }

      //增加aar获取仓库
      repositories {
          flatDir {
              dirs 'libs'
          }
      }

  }

  dependencies {
      //增加aar依赖
      implementation(name: 'flutter_sdk', ext: 'aar')

  }



```


```

 Intent i=new Intent();
 i.setClassName(getBaseContext(),"com.mx.flutterapp.MainActivity");
 getBaseContext().startActivity(i);


```


  通过以上完成了一个基本的功能复用.后面可以完成功能的更复杂的功能复用.

# iOS
  待定