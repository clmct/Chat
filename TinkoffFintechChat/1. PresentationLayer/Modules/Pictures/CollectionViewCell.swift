//
//  CollectionViewCell.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 15.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
  var url: URL?
  
  var imageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFit
//    if let url = self.url {
//      image.load(url: url)
//    } else {
      image.image = UIImage()
//    }
    image.backgroundColor = .red
    image.translatesAutoresizingMaskIntoConstraints = true
    return image
  }()
  
  func set(image: UIImage) {
    self.imageView.image = image
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .red
    contentView.addSubview(imageView)
    NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: self.topAnchor),
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
