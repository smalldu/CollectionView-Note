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
  
  let randomText = "黑发不知勤学早白首方悔读书迟迟日江山丽春风花草香杜甫绝句春色满园关不住一枝红杏出墙来叶绍翁游园不值好雨知时节当春乃发生杜甫春雨夏天小荷才露尖尖角早有蜻蜓立上头杨万里小池接天莲叶无穷碧映日荷花别样红"
  
  private func genernalText() -> String{
    let textCount = randomText.count
    let randomIndex = arc4random_uniform(UInt32(textCount))
    let start = max(0, Int(randomIndex)-7)
    let startIndex = randomText.startIndex
    let step = arc4random_uniform(5) + 2 // 2到5个字
    let startTextIndex = randomText.index(startIndex, offsetBy: start)
    print("start : \(start) , step: \(step)")
    let endTexIndex = randomText.index(startIndex, offsetBy: start + Int(step))
    let text = String(randomText[startTextIndex ..< endTexIndex])
    print(text)
    return text
  }
  
  func generalTags() -> [[String]]{
    var tags1: [String] = []
    var tags2: [String] = []
    var tags3: [String] = []
    
    for i in 0..<100 {
      if i%3 == 0 {
        tags1.append( genernalText() )
      }
      if i%2 == 0{
        tags2.append(genernalText())
      }
      tags3.append(genernalText())
    }
    return [tags1,tags2,tags3]
  }
  
}





