//
//  BasicsViewController.swift
//  CollectionView-Note
//
//  Created by zuber on 2018/11/19.
//  Copyright © 2018年 zuber. All rights reserved.
//

import UIKit

class BasicsViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var flowLayout: UICollectionViewFlowLayout? {
    return collectionView.collectionViewLayout as? UICollectionViewFlowLayout
  }
  
  var colors: [[UIColor]] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = self
    
    collectionView.register(UINib(nibName: "BasicsHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BasicsHeaderView.reuseID)
    collectionView.register(UINib(nibName: "BasicsFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: BasicsFooterView.reuseID)
    
    // 加内边距
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    
    let itemWidth = (view.bounds.width - 2)/3 - 2
    flowLayout?.itemSize = CGSize(width: itemWidth, height: itemWidth)
    // 最小行间距
    flowLayout?.minimumLineSpacing = 1
    // 最小元素之间的间距
    flowLayout?.minimumInteritemSpacing = 1
    flowLayout?.headerReferenceSize = CGSize(width: view.bounds.width, height: 50)
    flowLayout?.footerReferenceSize = CGSize(width: view.bounds.width, height: 30)
    
    colors.append(DataManager.shared.generalColors(8))
    colors.append(DataManager.shared.generalColors(5))
    colors.append(DataManager.shared.generalColors(7))
  }
  
}

// MARK: - UICollectionViewDataSource

extension BasicsViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return colors.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return colors[section].count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicsCell.reuseID, for: indexPath) as! BasicsCell
    cell.backgroundColor = colors[indexPath.section][indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BasicsHeaderView.reuseID, for: indexPath) as! BasicsHeaderView
      view.titleLabel.text = "HEADER -- \(indexPath.section)"
      return view
    case UICollectionView.elementKindSectionFooter:
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BasicsFooterView.reuseID, for: indexPath) as! BasicsFooterView
      view.titleLabel.text = "FOOTER -- \(indexPath.section)"
      return view
    default:
      fatalError("No such kind")
    }
  }
  
}
