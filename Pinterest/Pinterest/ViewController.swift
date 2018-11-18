//
//  ViewController.swift
//  Pinterest
//
//  Created by 杜哲 on 2018/11/18.
//  Copyright © 2018 duzhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  let items: [UIColor] = [.red, .black , .yellow , .blue , .green , .brown , .gray ,.red, .black , .yellow , .blue , .green , .brown , .gray ,.red, .black , .yellow , .blue , .green , .brown , .gray ,.red, .black , .yellow , .blue , .green , .brown , .gray ]
  var layout: PinterestLayout? {
    return collectionView.collectionViewLayout as? PinterestLayout
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layout?.delegate = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.dataSource = self
  }
  
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = items[indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
}


// MARK: - PinterestLayoutDelegate

extension ViewController: PinterestLayoutDelegate {
  
  func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
    let random = arc4random_uniform(4) + 1
    return CGFloat(random * 100)
  }
  
}





