//
//  BasicsHeaderView.swift
//  CollectionView-Note
//
//  Created by zuber on 2018/11/19.
//  Copyright © 2018年 zuber. All rights reserved.
//

import UIKit

class BasicsHeaderView: UICollectionReusableView {
  
  static let reuseID = "BasicsHeaderView"
  
  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    titleLabel.textColor = UIColor.black
    titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
  }
  
}
