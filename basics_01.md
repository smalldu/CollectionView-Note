
## CollectionView 基础01 - 布局篇 

我们日常开发中大部分的列表视图都可以使用 `UITableView` 完美的实现，它使用起来非常的简单高效。但是面对一些网格视图和瀑布流，甚至交叉布局，圆形等各种创新布局，`UITableView` 显得束手无策，这时候我们需要祭出 `UICollectionView` ，它真的是一个非常强大的控件, 既可以实现简单的列表网格等布局，也可以完成各种复杂的自定义布局，以及动画特效。是一个非常值得花时间去学习的控件。所以我打算对此做一个总结，从基础的`FlowLayout` 到各种 自定义布局。全面的学习这个控件。


第一篇主要了解这个控件，以及使用他来做一个基本的网格布局。


`UICollectionView` 的基本使用非常简单，和`UITableView`类似。但是它将展示和布局分开处理。`UICollectionView` 负责展示数据，`UICollectionViewLayout` 负责处理布局信息，系统默认帮我们实现了一种流式布局 `UICollectionViewFlowLayout` ，可以满足大部分场景。下面展示简单的例子。















