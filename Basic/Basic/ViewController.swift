//
//  ViewController.swift
//  Basic
//
//  Created by 杜哲 on 2018/11/18.
//  Copyright © 2018 duzhe. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let backColor = UIColor.init(red:0x96/255 , green: 0x27/255, blue: 0x30/255, alpha: 1)
    view.backgroundColor = backColor
    collectionView.backgroundColor = backColor
    collectionView.dataSource = self
  }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
}

