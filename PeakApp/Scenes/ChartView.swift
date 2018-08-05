import UIKit

class ChartView: UIView {
  
  var itemLabels = [UILabel]()
  var numberLabels = [UILabel]()
  var centerX: CGFloat {
    get {
      return bounds.midX
    }
  }
  
  var centerY: CGFloat {
    get {
      return bounds.midY
    }
  }
  
  var data: ChartData!
  var ageLayer: CAShapeLayer?
  var profLayer: CAShapeLayer?

  init(frame: CGRect, data: ChartData) {
    super.init(frame: frame)
    backgroundColor = UIColor.clear
    self.data = data
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configView() {
    if let categories = data.categories {
      addCategoryLabels(with: categories.map { return $0.name })
      addSmallCircles(with: categories.map { return $0.color })
    }
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    let numbers = data.defaultNumbers
    addNumberLabels(with: numbers)
    configView()
    addCircles()
    addAxis()
    addDataGraph(with: numbers)
  }
  
  private func addCircles() {
    for i in 2...10 {
      let strokeColor = i % 2 == 0 ? UIColor.peakExtraLightGreyLine : UIColor.peakLightGrey
      drawFullCircle(with: centerX, yCenter: centerY, radius: CGFloat(i * 10), and: strokeColor)
    }
  }
  
  private func addCategoryLabels(with names: [String]) {
    for name in names {
      let itemLabel = TitleLabel(frame: CGRect.zero)
      itemLabel.text = NSLocalizedString(name, comment: "")
      itemLabel.frame.size.width = itemLabel.intrinsicContentSize.width
      itemLabels.append(itemLabel)
      addSubview(itemLabel)
    }
  }
  
  private func addNumberLabels(with numbers: [Int]) {
    for number in numbers {
      let numberLabel = NumberLabel(frame: CGRect.zero)
      numberLabel.text = String(number)
      numberLabels.append(numberLabel)
      addSubview(numberLabel)
    }
  }
  
  private func addAxis(){
    for i in 0..<data.categories.count {
      let path = UIBezierPath()
      UIColor.lightGray.setStroke()
      path.lineWidth = 1.0
      path.move(to: CGPoint(x: centerX, y: centerY))
      
      let lineEndX = xPosFromCenter(with: i, and: 110.0)
      let lineEndY = yPosFromCenter(with: i, and: 110.0)
      path.addLine(to: CGPoint(x: lineEndX, y: lineEndY))
      path.stroke()
      
      updateLabelsPos(at: i, baseX: lineEndX, baseY: lineEndY)
    }
  }
  
  private func updateLabelsPos(at i:Int, baseX lineEndX:CGFloat, baseY lineEndY: CGFloat) {
    let labelCenterX = lineEndX
    let labelCenterY = lineEndY < centerY ? lineEndY - 40 : lineEndY + 20
    itemLabels[i].center = CGPoint(x: labelCenterX, y: labelCenterY)
    
    let numberCenterX = lineEndX
    let numberCenterY = lineEndY < centerY ? lineEndY - 20 : lineEndY + 40
    numberLabels[i].center = CGPoint(x: numberCenterX, y: numberCenterY)
  }
  
  private func addSmallCircles(with colors: [UIColor]) {
    for i in 0..<data.categories.count {
      let smallCircleCenterX = xPosFromCenter(with: i, and: 115.0)
      let smallCircleCenterY = yPosFromCenter(with: i, and: 115.0)
      drawFullCircle(with: smallCircleCenterX, yCenter: smallCircleCenterY, radius: 5, and: colors[i])
    }
  }
  
  func displayDefaultView() {
    layer.hideAllLayers()
  }
  
  func displayExtraAgeView() {
    let numbers = data.ageNumbers
    displayGraphLayer(with: numbers, color: UIColor.peakRed, shapeLayer: ageLayer)
  }
  
  func displayExtraProfessionView() {
    let numbers = data.professionNumbers
    displayGraphLayer(with: numbers, color: UIColor.peakPurple, shapeLayer: profLayer)
  }
  
  func displayGraphLayer(with numbers: [Int], color: UIColor, shapeLayer: CAShapeLayer?) {
    layer.hideAllLayers()
    if let shapeLayer = shapeLayer {
      shapeLayer.isHidden = false
    }
    else if let path3 = addDataGraph(with: numbers) {
      let shape = CAShapeLayer()
      shape.path = path3.cgPath
      shape.fillColor = color.cgColor
      layer.addSublayer(shape)
    }
  }
  
  private func xPosFromCenter(with radius: Int, and multiplier: CGFloat) -> CGFloat {
    return sin(CGFloat(radius * 2) / CGFloat(data.categories.count) * CGFloat.pi) * multiplier + centerX
  }
  
  private func yPosFromCenter(with radius: Int, and multiplier: CGFloat) -> CGFloat {
    return centerY - cos(CGFloat(radius * 2) / CGFloat(data.categories.count) * CGFloat.pi) * multiplier
  }
  
  private func drawFullCircle(with xCenter: CGFloat, yCenter: CGFloat, radius: CGFloat, and strokeColor: UIColor) {
    let path2 = UIBezierPath()
    strokeColor.setStroke()
    path2.lineWidth = 1.0
    path2.addArc(withCenter: CGPoint(x: xCenter, y: yCenter), radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
    path2.stroke()
  }
  
  private func addDataGraph(with numbers: [Int], color: UIColor = UIColor.peakExtraLightGreyArea) -> UIBezierPath? {
    let path3 = UIBezierPath()
    color.setFill()
    for i in 0..<data.categories.count {
      let fig = CGFloat(numbers[i]) / 10
      let dataPointX = xPosFromCenter(with: i, and: fig)
      let dataPointY = yPosFromCenter(with: i, and: fig)
      
      if i == 0 {
        path3.move(to: CGPoint(x: dataPointX, y: dataPointY))
      }
      
      if(i > 0) {
        path3.addLine(to: CGPoint(x: dataPointX, y: dataPointY))
      }
      if i == data.categories.count - 1 {
        path3.close()
        path3.fill()
      }
    }
    return path3
  }
}
