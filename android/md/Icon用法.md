# Icon

##### MaterialDesign的图标库

[https://material.io/tools/icons/?style=baseline](https://links.jianshu.com/go?to=https%3A%2F%2Fmaterial.io%2Ftools%2Ficons%2F%3Fstyle%3Dbaseline)

##### 阿里巴巴的图标库

[https://www.iconfont.cn/](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.iconfont.cn%2F)

##### IconData   创建一个具体的字体图标

```cpp
const IconData(
    this.codePoint, //该图标在字体中的编码  
    {
      this.fontFamily,//所属字体
      this.fontPackage,//字体所属的包
      this.matchTextDirection = false,//是否启用镜像，向左还是向右
    }
);
```

##### Icons  定义了一系列IconData的枚举值，包含了material design的所有内置图标

```csharp
class Icons {
  Icons._();
  static const IconData threesixty = IconData(0xe577, fontFamily: 'MaterialIcons');
  static const IconData threed_rotation = IconData(0xe84d, fontFamily: 'MaterialIcons');
  ......
}
```

##### Icon  字体图标

```cpp
const Icon(
this.icon, //IconData类型，flutter内置了一系列的枚举值，使用Icons.xxx，或创建IconData
{
    Key key,
    this.size,//图标显示的大小，固定是正方形，默认24,
    this.color,//图标颜色，如果不设置，默认是黑色图标
    this.semanticLabel,//?帮助盲人或者视力有障碍的用户提供语言辅助描述,还未用到过
    this.textDirection,//图标显示的方向，是向左还是向右，IconData的matchTextDirection为true时有效，matchTextDirection默认值为false，因此只设置textDirection无效
  }
)
```

示例：





![img](https:////upload-images.jianshu.io/upload_images/10820743-8dea2c526f286dfa.png?imageMogr2/auto-orient/strip|imageView2/2/w/27)

image.png

```cpp
Icon(Icons.accessible,),//默认是黑色
Icon(Icons.accessible,color: Colors.green,),//设置图标为绿色
Icon(Icons.accessible,color: Colors.red,),//设置图标为红色
```



![img](https:////upload-images.jianshu.io/upload_images/10820743-49518b6d4b4523ea.png?imageMogr2/auto-orient/strip|imageView2/2/w/48)

image.png

```cpp
Icon(Icons.accessible,color: Colors.red,size: 10,),//设置图标大小
Icon(Icons.accessible,color: Colors.red,),//size默认24
Icon(Icons.accessible,color: Colors.red,size: 30,),//设置图标大小
```



![img](https:////upload-images.jianshu.io/upload_images/10820743-4eb5eca7e4019d27.png?imageMogr2/auto-orient/strip|imageView2/2/w/33)

image.png

```cpp
Icon(IconData(0xe914, fontFamily: 'MaterialIcons',matchTextDirection: true),color: Colors.red,size: 30,textDirection: TextDirection.ltr,),
Icon(IconData(0xe914, fontFamily: 'MaterialIcons',matchTextDirection: true),color: Colors.red,size: 30,textDirection: TextDirection.rtl,),
```

## ImageIcon

将png的图片 使用图标形式显示，可以更改其显示颜色

```cpp
const ImageIcon(
this.image, //ImageProvider类型  用于加载具体的图片
{
    Key key,
    this.size,//大小
    this.color,//想要显示的颜色
    this.semanticLabel,
  }
)
```

ImageProvider是一个抽象类，其子类包括

- AssetImage   资源图片

- FileImage  文件图片

- NetworkImage    网络图片

- MemoryImage   内存图片
  如：

  

  ![img](https:////upload-images.jianshu.io/upload_images/10820743-369a3076d7c90c96.png?imageMogr2/auto-orient/strip|imageView2/2/w/31)

  image.png

```cpp
ImageIcon(AssetImage("images/img06.png"),size: 40,),//默认显示原色
ImageIcon(AssetImage("images/img06.png"),color: Colors.red,size: 40,),//红色
ImageIcon(AssetImage("images/img06.png"),color: Colors.green,size: 40,),//绿色
```

##### IconButton   图标按钮

```cpp
const IconButton({
    Key key,
    this.iconSize = 24.0,
    this.padding = const EdgeInsets.all(8.0),
    this.alignment = Alignment.center,
    @required this.icon,
    this.color,
    this.highlightColor,//长按后不松手时显示的颜色
    this.splashColor,//点击一下时闪烁的颜色
    this.disabledColor,//不可用时的颜色
    @required this.onPressed,//点击后触发的方法
    this.tooltip//长按后的提示语
  })
```

示例：





![img](https:////upload-images.jianshu.io/upload_images/10820743-cf5c8832be62cbea.png?imageMogr2/auto-orient/strip|imageView2/2/w/41)

image.png



点击时 闪烁的颜色blue（忽略内部的黑色圆圈，截屏问题）





![img](https:////upload-images.jianshu.io/upload_images/10820743-abfb7c2280b2f347.png?imageMogr2/auto-orient/strip|imageView2/2/w/56)

image.png


长按后的颜色  绿色



![img](https:////upload-images.jianshu.io/upload_images/10820743-3818a3831e8032e8.png?imageMogr2/auto-orient/strip|imageView2/2/w/56)

image.png



长按提示语





![img](https:////upload-images.jianshu.io/upload_images/10820743-34bc272dd3354690.png?imageMogr2/auto-orient/strip|imageView2/2/w/70)

image.png

```cpp
IconButton(
     icon: Icon(
         Icons.accessible,
         color: Colors.green,
     ),
     onPressed: () {},//点击触发的方法
     highlightColor: Colors.green,//长按后不松手时显示的颜色
     splashColor: Colors.blue,//点击一下时闪烁的颜色
     disabledColor: Colors.grey,//不可用时的颜色
     tooltip: "sss",//长按后的提示语
),
```

