# [Flutter常用组件（Widget）解析-Text](https://www.cnblogs.com/zengfp/p/9982291.html)              

   

单一格式的文本。

文本组件是以字符串形式显示的单一格式，这个文本字符串可以是多行显示也可以是单独一行显示，主要取决于你的布局限制。

这样式内容是可选择的，如果你省略了，则会使用文本的默认样式来显示。如果给定的style的文本继承属性是true，即默认的，则这些给定的样式会与那些默认的文本样式合并。这种合并的属性非常有用，比如，让文字粗体显示，我们可以使用默认的字体和大小。

```
child: new Text(
        'Hello,  How are you?',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
```



![img](https://img2018.cnblogs.com/blog/1475852/201811/1475852-20181119102903878-198371009.png)

我们也可以使用富文本编辑器，让一段文本通过使用不同的TextSpan显示不同的样式。比如我们让"Hello beautiful world"的每个单词都显示不同的样式：

```
const Text.rich(
  TextSpan(
    text: 'Hello', // default text style
    children: <TextSpan>[
      TextSpan(text: ' beautiful ', style: TextStyle(fontStyle: FontStyle.italic，fontSize: 48.0)),//斜体
      TextSpan(text: 'world', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 36.0)),//粗体
    ],
  ),
)
```



![img](https://img2018.cnblogs.com/blog/1475852/201811/1475852-20181119103547638-594626169.png)

当我们对一个文本的行数有要求时，就需要用到maxLines属性了：



```
 child: new Text(
        'Hello, How are you?Hello, How are you?Hello, How are you?Hello, How are you?',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 48.0),
        maxLines: 2,
      ),
```



![img](https://img2018.cnblogs.com/blog/1475852/201811/1475852-20181119104111236-1853372001.png)

 **1、textAlign**

文本对齐方式

- center: 文本以居中形式对齐。
- left:左对齐，经常使用，让文本居左进行对齐，效果和start一样。
- right :右对齐。
- start:以开始位置进行对齐，类似于左对齐。
- end: 以为本结尾处进行对齐，不常用。有点类似右对齐。

**2、maxLines**

设置最多显示的行数。用法： maxLines: int整数 

**3、overflow**

这个属性是用来设置溢出文本的样式，通常与maxLines配合一起使用。有以下几个属性值：

- clip 超出文本框范围内的文字直接切断。显得很生硬，没有过度，不友好
- ellipsis 使用省略号来显示溢出的文本，用的比较多的一种效果
- fade 对超出文本内容的部分会有一个渐变消失的效果，这个不是左右渐变的效果，而是下面部分渐变的效果。可以看例子：

```
　　　　　'Hello, How are you? I am fine. Thank you',
        textAlign: TextAlign.center,
        overflow: TextOverflow.fade,
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 48.0),
        maxLines: 1,
```

 

 ![img](https://img2018.cnblogs.com/blog/1475852/201811/1475852-20181119112801879-1563146978.png)

可以从上图看到，文本下面部分是有阴影效果的。

**4、style**

style属性的内容算是比较多的，通常就是我们对文字样式的设置

Bold

粗体显示

```
Text(
  'Hello, How are you? I am fine. Thank you', 　style: TextStyle(fontWeight: FontWeight.bold), )
```

 

Italics

斜体显示

```
child: Text(
        'Hello, How are you? I am fine. Thank you',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
```

 

Opacity和Color

透明度和字体颜色

```
child: Text(
        'Hello, How are you? I am fine. Thank you',
        style: TextStyle(color: Colors.red),//红色字体
      ),
child: Text(
        'Hello, How are you? I am fine. Thank you',
        style: TextStyle(color: Colors.red.withOpacity(0.5)),//透明度50%的红色字体
      ),
```

Size

字体大小

```
child: Text(
        'Hello, How are you? I am fine. Thank you',
        style: TextStyle(color: Colors.red.withOpacity(0.5),fontSize: 48.0),
      ),
```

 

Line height

行高

```
child: Text(
        'Hello, How are you? I am fine. Thank you',
        style: TextStyle(color: Colors.red.withOpacity(0.5),fontSize: 48.0,height: 5.0),
      ),
```

 

**5、以上就是比较常用的文本组件的属性，更多更详细的可以参考网址：一键送达**