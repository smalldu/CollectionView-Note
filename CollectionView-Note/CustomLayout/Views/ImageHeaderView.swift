//
//  ImageHeaderView.swift
//  CollectionView-Note
//
//  Created by zuber on 2018/11/20.
//  Copyright © 2018年 zuber. All rights reserved.
//

import UIKit

class ImageHeaderView: UICollectionReusableView {
  
  static let reuseID = "ImageHeaderView"
  
  @IBOutlet weak var imageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
  }
  
}

