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
      
    NotificationCenter.default.addObserver(self, selector: #selector(onOrientationChange), name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)

    onOrientationChange()
    self.view.addSubview(jitsiMeetView)
  }
    
    @objc func onOrientationChange() {
        let isPortrait = UIApplication.shared.statusBarOrientation.isPortrait
        jitsiMeetView.frame = CGRect.init(x: 0, y: isPortrait ? 44 : 0, width: self.view.frame.width, height: self.view.frame.height - ( isPortrait ? 78 : 34 ))
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
