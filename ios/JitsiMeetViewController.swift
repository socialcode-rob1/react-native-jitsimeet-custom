import UIKit
import JitsiMeetSDK

class JitsiMeetViewController: UIViewController {
  var conferenceOptions: JitsiMeetConferenceOptions?
  var resolver: RCTPromiseResolveBlock?
  var jitsiMeetView = JitsiMeetView()

  override func viewDidLoad() {
    super.viewDidLoad()
    jitsiMeetView.join(conferenceOptions)
    jitsiMeetView.delegate = self

    jitsiMeetView.frame = CGRect.init(x: 0, y: 44, width: self.view.frame.width, height: self.view.frame.height - 78)
    self.view.addSubview(jitsiMeetView)
  }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}

extension JitsiMeetViewController: JitsiMeetViewDelegate {
  func ready(toClose data: [AnyHashable : Any]!) {
    DispatchQueue.main.async {
        let rootViewController = UIApplication.shared.delegate?.window??.rootViewController as! UINavigationController
        rootViewController.popViewController(animated: false)
    }
      
    if ((resolver) != nil) {
      resolver!([])
    }
  }
}
