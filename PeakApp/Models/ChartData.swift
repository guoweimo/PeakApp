
import Foundation
import UIKit

typealias Category = (name: String, color: UIColor)

class ChartData {
  
  let categories: [Category]!
  var defaultNumbers: [Int] = [876, 600, 512, 924, 700]
  var ageNumbers: [Int] = [300, 456, 670, 700, 635]
  var professionNumbers: [Int] = [770, 500, 456, 670, 700]
  init(categories: [Category]) {
    self.categories = categories
  }
}
