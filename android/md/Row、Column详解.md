

# Flutter 布局（七）- Row、Column详解

 

> 本文主要介绍Flutter布局中的Row、Column控件，详细介绍了其布局行为以及使用场景，并对源码进行了分析。



## 1. Row

 

> A widget that displays its children in a horizontal array.

 

### 1.1 简介

 

在Flutter中非常常见的一个多子节点控件，将children排列成一行。估计是借鉴了Web中Flex布局，所以很多属性和表现，都跟其相似。但是注意一点，自身不带滚动属性，如果超出了一行，在debug下面则会显示溢出的提示。

 

### 1.2 布局行为

 

Row的布局有六个步骤，这种布局表现来自Flex（Row和Column的父类）：

 

1. 首先按照不受限制的主轴（main axis）约束条件，对flex为null或者为0的child进行布局，然后按照交叉轴（ cross axis）的约束，对child进行调整；
2. 按照不为空的flex值，将主轴方向上剩余的空间分成相应的几等分；
3. 对上述步骤flex值不为空的child，在交叉轴方向进行调整，在主轴方向使用最大约束条件，让其占满步骤2所分得的空间；
4. Flex交叉轴的范围取自子节点的最大交叉轴；
5. 主轴Flex的值是由mainAxisSize属性决定的，其中MainAxisSize可以取max、min以及具体的value值；
6. 每一个child的位置是由mainAxisAlignment以及crossAxisAlignment所决定。

 

Row的布局行为表面上看有这么多个步骤，其实也还算是简单，可以完全参照web中的Flex布局，包括主轴、交叉轴等概念。

 

[![Flex](https://camo.githubusercontent.com/1b5660ccd1e06da058a8eafa70eaf5f3c8876abc/687474703a2f2f776879736f6469616f2e636f6d2f696d616765732f466c65782e706e67)](https://camo.githubusercontent.com/1b5660ccd1e06da058a8eafa70eaf5f3c8876abc/687474703a2f2f776879736f6469616f2e636f6d2f696d616765732f466c65782e706e67)

 

### 1.3 继承关系

 

```
Object > Diagnosticable > DiagnosticableTree > Widget > RenderObjectWidget > MultiChildRenderObjectWidget > Flex > Row
```

 

Row以及Column都是Flex的子类，它们的具体实现也都是由Flex完成，只是参数不同。

 

### 1.4 示例代码

 

```
Row(
  children: <Widget>[
    Expanded(
      child: Container(
        color: Colors.red,
        padding: EdgeInsets.all(5.0),
      ),
      flex: 1,
    ),
    Expanded(
      child: Container(
        color: Colors.yellow,
        padding: EdgeInsets.all(5.0),
      ),
      flex: 2,
    ),
    Expanded(
      child: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(5.0),
      ),
      flex: 1,
    ),
  ],
)
```

 

一个很简单的例子，使用Expanded控件，将一行的宽度分成四个等分，第一、三个child占1/4的区域，第二个child占1/2区域，由flex属性控制。

 

### 1.5 源码解析

 

构造函数如下：

 

```
Row({
  Key key,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  MainAxisSize mainAxisSize = MainAxisSize.max,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  TextDirection textDirection,
  VerticalDirection verticalDirection = VerticalDirection.down,
  TextBaseline textBaseline,
  List<Widget> children = const <Widget>[],
})
```

 

#### 1.5.1 属性解析

 

**MainAxisAlignment**：主轴方向上的对齐方式，会对child的位置起作用，默认是start。

 

其中MainAxisAlignment枚举值：

 

- center：将children放置在主轴的中心；
- end：将children放置在主轴的末尾；
- spaceAround：将主轴方向上的空白区域均分，使得children之间的空白区域相等，但是首尾child的空白区域为1/2；
- spaceBetween：将主轴方向上的空白区域均分，使得children之间的空白区域相等，首尾child都靠近首尾，没有间隙；
- spaceEvenly：将主轴方向上的空白区域均分，使得children之间的空白区域相等，包括首尾child；
- start：将children放置在主轴的起点；

 

其中spaceAround、spaceBetween以及spaceEvenly的区别，就是对待首尾child的方式。其距离首尾的距离分别是空白区域的1/2、0、1。

 

**MainAxisSize**：在主轴方向占有空间的值，默认是max。

 

MainAxisSize的取值有两种：

 

- max：根据传入的布局约束条件，最大化主轴方向的可用空间；
- min：与max相反，是最小化主轴方向的可用空间；

 

**CrossAxisAlignment**：children在交叉轴方向的对齐方式，与MainAxisAlignment略有不同。

 

CrossAxisAlignment枚举值有如下几种：

 

- baseline：在交叉轴方向，使得children的baseline对齐；
- center：children在交叉轴上居中展示；
- end：children在交叉轴上末尾展示；
- start：children在交叉轴上起点处展示；
- stretch：让children填满交叉轴方向；

 

**TextDirection**：阿拉伯语系的兼容设置，一般无需处理。

 

**VerticalDirection**：定义了children摆放顺序，默认是down。

 

VerticalDirection枚举值有两种：

 

- down：从top到bottom进行布局；
- up：从bottom到top进行布局。

 

top对应Row以及Column的话，就是左边和顶部，bottom的话，则是右边和底部。

 

- **TextBaseline**：使用的TextBaseline的方式，有两种，前面已经介绍过。

 

#### 1.5.2 源码

 

Row以及Column的源代码就一个构造函数，具体的实现全部在它们的父类Flex中。

 

关于Flex的构造函数

 

```
Flex({
  Key key,
  @required this.direction,
  this.mainAxisAlignment = MainAxisAlignment.start,
  this.mainAxisSize = MainAxisSize.max,
  this.crossAxisAlignment = CrossAxisAlignment.center,
  this.textDirection,
  this.verticalDirection = VerticalDirection.down,
  this.textBaseline,
  List<Widget> children = const <Widget>[],
})
```

 

可以看出，Flex的构造函数就比Row和Column的多了一个参数。Row跟Column的区别，正是这个direction参数的不同。当为Axis.horizontal的时候，则是Row，当为Axis.vertical的时候，则是Column。

 

我们来看下Flex的布局函数，由于布局函数比较多，因此分段来讲解：

 

```
while (child != null) {
  final FlexParentData childParentData = child.parentData;
  totalChildren++;
  final int flex = _getFlex(child);
  if (flex > 0) {
    totalFlex += childParentData.flex;
    lastFlexChild = child;
  } else {
    BoxConstraints innerConstraints;
    if (crossAxisAlignment == CrossAxisAlignment.stretch) {
      switch (_direction) {
        case Axis.horizontal:
          innerConstraints = new BoxConstraints(minHeight: constraints.maxHeight,
                                                maxHeight: constraints.maxHeight);
          break;
        case Axis.vertical:
          innerConstraints = new BoxConstraints(minWidth: constraints.maxWidth,
                                                maxWidth: constraints.maxWidth);
          break;
      }
    } else {
      switch (_direction) {
        case Axis.horizontal:
          innerConstraints = new BoxConstraints(maxHeight: constraints.maxHeight);
          break;
        case Axis.vertical:
          innerConstraints = new BoxConstraints(maxWidth: constraints.maxWidth);
          break;
      }
    }
    child.layout(innerConstraints, parentUsesSize: true);
    allocatedSize += _getMainSize(child);
    crossSize = math.max(crossSize, _getCrossSize(child));
  }
  child = childParentData.nextSibling;
}
```

 

上面这段代码，我把中间的一些assert以及错误信息之类的代码剔除了，不影响实际的理解。

 

在布局的开始，首先会遍历一遍child，遍历的作用有两点：

 

- 对于存在flex值的child，计算出flex的和，找到最后一个包含flex值的child。找到这个child，是因为主轴对齐方式，可能会对它的位置做调整，需要找出来；
- 对于不包含flex的child，根据交叉轴方向的设置，对child进行调整。

 

```
final double freeSpace = math.max(0.0, (canFlex ? maxMainSize : 0.0) - allocatedSize);
if (totalFlex > 0 || crossAxisAlignment == CrossAxisAlignment.baseline) {
  final double spacePerFlex = canFlex && totalFlex > 0 ? (freeSpace / totalFlex) : double.nan;
  child = firstChild;
  while (child != null) {
    final int flex = _getFlex(child);
    if (flex > 0) {
      final double maxChildExtent = canFlex ? (child == lastFlexChild ? (freeSpace - allocatedFlexSpace) : spacePerFlex * flex) : double.infinity;
      double minChildExtent;
      switch (_getFit(child)) {
        case FlexFit.tight:
          assert(maxChildExtent < double.infinity);
          minChildExtent = maxChildExtent;
          break;
        case FlexFit.loose:
          minChildExtent = 0.0;
          break;
      }
      BoxConstraints innerConstraints;
      if (crossAxisAlignment == CrossAxisAlignment.stretch) {
        switch (_direction) {
          case Axis.horizontal:
            innerConstraints = new BoxConstraints(minWidth: minChildExtent,
                                                  maxWidth: maxChildExtent,
                                                  minHeight: constraints.maxHeight,
                                                  maxHeight: constraints.maxHeight);
            break;
          case Axis.vertical:
            innerConstraints = new BoxConstraints(minWidth: constraints.maxWidth,
                                                  maxWidth: constraints.maxWidth,
                                                  minHeight: minChildExtent,
                                                  maxHeight: maxChildExtent);
            break;
        }
      } else {
        switch (_direction) {
          case Axis.horizontal:
            innerConstraints = new BoxConstraints(minWidth: minChildExtent,
                                                  maxWidth: maxChildExtent,
                                                  maxHeight: constraints.maxHeight);
            break;
          case Axis.vertical:
            innerConstraints = new BoxConstraints(maxWidth: constraints.maxWidth,
                                                  minHeight: minChildExtent,
                                                  maxHeight: maxChildExtent);
            break;
        }
      }
      child.layout(innerConstraints, parentUsesSize: true);
      final double childSize = _getMainSize(child);
      allocatedSize += childSize;
      allocatedFlexSpace += maxChildExtent;
      crossSize = math.max(crossSize, _getCrossSize(child));
    }
    if (crossAxisAlignment == CrossAxisAlignment.baseline) {
      final double distance = child.getDistanceToBaseline(textBaseline, onlyReal: true);
      if (distance != null)
        maxBaselineDistance = math.max(maxBaselineDistance, distance);
    }
    final FlexParentData childParentData = child.parentData;
    child = childParentData.nextSibling;
  }
}
```

 

上面的代码段所做的事情也有两点：

 

- 为包含flex的child分配剩余的空间

 

对于每份flex所对应的空间大小，它的计算方式如下：

 

```
final double freeSpace = math.max(0.0, (canFlex ? maxMainSize : 0.0) - allocatedSize);
final double spacePerFlex = canFlex && totalFlex > 0 ? (freeSpace / totalFlex) : double.nan;
```

 

其中，allocatedSize是不包含flex所占用的空间。当每一份flex所占用的空间计算出来后，则根据交叉轴的设置，对包含flex的child进行调整。

 

- 计算出baseline值

 

如果交叉轴的对齐方式为baseline，则计算出最大的baseline值，将其作为整体的baseline值。

 

```
switch (_mainAxisAlignment) {
  case MainAxisAlignment.start:
    leadingSpace = 0.0;
    betweenSpace = 0.0;
    break;
  case MainAxisAlignment.end:
    leadingSpace = remainingSpace;
    betweenSpace = 0.0;
    break;
  case MainAxisAlignment.center:
    leadingSpace = remainingSpace / 2.0;
    betweenSpace = 0.0;
    break;
  case MainAxisAlignment.spaceBetween:
    leadingSpace = 0.0;
    betweenSpace = totalChildren > 1 ? remainingSpace / (totalChildren - 1) : 0.0;
    break;
  case MainAxisAlignment.spaceAround:
    betweenSpace = totalChildren > 0 ? remainingSpace / totalChildren : 0.0;
    leadingSpace = betweenSpace / 2.0;
    break;
  case MainAxisAlignment.spaceEvenly:
    betweenSpace = totalChildren > 0 ? remainingSpace / (totalChildren + 1) : 0.0;
    leadingSpace = betweenSpace;
    break;
}
```

 

然后，就是将child在主轴方向上按照设置的对齐方式，进行位置调整。上面代码就是计算前后空白区域值的过程，可以看出spaceBetween、spaceAround以及spaceEvenly的差别。

 

```
double childMainPosition = flipMainAxis ? actualSize - leadingSpace : leadingSpace;
child = firstChild;
while (child != null) {
  final FlexParentData childParentData = child.parentData;
  double childCrossPosition;
  switch (_crossAxisAlignment) {
    case CrossAxisAlignment.start:
    case CrossAxisAlignment.end:
      childCrossPosition = _startIsTopLeft(flipAxis(direction), textDirection, verticalDirection)
                           == (_crossAxisAlignment == CrossAxisAlignment.start)
                         ? 0.0
                         : crossSize - _getCrossSize(child);
      break;
    case CrossAxisAlignment.center:
      childCrossPosition = crossSize / 2.0 - _getCrossSize(child) / 2.0;
      break;
    case CrossAxisAlignment.stretch:
      childCrossPosition = 0.0;
      break;
    case CrossAxisAlignment.baseline:
      childCrossPosition = 0.0;
      if (_direction == Axis.horizontal) {
        assert(textBaseline != null);
        final double distance = child.getDistanceToBaseline(textBaseline, onlyReal: true);
        if (distance != null)
          childCrossPosition = maxBaselineDistance - distance;
      }
      break;
  }
  if (flipMainAxis)
    childMainPosition -= _getMainSize(child);
  switch (_direction) {
    case Axis.horizontal:
      childParentData.offset = new Offset(childMainPosition, childCrossPosition);
      break;
    case Axis.vertical:
      childParentData.offset = new Offset(childCrossPosition, childMainPosition);
      break;
  }
  if (flipMainAxis) {
    childMainPosition -= betweenSpace;
  } else {
    childMainPosition += _getMainSize(child) + betweenSpace;
  }
  child = childParentData.nextSibling;
}
```

 

最后，则是根据交叉轴的对齐方式设置，对child进行位置调整，到此，布局结束。

 

我们可以顺一下整体的流程：

 

- 计算出flex的总和，并找到最后一个设置了flex的child；
- 对不包含flex的child，根据交叉轴对齐方式，对齐进行调整，并计算出主轴方向上所占区域大小；
- 计算出每一份flex所占用的空间，并根据交叉轴对齐方式，对包含flex的child进行调整；
- 如果交叉轴设置为baseline对齐，则计算出整体的baseline值；
- 按照主轴对齐方式，对child进行调整；
- 最后，根据交叉轴对齐方式，对所有child位置进行调整，完成布局。

 

### 1.6 使用场景

 

Row和Column都是非常常用的布局控件。一般情况下，比方说需要将控件在一行或者一列显示的时候，都可以使用。但并不是说只能使用Row或者Column去布局，也可以使用Stack，看具体的场景选择。

 

## 2. Column

 

在讲解Row的时候，其实是按照Flex的一些布局行为来进行的，包括源码分析，也都是在用Flex进行分析的。Row和Column都是Flex的子类，只是direction参数不同。Column各方面同Row，因此在这里不再另行讲解。

 

在讲解Flex的时候，也说过是参照了web的Flex布局，如果有相关开发经验的同学，完全可以参照着去理解，这样子更容易去理解它们的用法和原理。

 

## 3. 后话

 

笔者建了一个flutter学习相关的项目，[github地址](https://github.com/ybb963416867/flutter_app)，里面包含了笔者写的关于flutter学习相关的一些文章，会定期更新，也会上传一些学习demo，欢迎大家关注。

 

## 4. 来自

 

1. [Container class](https://www.jianshu.com/p/366b2446eaab)