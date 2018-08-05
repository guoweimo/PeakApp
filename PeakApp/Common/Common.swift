//
//  Common.swift
//  PeakApp
//
//  Created by Guowei Mo on 17/12/2017.
//  Copyright © 2017 Guowei Mo. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
  public func hideAllLayers() {
    for l in sublayers ?? [] {
      l.isHidden = true
    }
  }
}
