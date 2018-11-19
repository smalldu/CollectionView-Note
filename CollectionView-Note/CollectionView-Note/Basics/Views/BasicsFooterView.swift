//
//  BasicsFooterView.swift
//  CollectionView-Note
//
//  Created by zuber on 2018/11/19.
//  Copyright © 2018年 zuber. All rights reserved.
//

import UIKit

class BasicsFooterView: UICollectionReusableView {
  
  static let reuseID = "BasicsFooterView"
  @IBOutlet weak var titleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    titleLabel.textColor = UIColor.gray
    titleLabel.font = UIFont.systemFont(ofSize: 14)
  }
}

