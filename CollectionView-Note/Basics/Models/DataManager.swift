//
//  DataManager.swift
//  CollectionView-Note
//
//  Created by zuber on 2018/11/19.
//  Copyright © 2018年 zuber. All rights reserved.
//

import UIKit

extension UIColor {
  
  static func randomColor() -> UIColor{
    let red = CGFloat(arc4random_uniform(255) + 1)
    let green = CGFloat(arc4random_uniform(255) + 1)
    let blue = CGFloat(arc4random_uniform(255) + 1)
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
  }
  
}


class DataManager {
  
  static let shared = DataManager()
  
  func generalColors(_ count: Int) -> [UIColor] {
    var colors = [UIColor]()
    for _ in 0..<count{
      colors.append(UIColor.randomColor())
    }
    return colors
  }
  
}





