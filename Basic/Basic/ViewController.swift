//
//  ViewController.swift
//  Basic
//
//  Created by 杜哲 on 2018/11/18.
//  Copyright © 2018 duzhe. All rights reserved.
//

import UIKit


//http://upload.newhua.com/2012/0326/thumb_900_600_1332742739176.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742743531.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742747590.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742752397.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742755118.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742760658.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742764319.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742768877.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742773367.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742777207.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742782783.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742787628.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742791649.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742796725.jpg
//http://upload.newhua.com/2012/0326/1332742800347.jpg
//http://upload.newhua.com/2012/0326/1332742804889.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742808493.jpg
//http://upload.newhua.com/2012/0326/1332742813650.jpg
//http://upload.newhua.com/2012/0326/1332742817392.jpg
//http://upload.newhua.com/2012/0326/1332742821408.jpg
//http://upload.newhua.com/2012/0326/1332742830102.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742835642.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742839816.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742845563.jpg
//http://upload.newhua.com/2012/0326/1332742850401.jpg
//http://upload.newhua.com/2012/0326/thumb_900_600_1332742855719.jpg
//http://upload.newhua.com/2012/0326/1332742860853.jpg
//http://upload.newhua.com/2012/0326/1332742864897.jpg

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

