//
//  CardLayout.swift
//  CollectionView-Note
//
//  Created by zuber on 2018/11/19.
//  Copyright © 2018年 zuber. All rights reserved.
//


import UIKit

class CardLayout: UICollectionViewFlowLayout {
  
  private let widthScale = CGFloat(0.7)
  private let heightScale = CGFloat(0.75)
  
  /// MARK: - 一些计算属性 防止编写冗余代码
  
  private var collectionViewHeight: CGFloat {
    return collectionView!.frame.height
  }
  private var collectionViewWidth: CGFloat {
    return collectionView!.frame.width
  }
  
  private var cellWidth: CGFloat {
    return collectionViewWidth*widthScale
  }
  
  private var cellMargin: CGFloat {
    return (collectionViewWidth - cellWidth)/7
  }
  
  private var margin: CGFloat {
    return (collectionViewWidth - cellWidth)/2
  }
  
  override func prepare() {
    super.prepare()
    scrollDirection = .horizontal
    sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
    minimumLineSpacing = cellMargin
    itemSize = CGSize(width: cellWidth, height: collectionViewHeight*heightScale)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let collectionView = self.collectionView else { return nil }
    guard let visibleAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
    let centerX = collectionView.contentOffset.x + collectionView.bounds.size.width/2
    for attribute in visibleAttributes{
      print(attribute.indexPath)
      let distance = abs(attribute.center.x - centerX)
      // 移动的距离和屏幕宽度的的比例
      let aprtScale = distance / collectionView.bounds.size.width
      // 把卡片移动范围固定到 -π/4到 +π/4这一个范围内
      let scale = abs(cos(aprtScale * CGFloat(Double.pi/4)))
      // 设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
      attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    return visibleAttributes
  }
  
  // 是否实时刷新布局
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
}
