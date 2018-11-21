//
//  StretchyHeaderViewController.swift
//  CollectionView-Note
//
//  Created by zuber on 2018/11/20.
//  Copyright © 2018年 zuber. All rights reserved.
//

import UIKit

class StretchyHeaderViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var layout: StretchyLayout? {
    return collectionView.collectionViewLayout as? StretchyLayout
  }
  
  var colors: [UIColor] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    
    colors = DataManager.shared.generalColors(3)
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: "ImageHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ImageHeaderView.reuseID)
    
    collectionView.register(UINib(nibName: "BasicsHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BasicsHeaderView.reuseID)
    
    collectionView.alwaysBounceVertical = true
    let width = view.bounds.width
    layout?.itemSize = CGSize(width: width, height: 50)
    layout?.minimumLineSpacing = 2
    layout?.headerReferenceSize = CGSize(width: width, height: 150)
  }
  
}


// MARK: - UICollectionViewDataSource

extension StretchyHeaderViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return colors.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicsCell.reuseID, for: indexPath) as! BasicsCell
    cell.backgroundColor = colors[indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ImageHeaderView.reuseID, for: indexPath) as! ImageHeaderView
      return view
    default:
      fatalError("No such kind")
    }
  }
  
}


