
首先我们做一些数据准备，这里不是重点  提一下，大家可以下载代码查看。 

```
  // 1
  let randomText = "黑发不知勤学早白首方悔读书迟迟日江山丽春风花草香杜甫绝句春色满园关不住一枝红杏出墙来叶绍翁游园不值好雨知时节当春乃发生杜甫春雨夏天小荷才露尖尖角早有蜻蜓立上头杨万里小池接天莲叶无穷碧映日荷花别样红"
  
  // 2
  func genernalText() -> String{
    let textCount = randomText.count
    let randomIndex = arc4random_uniform(UInt32(textCount))
    let start = max(0, Int(randomIndex)-7)
    let startIndex = randomText.startIndex
    let step = arc4random_uniform(5) + 2 // 2到5个字
    let startTextIndex = randomText.index(startIndex, offsetBy: start)
    let endTexIndex = randomText.index(startIndex, offsetBy: start + Int(step))
    let text = String(randomText[startTextIndex ..< endTexIndex])
    return text
  }
  
  // 3
  func generalTags() -> [[String]]{
    var tags1: [String] = []
    var tags2: [String] = []
    var tags3: [String] = []
    
    for i in 0..<50 {
      if i%3 == 0 {
        tags1.append(genernalText())
      }
      if i%2 == 0{
        tags2.append(genernalText())
      }
      tags3.append(genernalText())
    }
    return [tags1,tags2,tags3]
  }
```

1. 声明一长串文字
2. 从长文中随机产生一个2-5个字的文本
3. 因为是分组这里生成三组不同长度的数组 组成一个二维数组 作为数据源。


然后像之前章节一样 `Storyboard` 中创建一个 `TagViewController` ， 声明 `collectionView` ， 新建一个 `TagLayout` , 替换自带的 `flowLayout` (具体替换方法参照之前文章)

在我们的 `TagLayout` 有一个变数就是文本的长度，这个我们可以根据文本的字体和Text内容计算出。为了使用便捷这里提供一个代理方法 (建议下载源码结合查看)

```
protocol TagLayoutDelegate: class {
  func collectionView(_ collectionView: UICollectionView, TextForItemAt indexPath: IndexPath) -> String
}
```

根据 `indexPath` 返回对应的文本 。 

在 `TagLayout` 顶部添加一个枚举

```
enum Element {
   case cell
   case header
   case sectionHeader
}
```

包含了 后面我们要自定义位置的三个元素 

添加一个变量和常量 

```
// 标签的内边距
var tagInnerMargin: CGFloat = 25
// 元素间距
var itemSpacing: CGFloat = 10
// 行间距
var lineSpacing: CGFloat = 10
// 标签的高度
var itemHeight: CGFloat = 25
// 标签的字体
var itemFont: UIFont = UIFont.systemFont(ofSize: 12)
// header的高度
var headerHeight: CGFloat = 150
// sectionHeader 高度
var sectionHeaderHeight: CGFloat = 50
// header的类型
let headerKind = "ElementTagHeader"

weak var delegate: TagLayoutDelegate?
```

顶部的header为了区分系统的 `elementKindSectionHeader` 我们自定义了一种kind。 


然后定义一些私有变量。

```
// 缓存
private var cache = [Element: [IndexPath: UICollectionViewLayoutAttributes]]()
// 可见区域
private var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
// 内容高度
private var contentHeight: CGFloat = 0
// 用来记录新增的元素
private var insertIndexPaths = [IndexPath]()
// 用来记录删除的元素
private var deleteIndexPaths = [IndexPath]()}

// MARK: - 一些计算属性 防止编写冗余代码
  
private var collectionViewWidth: CGFloat {
  return collectionView!.frame.width
}
```

本篇中的缓存按照枚举类型进行了区分，但是实质还是差不多的。

下面开始具体的布局信息计算和缓存 。 


```swift
override func prepare() {
    // 1
    guard let collectionView = self.collectionView , let delegate = delegate else { return }
    let sections = collectionView.numberOfSections
    // 2 
    prepareCache()
    contentHeight = 0
    
    // 3
    // 可伸缩header
    let headerIndexPath = IndexPath(item: 0, section: 0)
    let headerAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: headerKind, with: headerIndexPath)
    let frame = CGRect(x: 0, y: 0, width: collectionViewWidth, height: headerHeight)
    headerAttribute.frame = frame
    cache[.header]?[headerIndexPath] = headerAttribute
    contentHeight = frame.maxY
    
    // 4
    for section in 0 ..< sections {
      // 处理sectionHeader
      let sectionHeaderIndexPath = IndexPath(item: 0, section: section)
      
      // 5
      let sectionHeaderAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: sectionHeaderIndexPath)
      var sectionOriginY = contentHeight
      if section != 0 {
        sectionOriginY += lineSpacing
      }
      let sectionFrame = CGRect(x: 0 , y: sectionOriginY , width: collectionViewWidth , height: sectionHeaderHeight)
      sectionHeaderAttribute.frame = sectionFrame
      cache[.sectionHeader]?[sectionHeaderIndexPath] = sectionHeaderAttribute
      contentHeight = sectionFrame.maxY
      
      // 6
      // 处理tag
      let rows = collectionView.numberOfItems(inSection: section)
      var frame = CGRect(x: 0, y: contentHeight + lineSpacing, width: 0, height: 0)
      
      for item in 0 ..< rows {
        let indexPath = IndexPath(item: item, section: section)
        // 7
        let text = delegate.collectionView(collectionView, TextForItemAt: indexPath)
        let tagWidth = self.textWidth(text) + tagInnerMargin
        // 8
        // 其他
        if frame.maxX + tagWidth + itemSpacing*2 > collectionViewWidth {
          // 需要换行
          frame = CGRect(x: itemSpacing , y: frame.maxY + lineSpacing , width: tagWidth, height: itemHeight)
        }else{
          frame = CGRect(x: frame.maxX + itemSpacing, y: frame.origin.y , width: tagWidth , height: itemHeight)
        }
        // 9
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = frame
        cache[.cell]?[indexPath] = attributes
      }
      contentHeight = frame.maxY
    }
}

private func prepareCache() {
  cache.removeAll(keepingCapacity: true)
  cache[.sectionHeader] = [IndexPath: UICollectionViewLayoutAttributes]()
  cache[.cell] = [IndexPath: UICollectionViewLayoutAttributes]()
  cache[.header] = [IndexPath: UICollectionViewLayoutAttributes]()
}

// 根据文字 确定label的宽度
private func textWidth(_ text: String) -> CGFloat {
  let rect = (text as NSString).boundingRect(with: .zero, options: .usesLineFragmentOrigin, attributes: [.font: self.itemFont], context: nil)
  return rect.width
}

```


这段代码有点长，我们一一解释。 

1. 可选绑定，并获取section的数量
2. 






































