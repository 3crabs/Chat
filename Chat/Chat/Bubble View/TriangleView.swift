//
//  TriangleView.swift
//  Chat
//
//  Created by Maxim Butin on 18.06.2021.
//

import UIKit

class TriangleView: UIView {

  private var path: UIBezierPath!
  var isIncoming: Bool!

  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .brown
    
    widthAnchor.constraint(equalToConstant: 10).isActive = true
    heightAnchor.constraint(equalToConstant: 10).isActive = true
  }

  private func createTriangle() {
    path = UIBezierPath()
    if isIncoming {
      path.move(to: CGPoint(x: 0, y: frame.width / 2))
      path.addLine(to: CGPoint(x: frame.height, y: frame.width))
      path.addLine(to: CGPoint(x: frame.height, y: 0))
    } else {
      path.move(to: CGPoint(x: frame.height, y: frame.width / 2))
      path.addLine(to: CGPoint(x: 0, y: 0))
      path.addLine(to: CGPoint(x: 0, y: frame.height))
    }
    path.close()
  }

  override func draw(_ rect: CGRect) {
    createTriangle()
    isIncoming ? UIColor.white.setFill() : UIColor.systemOrange.setFill()
    path.fill()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

