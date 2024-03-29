# Flutter 布局（一）- Container详解

 

> 本文主要介绍Flutter中非常常见的Container，列举了一些实际例子介绍如何使用。

 

## 1. 简介

 

> A convenience widget that combines common painting, positioning, and sizing widgets.

 

Container在Flutter中太常见了。官方给出的简介，是一个结合了绘制（painting）、定位（positioning）以及尺寸（sizing）widget的widget。

 

可以得出几个信息，它是一个组合的widget，内部有绘制widget、定位widget、尺寸widget。后续看到的不少widget，都是通过一些更基础的widget组合而成的。

 

### 1.1 组成

 

Container的组成如下：

 

- 最里层的是child元素；
- child元素首先会被padding包着；
- 然后添加额外的constraints限制；
- 最后添加margin。

 

Container的绘制的过程如下：

 

- 首先会绘制transform效果；
- 接着绘制decoration；
- 然后绘制child；
- 最后绘制foregroundDecoration。

 

Container自身尺寸的调节分两种情况：

 

- Container在没有子节点（children）的时候，会试图去变得足够大。除非constraints是unbounded限制，在这种情况下，Container会试图去变得足够小。
- 带子节点的Container，会根据子节点尺寸调节自身尺寸，但是Container构造器中如果包含了width、height以及constraints，则会按照构造器中的参数来进行尺寸的调节。

 

### 1.2 布局行为

 

由于Container组合了一系列的widget，这些widget都有自己的布局行为，因此Container的布局行为有时候是比较复杂的。

 

一般情况下，Container会遵循如下顺序去尝试布局：

 

- 对齐（alignment）；
- 调节自身尺寸适合子节点；
- 采用width、height以及constraints布局；
- 扩展自身去适应父节点；
- 调节自身到足够小。

 

进一步说：

 

- 如果没有子节点、没有设置width、height以及constraints，并且父节点没有设置unbounded的限制，Container会将自身调整到足够小。
- 如果没有子节点、对齐方式（alignment），但是提供了width、height或者constraints，那么Container会根据自身以及父节点的限制，将自身调节到足够小。
- 如果没有子节点、width、height、constraints以及alignment，但是父节点提供了bounded限制，那么Container会按照父节点的限制，将自身调整到足够大。
- 如果有alignment，父节点提供了unbounded限制，那么Container将会调节自身尺寸来包住child；
- 如果有alignment，并且父节点提供了bounded限制，那么Container会将自身调整的足够大（在父节点的范围内），然后将child根据alignment调整位置；
- 含有child，但是没有width、height、constraints以及alignment，Container会将父节点的constraints传递给child，并且根据child调整自身。

 

另外，margin以及padding属性也会影响到布局。

 

### 1.3 继承关系

 

```
Object > Diagnosticable > DiagnosticableTree > Widget > StatelessWidget > Container
```

 

从继承关系可以看出，Container是一个StatelessWidget。Container并不是一个最基础的widget，它是由一系列的基础widget组合而成。

 

## 2. 源码解析

 

构造函数如下：

 

```dart
Container({
    Key key,
    this.alignment,
    this.padding,
    Color color,
    Decoration decoration,
    this.foregroundDecoration,
    double width,
    double height,
    BoxConstraints constraints,
    this.margin,
    this.transform,
    this.child,
  });
```

 

平时使用最多的，也就是padding、color、width、height、margin属性。

 

### 2.1 属性解析

 

**key**：Container唯一标识符，用于查找更新。

 

**alignment**：控制child的对齐方式，如果container或者container父节点尺寸大于child的尺寸，这个属性设置会起作用，有很多种对齐方式。

 

**padding**：decoration内部的空白区域，如果有child的话，child位于padding内部。padding与margin的不同之处在于，padding是包含在content内，而margin则是外部边界，设置点击事件的话，padding区域会响应，而margin区域不会响应。

 

**color**：用来设置container背景色，如果foregroundDecoration设置的话，可能会遮盖color效果。

 

**decoration**：绘制在child后面的装饰，设置了decoration的话，就不能设置color属性，否则会报错，此时应该在decoration中进行颜色的设置。

 

**foregroundDecoration**：绘制在child前面的装饰。

 

**width**：container的宽度，设置为double.infinity可以强制在宽度上撑满，不设置，则根据child和父节点两者一起布局。

 

**height**：container的高度，设置为double.infinity可以强制在高度上撑满。

 

**constraints**：添加到child上额外的约束条件。

 

**margin**：围绕在decoration和child之外的空白区域，不属于内容区域。

 

**transform**：设置container的变换矩阵，类型为Matrix4。

 

**child**：container中的内容widget。

 

### 2.2 一个例子

 

```
new Container(
  constraints: new BoxConstraints.expand(
    height:Theme.of(context).textTheme.display1.fontSize * 1.1 + 200.0,
  ),
  decoration: new BoxDecoration(
    border: new Border.all(width: 2.0, color: Colors.red),
    color: Colors.grey,
    borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
    image: new DecorationImage(
      image: new NetworkImage('http://h.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=0d023672312ac65c67506e77cec29e27/9f2f070828381f30dea167bbad014c086e06f06c.jpg'),
      centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
    ),
  ),
  padding: const EdgeInsets.all(8.0),
  alignment: Alignment.center,
  child: new Text('Hello World',
    style: Theme.of(context).textTheme.display1.copyWith(color: Colors.black)),
  transform: new Matrix4.rotationZ(0.3),
)
```

 

这是官方文档给出例子的一个变种，包含属性比较全，可以看下其用法。实际运行效果如下：

 

[![Container属性用法](https://camo.githubusercontent.com/ec587ebdcf09cc8704e51a0d828ef9ee8559abd4/687474703a2f2f776879736f6469616f2e636f6d2f696d616765732f636f6e7461696e65722d64656d6f2d312e706e67)](https://camo.githubusercontent.com/ec587ebdcf09cc8704e51a0d828ef9ee8559abd4/687474703a2f2f776879736f6469616f2e636f6d2f696d616765732f636f6e7461696e65722d64656d6f2d312e706e67)

 

其中decoration可以设置边框、背景色、背景图片、圆角等属性，非常实用。对于transform这个属性，一般有过其他平台开发经验的，都大致了解，这种变换，一般不是变换的实际位置，而是变换的绘制效果，也就是说它的点击以及尺寸、间距等都是按照未变换前的。

 

### 2.3 源码

 

```
decoration = decoration ?? (color != null ? new BoxDecoration(color: color) : null),
```

 

可以看出，对于颜色的设置，最后都是转换为decoration来进行绘制的。如果同时包含decoration和color两种属性，则会报错。

 

```
@override
  Widget build(BuildContext context) {
    Widget current = child;

    if (child == null && (constraints == null || !constraints.isTight)) {
      current = new LimitedBox(
        maxWidth: 0.0,
        maxHeight: 0.0,
        child: new ConstrainedBox(constraints: const BoxConstraints.expand())
      );
    }

    if (alignment != null)
      current = new Align(alignment: alignment, child: current);

    final EdgeInsetsGeometry effectivePadding = _paddingIncludingDecoration;
    if (effectivePadding != null)
      current = new Padding(padding: effectivePadding, child: current);

    if (decoration != null)
      current = new DecoratedBox(decoration: decoration, child: current);

    if (foregroundDecoration != null) {
      current = new DecoratedBox(
        decoration: foregroundDecoration,
        position: DecorationPosition.foreground,
        child: current
      );
    }

    if (constraints != null)
      current = new ConstrainedBox(constraints: constraints, child: current);

    if (margin != null)
      current = new Padding(padding: margin, child: current);

    if (transform != null)
      current = new Transform(transform: transform, child: current);

    return current;
  }
```

 

Container的build函数不长，绘制也是一个线性的判断的过程，一层一层的包裹着widget，去实现不同的样式。

 

最里层的是child，如果为空或者其他约束条件，则最里层包含的为一个LimitedBox，然后依次是Align、Padding、DecoratedBox、前景DecoratedBox、ConstrainedBox、Padding（实现margin效果）、Transform。

 

Container的源码本身并不复杂，复杂的是它的各种布局表现。我们谨记住一点，如果内部不设置约束，则按照父节点尽可能的扩大，如果内部有约束，则按照内部来。

 

### 2.4 使用场景

 

Container算是目前项目中，最经常用到的一个widget。在实际使用过程中，笔者在以下情况会使用到Container，当然并不是绝对的，也可以通过其他widget来实现。

 

- 需要设置间隔（这种情况下，如果只是单纯的间隔，也可以通过Padding来实现）；
- 需要设置背景色；
- 需要设置圆角或者边框的时候（ClipRRect也可以实现圆角效果）；
- 需要对齐（Align也可以实现）；
- 需要设置背景图片的时候（也可以使用Stack实现）。

 

## 3. 例子

 

接下来我们试着去做一个圆角按钮，它包含以下特性：

 

- 支持设置按钮的三种状态（正常态、点击态、禁用态）的色值；
- 支持设置按钮标题；
- 支持设置宽高；
- 支持点击回调；

 

根据上面介绍，利用decoration这个属性，基本上就可以完成效果了，至于点击效果以及点击回调，则使用一个GestureDetector就可以完成了。实际的例子非常简单，在这里就不贴代码了。实际运行效果如下所示：

 

[![Container样例](https://camo.githubusercontent.com/5ec0ef2c39ae0705c0413895a3709d1f26b36264/687474703a2f2f776879736f6469616f2e636f6d2f696d616765732f636f6e7461696e65722d64656d6f2d322e676966)](https://camo.githubusercontent.com/5ec0ef2c39ae0705c0413895a3709d1f26b36264/687474703a2f2f776879736f6469616f2e636f6d2f696d616765732f636f6e7461696e65722d64656d6f2d322e676966)

 

### 3.1 注意事项

 

这个小控件，写起来很简单，本身没有什么难度，只是纯粹的介绍了Container的使用方法，但是有一个地方需要注意的。在控件的deactivate状态，我们需要将控件的属性初始到最开始的状态，例如在本例中，有如下代码：

 

```
  @override
  void deactivate() {
    super.deactivate();
    currentColor = widget.backgroundColor;
  }
```

 

这么做是为什么了？是因为在点击按钮进行页面跳转的时候，按钮处在点击态，当我们返回的时候，页面还是处在点击态，这显然就不正确了，因此需要我们手动的在deactivate状态下，将控件恢复到初始状态。但是呢，这个设置颜色，并不是说在deactivate的时候，就立马去刷新控件，而是在下次再进入这个页面的时候，再次运行build的时候，会按照这个初始值进行绘制，也就是恢复到了最开始的状态。

 

### 3.2 代码

 

[代码Github地址](https://github.com/ybb963416867/flutter_app)，这是一个系列的项目，如果不出意外，会将Flutter中常见的二十多种布局widget都介绍一下。

 

## 4. 后话

 

笔者建了一个flutter学习相关的项目，[github地址](https://github.com/ybb963416867/flutter_app)，里面包含了笔者写的关于flutter学习相关的一些文章，会定期更新，也会上传一些学习demo，欢迎大家关注。

 

## 5. 来自

 

1. [Container class](https://www.jianshu.com/p/366b2446eaab)