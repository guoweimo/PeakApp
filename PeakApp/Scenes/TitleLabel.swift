//
//  TitleLabel.swift
//  PeakApp
//
//  Created by Guowei Mo on 17/12/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
    textColor = UIColor.lightGray
    textAlignment = .center
    font = Style.appFont(type: .light, size: 14)
    defer {
      self.frame.size.height = 18
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
