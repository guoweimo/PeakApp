//
//  File.swift
//  PeakDemo
//
//  Created by Guowei Mo on 13/12/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import Foundation
import UIKit

class Style {
  enum FontType: String {
    case light = "Light"
    case medium = "Medium"
  }
  
  class func appFont(type: FontType, size: CGFloat) -> UIFont
  {
    let name = "GothamSSm-\(type.rawValue)"
    return UIFont(name: name, size: size)!
  }
}
