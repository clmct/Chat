//
//  Pictures.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 15.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class PicturesiewController: UIViewController, ModelDelegate {
  
  weak var vc: ProfileViewController?
  private var myCollectionView: UICollectionView?
  private let reuseIdentifier = "CellPhoto"
  private var model: PicturesModelProtocol
  private var dataSource: [URL]?
  private var images: [UIImage]?
  private let sectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
  private let itemsPerRow: CGFloat = 3
  private let cache = NSCache<NSNumber, UIImage>()
  
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
    setup()
  }
  
  private func setup() {
    setupLayout()
    model.send()
  }
  
  private func setupLayout() {
    let view = UIView()
    view.backgroundColor = .white
    self.view = view
    setupCollectionView()
  }
  
  private func setupCollectionView() {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    myCollectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    myCollectionView?.backgroundColor = UIColor.white
    view.addSubview(myCollectionView ?? UICollectionView())
    myCollectionView?.dataSource = self
    myCollectionView?.delegate = self
  }
  
  // MARK: - ModelDelegate
  
  func setup(dataSource: [URL]) {
    self.dataSource = dataSource
    self.myCollectionView?.reloadData()
  }
}

extension PicturesiewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource?.count ?? 0
  }
  
  func set(url: URL, index: NSNumber) {

  }
  
  private func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
    DispatchQueue.global().async {
      guard let data = try? Data(contentsOf: url) else { return }
      let image = UIImage(data: data)
      DispatchQueue.main.async {
        completion(image)
      }
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell else {
      return UICollectionViewCell()
    }
      
    if let data = dataSource {
      let url = data[indexPath.row]
      let index = NSNumber(value: indexPath.row)
      
      if let cachedImage = self.cache.object(forKey: index) {
        cell.imageView.image = cachedImage
      } else {
        cell.imageView.image = UIImage(named: "image")
        self.loadImage(url: url) { [weak self] (image) in
          guard let self = self, let image = image else { return }
          cell.imageView.image = image
          self.cache.setObject(image, forKey: index)
        }
      }
    }
    
    return cell
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

    if let cachedImage = self.cache.object(forKey: NSNumber(value: indexPath.row)) {
      vc?.imageViewOutlet.image = cachedImage
      dismiss(animated: true, completion: nil)
    }
  }
}
