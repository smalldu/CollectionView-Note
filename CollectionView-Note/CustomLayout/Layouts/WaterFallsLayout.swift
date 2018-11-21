//
//  WaterFallsLayout.swift
//  CollectionView-Note
//
//  Created by zuber on 2018/11/19.
//  Copyright © 2018年 zuber. All rights reserved.
//

import UIKit

protocol WaterFallsLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat
}

class WaterFallsLayout: UICollectionViewLayout {
  
  var numberOfColumns = 2 // 列
  var minimumLineSpacing: CGFloat = 0
  var minimumInteritemSpacing: CGFloat = 0
  
  var delegate: WaterFallsLayoutDelegate?
  private var cache = [UICollectionViewLayoutAttributes]()
  private var contentHeight: CGFloat = 0
  
  
  private var width: CGFloat {
    return collectionView!.bounds.width
  }
  
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: width, height: contentHeight)
  }
  
  override func prepare() {
    if let collectionView = collectionView, let delegate = delegate , cache.isEmpty {
      let columnWidth = (width - (CGFloat(numberOfColumns) + 1)*minimumInteritemSpacing) / CGFloat(numberOfColumns)
      
      var xOffsets = [CGFloat]()
      for column in 0..<numberOfColumns {
        xOffsets.append(CGFloat(column)*columnWidth + minimumInteritemSpacing*CGFloat(column+1))
      }
      
      var yOffsets = [CGFloat](repeating: minimumLineSpacing, count: numberOfColumns)
      var column = 0
      for item in 0..<collectionView.numberOfItems(inSection: 0) {
        let indexPath = IndexPath(item: item, section: 0)
        let height = delegate.collectionView(collectionView, heightForItemAt: indexPath)
        let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = frame
        cache.append(attributes)
        contentHeight = max(contentHeight, frame.maxY)
        yOffsets[column] = yOffsets[column] + height + minimumLineSpacing // 下一个column的高度
        column = column >= (numberOfColumns - 1) ? 0:column+1
      }
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        layoutAttributes.append(attributes)
      }
    }
    return layoutAttributes
  }
}




