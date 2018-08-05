//
//  NumberLabel.swift
//  PeakApp
//
//  Created by Guowei Mo on 17/12/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import UIKit

class NumberLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    textColor = UIColor.white
    textAlignment = .center
    font = Style.appFont(type: .medium, size: 14)
    defer {
      self.frame.size.width = 50
      self.frame.size.height = 14
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
}
