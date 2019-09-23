# Flutter组件学习—— Image


### 序言

上一节中，我们讲了 `Flutter` 中 `Text` 组件的一些用法以及 `API`，本节我们继续学习 `Flutter` 中的 `Image` 组件，同样先上图：



![img](https:////upload-images.jianshu.io/upload_images/490111-645cd6dd82b34a4d.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/342)

image

### Image组件的构造方法

在 `Android` 中，我们都知道，图片的显示方式有很多，资源图片、网络图片、文件图片等等，在 `Flutter` 中也有多种方式，用来加载不同形式的图片：

-  **Image：**通过ImageProvider来加载图片
-  **Image.asset：**用来加载本地资源图片
-  **Image.file：**用来加载本地（File文件）图片
-  **Image.network：**用来加载网络图片
-  **Image.memory：**用来加载Uint8List资源（byte数组）图片

##### 1、Image

`Image` 的一个参数是 `ImageProvider`，基本上所有形式的图片加载都是依赖它，这个类里面就是实现图片加载的原理。用法如下：

```csharp
new Image(image: new AssetImage('images/logo.png'));

new Image(image: new NetworkImage('http://n.sinaimg.cn/sports/2_img/upload/cf0d0fdd/107/w1024h683/20181128/pKtl-hphsupx4744393.jpg'))
```

##### 2、Image.asset

加载一个本地资源图片，和 `Android` 一样，有多种分辨率的图片可供选择，但是沿袭的是 `iOS` 的图片风格，分为 `1x`，`2x`，`3x`，具体做法是在项目的根目录下创建两个文件夹，如下图所示：



![img](https:////upload-images.jianshu.io/upload_images/490111-01df591cff524381.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/760)

image

然后需要在 `pubspec.yaml` 文件中声明一下：

```bash
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true
  assets:
    - images/logo.png
    - images/2.0x/logo.png
    - images/3.0x/logo.png
```

用法如下：

```csharp
new Image.asset('images/logo.png')
```

##### 3、Image.file

加载一个本地 `File` 图片，比如相册中的图片，用法如下

```csharp
new Image.file(new File('/storage/xxx/xxx/test.jpg'))
```

##### 4、Image.network

加载一个网络图片，用法如下：

```csharp
new Image.network('http://n.sinaimg.cn/sports/2_img/upload/cf0d0fdd/107/w1024h683/20181128/pKtl-hphsupx4744393.jpg')
```

有的时候我们需要像Android那样使用一个占位图或者图片加载出错时显示某张特定的图片，这时候需要用到 `FadeInImage` 这个组件：

```csharp
new FadeInImage.assetNetwork(
  placeholder: 'images/logo.png',
  image: imageUrl,
  width: 120,
  fit: BoxFit.fitWidth,
)

new FadeInImage.memoryNetwork(
  placeholder: kTransparentImage,
  image: imageUrl,
  width: 120,
  fit: BoxFit.fitWidth,
)
```

第一种方法是加载一个本地的占位图，第二种是加载一个透明的占位图，但是需要注意的是，这个组件是不可以设置加载出错显示的图片的；这里有另一种方法可以使用第三方 `package` 的 `CachedNetworkImage` 组件：

```cpp
new CachedNetworkImage(
  width: 120,
  fit: BoxFit.fitWidth,
  placeholder: new CircularProgressIndicator(),
  imageUrl: imageUrl,
  errorWidget: new Icon(Icons.error),
)
```

`CachedNetworkImage` 组件中的占位图是一个 `Widget`，这样的话就可以自定义了，你想使用什么样的组件进行占位都行，同样加载出错的占位图也是一个组件，也可以自己定义；该组件也是通过缓存来加载图片的。

##### 5、Image.memory

用来将一个 `byte` 数组加载成图片，用法如下：

```cpp
new Image.memory(bytes)
```

### Text组件的API

| API名称                |                             功能                             |
| ---------------------- | :----------------------------------------------------------: |
|                        |                                                              |
| width & height         |         用来指定显示图片区域的宽高（并非图片的宽高）         |
| fit                    |           设置图片填充，类似于Android中的ScaleType           |
| color & colorBlendMode | 这两个属性需要配合使用，就是颜色和图片混合，就类似于Android中的Xfermode |
| alignment              |                    用来控制图片摆放的位置                    |
| repeat                 | 用来设置图片重复显示（repeat-x水平重复，repeat-y垂直重复，repeat两个方向都重复，no-repeat默认情况不重复） |
| centerSlice            | 设置图片内部拉伸，相当于在图片内部设置了一个.9图，但是需要注意的是，要在显示图片的大小大于原图的情况下才可以使用这个属性，要不然会报错 |
| matchTextDirection     |              这个需要配合Directionality进行使用              |
| gaplessPlayback        | 当图片发生改变之后，重新加载图片过程中的样式（1、原图片保留） |

`fit` 属性中有很多值可以设置：

| 属性名称         |                         样式                         |
| ---------------- | :--------------------------------------------------: |
| BoxFit.contain   |           全图居中显示但不充满，显示原比例           |
| BoxFit.cover     |        图片可能拉伸，也可能裁剪，但是充满容器        |
| BoxFit.fill      |           全图显示且填充满，图片可能会拉伸           |
| BoxFit.fitHeight |           图片可能拉伸，可能裁剪，高度充满           |
| BoxFit.fitWidth  |           图片可能拉伸，可能裁剪，宽度充满           |
| BoxFit.scaleDown | 效果和contain差不多， 但是只能缩小图片，不能放大图片 |

`colorBlendMode` 属性中有很多值可以设置，由于可选值太多，这里就不一一介绍了，有兴趣的可以去[官网colorBlendMode属性介绍](https://docs.flutter.io/flutter/dart-ui/BlendMode-class.html)看看

### 实现圆角/圆形图片

##### 1、圆角

很多时候我们需要给图片设置圆角，那么在flutter中是怎么实现的呢？有很多种方法可以实现，下面我举两个例子：

```css
使用裁剪来实现图片圆角：

new ClipRRect(
  child: Image.network(
    imageUrl,
    scale: 8.5,
    fit: BoxFit.cover,
  ),
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ),
)

使用边框来实现图片圆角：

new Container(
  width: 120,
  height: 60,
  decoration: BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(10.0),
    image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover),
  ),
)
```

需要注意的是，使用边框实现的时候要注意设置 `fit` 属性，不然效果也是有问题的，当然了你还可以使用 `Material` 组件来实现，这个大家可以自己去尝试。

##### 2、圆形

圆形图片用得最多的应该是头像之类的，这种同样有多种方式可以实现，下面我也举两个例子：

```css
使用裁剪实现圆形图片：

new ClipOval(
    child: Image.network(
    imageUrl,
    scale: 8.5,
  ),
)

使用CircleAvatar来实现圆形图片：

new CircleAvatar(
  backgroundImage: NetworkImage(imageUrl),
  radius: 50.0,
)
```

当然了，你还可以使用边框 `BoxDecoration` 来实现，效果也是一样的。

下面来看一下详细的代码实现：

```php
class _ImageViewWidget extends State<ImageViewWidget> {
  var imageUrl =
      "http://n.sinaimg.cn/sports/2_img/upload/cf0d0fdd/107/w1024h683/20181128/pKtl-hphsupx4744393.jpg";

  var imageUrl2 =
      "http://n.sinaimg.cn/sports/2_img/upload/4f160954/107/w1024h683/20181128/Yrxn-hpinrya6814381.jpg";

  @override
  Widget build(BuildContext context) {
    return new Align(
      child: ListView(
        children: <Widget>[
          new Text('资源图片：'),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'images/logo.png',
                ),
              ),
//              new Image.file(
//                File('/storage/emulated/0/Download/test.jpg'),
//                width: 120,
//                //fill(全图显示且填充满，图片可能会拉伸)，contain（全图显示但不充满，显示原比例），cover（显示可能拉伸，也可能裁剪，充满）
//                //fitWidth（显示可能拉伸，可能裁剪，宽度充满），fitHeight显示可能拉伸，可能裁剪，高度充满），scaleDown（效果和contain差不多，但是）
//              ),
            ],
          ),
          new Text('网络占位图片CachedNetworkImage：'),
          new Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  imageUrl,
                  scale: 8.5,
                ),
                new Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: CachedNetworkImage(
                    width: 120,
                    fit: BoxFit.fitWidth,
                    placeholder: Image(image: AssetImage('images/logo.png')),
                    imageUrl: imageUrl,
                    errorWidget: new Icon(Icons.error),
                  ),
                ),
                new CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 120,
                  fit: BoxFit.fitWidth,
                  placeholder: CircularProgressIndicator(),
                  errorWidget: new Icon(Icons.error),
                )
              ],
            ),
          ),
          new Text('网络占位图片FadeInImage：'),
          new Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: new Row(
              children: <Widget>[
                new FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: imageUrl,
                  width: 120,
                  fit: BoxFit.fitWidth,
                ),
                new Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: new FadeInImage.assetNetwork(
                    placeholder: 'images/logo.png',
                    image: imageUrl,
                    width: 120,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          new Text('圆形圆角图片：'),
          new Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new ClipOval(
                  child: Image.network(
                    imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: ClipOval(
                    child: Image.asset(
                      'images/logo.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                new ClipRRect(
                  child: Image.network(
                    imageUrl,
                    scale: 8.5,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                )
              ],
            ),
          ),
          new Text('颜色混合图片：'),
          new Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image.asset(
                  'images/logo.png',
                  color: Colors.red,
                  colorBlendMode: BlendMode.darken,
                ),
                new Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Image.network(
                    imageUrl,
                    scale: 8.5,
                    colorBlendMode: BlendMode.colorDodge,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          new Text('centerSlice图片内部拉伸：'),
          new Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: new Image.asset(
              'images/logo.png',
              width: 250,
              height: 250,
              fit: BoxFit.contain,
              centerSlice:
                  new Rect.fromCircle(center: const Offset(20, 20), radius: 1),
            ),
          ),
          new Text('matchTextDirection图片内部方向'),
          new Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Directionality(
                  textDirection: TextDirection.ltr,
                  child: Image.network(
                    imageUrl,
                    height: 100,
                    matchTextDirection: true,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Image.network(
                      imageUrl,
                      height: 100,
                      matchTextDirection: true,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Text('点击替换图片'),
          new Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Row(
              children: <Widget>[
                new RaisedButton(
                  onPressed: () {
                    setState(() {
                      widget.networkImage =
                          new NetworkImage(imageUrl2, scale: 8.5);
                    });
                  },
                  child: Text('点击更换图片'),
                ),
                new Image(
                  gaplessPlayback: false,
                  fit: BoxFit.contain,
                  image: widget.networkImage,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
```

代码已上传至[Github](https://github.com/24Kshign/FlutterWorkSpace/tree/master/flutter_element)