//
//  BasicsVIewController02.swift
//  CollectionView-Note
//
//  Created by zuber on 2018/11/19.
//  Copyright © 2018年 zuber. All rights reserved.
//


import UIKit

class BasicsViewController02: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var flowLayout: UICollectionViewFlowLayout? {
    return collectionView.collectionViewLayout as? UICollectionViewFlowLayout
  }
  
  var colors: [[UIColor]] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    
    collectionView.register(UINib(nibName: "BasicsHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: BasicsHeaderView.reuseID)
    collectionView.register(UINib(nibName: "BasicsFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: BasicsFooterView.reuseID)
    
    colors.append(DataManager.shared.generalColors(5))
    colors.append(DataManager.shared.generalColors(3))
    colors.append(DataManager.shared.generalColors(4))
    
    let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(_:)))
    collectionView.addGestureRecognizer(longGesture)
  }
  
  @objc
  func longPressed(_ gesture: UILongPressGestureRecognizer) {
    let position = gesture.location(in: collectionView)
    switch gesture.state {
    case .began:
      if let indexPath = collectionView.indexPathForItem(at: position) {
        collectionView.beginInteractiveMovementForItem(at: indexPath)
      }
    case .changed:
      collectionView.updateInteractiveMovementTargetPosition(position)
    case .ended:
      collectionView.endInteractiveMovement()
    default:
      collectionView.cancelInteractiveMovement()
    }
  }
  
}

// MARK: - UICollectionViewDataSource

extension BasicsViewController02: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return colors.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return colors[section].count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicsCell.reuseID, for: indexPath) as! BasicsCell
    cell.backgroundColor = colors[indexPath.section][indexPath.row]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BasicsHeaderView.reuseID, for: indexPath) as! BasicsHeaderView
      view.titleLabel.text = "HEADER -- \(indexPath.section)"
      return view
    case UICollectionView.elementKindSectionFooter:
      let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BasicsFooterView.reuseID, for: indexPath) as! BasicsFooterView
      view.titleLabel.text = "FOOTER -- \(indexPath.section)"
      return view
    default:
      fatalError("No such kind")
    }
  }
  
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BasicsViewController02: UICollectionViewDelegateFlowLayout {
  
  // 设置itemsize
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.section == 0 {
      let itemWidth = (view.bounds.width - 4)/3
      return CGSize(width: itemWidth, height: itemWidth)
    }else if indexPath.section == 1 {
      return CGSize(width: view.bounds.width, height: 50)
    }else {
      let itemWidth = (view.bounds.width - 15)/2
      return CGSize(width: itemWidth, height: itemWidth)
    }
  }
  // 设置sectionInset
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if section == 0{
      return UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    }else if section == 1{
      return .zero
    }else{
      return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
  }
  // 设置 minimumLineSpacing
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    if section == 0{
      return 1
    }else if section == 1{
      return 2
    }else{
      return 5
    }
  }
  // 设置 minimumInteritemSpacing
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    if section == 0{
      return 1
    }else if section == 1{
      return 2
    }else{
      return 5
    }
  }
  // 设置header size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let width = view.bounds.width
    if section == 0{
      return CGSize(width: width, height: 30)
    }else if section == 1{
      return CGSize(width: width, height: 50)
    }else{
      return CGSize(width: width, height: 70)
    }
  }
  
  // 设置footer size
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    let width = view.bounds.width
    return CGSize(width: width, height: 20)
  }
  
//  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//    guard let cell = collectionView.cellForItem(at: indexPath) else {
//      return
//    }
//    UIView.animate(withDuration: 0.1) {
//      cell.transform = CGAffineTransform.identity.scaledBy(x: 0.8, y: 0.8)
//    }
//  }
//  func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//    guard let cell = collectionView.cellForItem(at: indexPath) else {
//      return
//    }
//    UIView.animate(withDuration: 0.1) {
//      cell.transform = CGAffineTransform.identity
//    }
//  }

  func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    // 修改数据源
    let removedColor = self.colors[sourceIndexPath.section][sourceIndexPath.row]
    self.colors[sourceIndexPath.section].remove(at: sourceIndexPath.row)
    self.colors[destinationIndexPath.section].insert(removedColor, at: destinationIndexPath.row)
  }
  
}

