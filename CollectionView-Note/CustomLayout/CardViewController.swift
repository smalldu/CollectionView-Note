//
//  CardViewController.swift
//  CollectionView-Note
//
//  Created by zuber on 2018/11/19.
//  Copyright © 2018年 zuber. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  var colors: [UIColor] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = self
    colors = DataManager.shared.generalColors(20)
  }
}

// MARK: - UICollectionViewDataSource

extension CardViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return colors.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicsCell.reuseID, for: indexPath) as! BasicsCell
    cell.backgroundColor = colors[indexPath.row]
    return cell
  }
  
}
