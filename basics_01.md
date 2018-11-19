卡片布局


上一篇 TODO: link  原理篇 了解一些要实现一个自定义布局需要实现的方法，以及基础的布局类 `UICollectionViewLayout` 给我们提供的方法。那么循序渐进本篇来实现一个横向滚动的卡片布局，这种布局在很多App种也得到使用，有一个不错的视觉效果。先来看下最终效果。 


// TODO: gif 


这种布局其实并不需要我们完全手写每个元素的位置。只是在原来的位置快要展示的时候做一些缩放。所以我们只需要继承自 `UICollectionViewFlowLayout` 流式布局，然后对一些方法进行重写即可。 

首先定义一个继承自 `UICollectionViewFlowLayout` 的类 `CardLayout` 。 并添加一些计算属性

```swift
class CardLayout: UICollectionViewFlowLayout {
  
  /// MARK: - 一些计算属性 防止编写冗余代码
  
  private var collectionViewHeight: CGFloat {
    return collectionView!.frame.height
  }
  private var collectionViewWidth: CGFloat {
    return collectionView!.frame.width
  }
  
  private var cellWidth: CGFloat {
    return collectionViewWidth*0.7
  }
  
  private var cellMargin: CGFloat {
    return (collectionViewWidth - cellWidth)/7
  }
  // 内边距
  private var margin: CGFloat {
    return (collectionViewWidth - cellWidth)/2
  }
  
}
```

然后重写`prepare` 进行一些初始化。 


```
override func prepare() {
    super.prepare()
    scrollDirection = .horizontal
    sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
    minimumLineSpacing = cellMargin
    itemSize = CGSize(width: cellWidth, height: collectionViewHeight*0.75)
}
```
因为我们并不是完成重写，还是利用了`UICollectionViewFlowLayout` 所以需要调用`super.prepare()` 以及`collectionViewContentSize` 这些都不是必须重写的。 

上面设定了滚动方向，内边距，元素大小等 


下面是这个卡片布局的重点，`layoutAttributesForElements(in: ) -> [UICollectionViewLayoutAttributes]?` , 这个方法需要提供可见区域的`UICollectionViewLayoutAttributes` 信息，对cell进行布局，我们看到我们这个布局的效果是cell越趋近屏幕的中心 ， 就越大 ，远离则变小。 所以我们只需要拿出原来的attributes 然后根据它距离中心的位置对其进行放射变换 

```
override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let collectionView = self.collectionView else { return nil }
    // 1
    guard let visibleAttributes = super.layoutAttributesForElements(in: rect) else { return nil }

    // 2
    let centerX = collectionView.contentOffset.x + collectionView.bounds.size.width/2
    for attribute in visibleAttributes {

      // 3
      let distance = abs(attribute.center.x - centerX)
      
      // 4
      let aprtScale = distance / collectionView.bounds.size.width

      // 5
      let scale = abs(cos(aprtScale * CGFloat(Double.pi/4)))
      attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    // 6
    return visibleAttributes
}
```
这里解释下： 



1. 拿到原本的布局信息 （上一篇说过，cell的布局信息存放在 `UICollectionViewLayoutAttributes` 中）
2. 获取屏幕中心距离 `collectionView` 原点的位置 
3. 获取cell中心距离 屏幕中心位置的绝对值。 
4. 用上一步获取的值除以屏幕宽度得到一个缩放比例
5. 将cell的缩放范围规定到 -π/4 到 +π/4之间，并对它执行缩放操作 
6. 返回处理好的属性 

看起来并不难，这时候运行 ，并没有达到想要的效果。 

为什么呢？ 我们在第一个位置滚动到第二个位置的时候第一个位置越来越远离就会变小，所以每次滚动的时候需要重新计算
`shouldInvalidateLayout(forBoundsChange: ) -> Bool` 方法登场。

在上个方法后面添加如下方法

```
// 是否实时刷新布局
override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
	return true
}
```

这时候我们只是写了一个布局，怎么应用到collectionView上呢。 

依旧跟之前一样，使用`Storyboard` （纯代码也很简单，有对应的初始化方法）。 


首先将`CollectionView` 的layout改为custom ， 然后将 layout object改为我们的`CardLayout`


































