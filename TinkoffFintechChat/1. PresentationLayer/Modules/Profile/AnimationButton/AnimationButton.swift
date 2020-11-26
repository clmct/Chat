//
//  AnimationButton.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 26.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class AnimationButton {
  
  private var x: CGFloat = 0.0
  private var y: CGFloat = 0.0
  private var z: CGFloat = 0.0
  
  private var button: UIButton
  
  private var isAmimated = false
  
  init(button: UIButton) {
    self.button = button
    self.x = button.layer.position.x
    self.y = button.layer.position.y
    self.z = button.layer.zPosition
  }
  
  private lazy var rotation: CAKeyframeAnimation = {
    var wobble = CAKeyframeAnimation(keyPath: "transform.rotation")
    wobble.values = [0.0, -.pi / 10.0, 0, .pi / 10.0, 0.0]
    wobble.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
    return wobble
  }()
  
  private lazy var positionX: CAKeyframeAnimation = {
    var posx = CAKeyframeAnimation(keyPath: "position.x")
    posx.values = [x, x - 5.0, x, x + 5.0, x]
    posx.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
    return posx
  }()
  
  private lazy var positionY: CAKeyframeAnimation = {
    var posy = CAKeyframeAnimation(keyPath: "position.y")
    posy.values = [y, y + 5.0, y, y - 5.0, y]
    posy.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
    return posy
  }()
  
  private lazy var group: CAAnimationGroup = {
    var group = CAAnimationGroup()
    group.duration = 0.3
    group.repeatCount = .infinity
    group.animations = [rotation, positionX, positionY]
    return group
  }()
  
  public func animationToogle() {
    if !isAmimated {
      button.layer.add(group, forKey: "group")
      isAmimated.toggle()
    } else {
      button.layer.removeAllAnimations()
      isAmimated.toggle()
    }
  }
  
}
