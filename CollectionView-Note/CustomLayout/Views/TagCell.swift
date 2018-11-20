//
//  TagCell.swift
//  CollectionView-Note
//
//  Created by zuber on 2018/11/20.
//  Copyright © 2018年 zuber. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
  
  static let reuseID = "tagCell"
  
  @IBOutlet weak var tagLabel: UILabel!
  
  var value: String = "" {
    didSet{
      tagLabel.text = value
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = UIColor.randomColor()
    tagLabel.font = UIFont.systemFont(ofSize: 12)
    tagLabel.textColor = UIColor.white
  }
  
}
