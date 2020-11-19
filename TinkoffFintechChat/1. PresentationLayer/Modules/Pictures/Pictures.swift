//
//  Pictures.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 15.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class PicturesiewController: UIViewController, ModelDelegate {
  
  var myCollectionView: UICollectionView?
  
  var model: PicturesModelProtocol
  var dataSource: [URL]?
  var images: [UIImage]?
  
  // MARK: init
  init(model: PicturesModelProtocol) {
    self.model = model
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let view = UIView()
    view.backgroundColor = .white
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    myCollectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
    myCollectionView?.backgroundColor = UIColor.white
    
    view.addSubview(myCollectionView ?? UICollectionView())
    
    self.view = view
    
    myCollectionView?.dataSource = self
    myCollectionView?.delegate = self
    
//    model.send()
    
  }
  
  // MARK: - ModelDelegate
  
  func setup(dataSource: [URL]) {
    self.dataSource = dataSource
//    DispatchQueue.global().async {
//      self.myCollectionView?.reloadData()
//    }
    
  }
  
  fileprivate let sectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
  fileprivate let itemsPerRow: CGFloat = 3
}

extension PicturesiewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    print(dataSource?.count)
    return 100
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
            myCell.backgroundColor = UIColor.blue
//    myCell.set(image: UIImage().loadImage(url: dataSource[indexPath.row]))
//    myCell.url = dataSource[indexPath.row]
//    let image =
//    myCell.image.load(url: dataSource[indexPath.row])
    return myCell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let widthItem = view.frame.width / 3 - 10
    return CGSize(width: widthItem, height: widthItem)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
}

extension PicturesiewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("User tapped on item \(indexPath.row)")
  }
}

extension UIImageView {
  func load(url: URL) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}
