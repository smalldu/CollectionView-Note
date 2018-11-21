//
//  StretchyLayout.swift
//  CollectionView-Note
//
//  Created by zuber on 2018/11/20.
//  Copyright © 2018年 zuber. All rights reserved.
//

import UIKit

class StretchyLayout: UICollectionViewFlowLayout {
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let collectionView = self.collectionView else { return nil }
    guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
    let insets = collectionView.contentInset
    let offset = collectionView.contentOffset
    let minY = -insets.top
    
    if offset.y < minY {
      let headerSize = self.headerReferenceSize
      let deltalY = abs(offset.y - minY)
      for attibute in attributes {
        if attibute.representedElementKind == UICollectionView.elementKindSectionHeader {
          // 为可伸缩header
          var headerRect = attibute.frame
          headerRect.size.height = headerSize.height + deltalY
          headerRect.origin.y = headerRect.origin.y - deltalY
          attibute.frame = headerRect
        }
      }
    }
    return attributes
  }

  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
}


