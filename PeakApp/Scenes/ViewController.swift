import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var radarParentView: UIView!
  @IBOutlet weak var topBar: UINavigationBar!
  
  var chartData: ChartData!
  
  var chartView : ChartView!
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    topBar.setBackgroundImage(UIImage(), for: .default)
    topBar.shadowImage = UIImage()
    
    chartData = ChartData(categories: [
      ("Memory", UIColor.peakOrange),
      ("Problem Solving", UIColor.peakGreen),
      ("Language", UIColor.peakPurple),
      ("Mental Agility", UIColor.peakBlue2),
      ("Focus", UIColor.peakPink),
//      ("Focus", UIColor.peakPink) //add new category 
      ])
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let chartView = ChartView(frame: radarParentView.bounds, data: chartData)
    radarParentView.addSubview(chartView)
    self.chartView = chartView
  }
  
  @IBAction func tabIndexDidchange(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case 0:
      chartView.displayDefaultView()
    case 1:
      chartView.displayExtraAgeView()
    case 2:
      chartView.displayExtraProfessionView()
    default:
      chartView.displayDefaultView()
    }
  }
}

