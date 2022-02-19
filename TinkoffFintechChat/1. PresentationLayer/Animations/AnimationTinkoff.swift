//
//  AnimationTinkoff.swift
//  TinkoffFintechChat
//
//  Created by Алмат Кульбаев on 26.11.2020.
//  Copyright © 2020 Алмат Кульбаев. All rights reserved.
//

import UIKit

class AnimationTinkoff {
  
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  lazy var snowCell: CAEmitterCell = {
    var cell = CAEmitterCell()
    cell.contents = UIImage(named: "tinkoff")?.cgImage
    
    cell.scale = 0.04
    cell.scaleRange = 0
    cell.scaleSpeed = 0.02
    cell.emissionRange = CGFloat.pi * 2
    cell.lifetime = 3.0
    cell.lifetimeRange = 1
    cell.birthRate = 15
    cell.velocity = -30
    cell.velocityRange = -20
    cell.alphaSpeed = -0.4
    cell.yAcceleration = 70
    cell.xAcceleration = 10
    cell.zAcceleration = 30
    cell.spin = 1
    cell.spinRange = 2
    
    return cell
  }()
  
  lazy var layer: CAEmitterLayer = {
    let layer = CAEmitterLayer()
    layer.emitterPosition = CGPoint(x: window.bounds.width / 2.0, y: 200)
    layer.emitterSize = CGSize(width: 100, height: 100)
    layer.emitterShape = .circle
    layer.beginTime = CACurrentMediaTime()
    layer.emitterCells = [snowCell]
    layer.lifetime = 0
    self.window.layer.addSublayer(layer)
    return layer
  }()
  
  public func animate(gesture: UILongPressGestureRecognizer) {

    let state = gesture.state
    let location = gesture.location(in: window)
    self.layer.emitterPosition = CGPoint(x: location.x, y: location.y )
    
    switch state {
    case .began:
      layer.lifetime = 1
    case .changed:
      layer.lifetime = 1
    default:
      layer.lifetime = 0
    }
    
  }
  
}
