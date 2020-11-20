//
//  CollectionViewCell.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 15.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  
  private let cache = NSCache<NSNumber, UIImage>()
  
  lazy var imageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.layer.masksToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imageView)
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
      imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
