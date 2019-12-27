
import UIKit


let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();
let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 40, height: 50))


let aview : UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white
    view.layer.cornerRadius = 5
    view.clipsToBounds = true
    view.isOpaque = false
    return view
}()

extension UIActivityIndicatorView {
    
    static func startLoading() -> UIView {
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = UIColor.green
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.startAnimating();
        aview.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        aview.addSubview(activityIndicator)
        activityIndicator.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 100, width: 100)
        activityIndicator.centerXAnchor.constraint(equalTo: aview.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: aview.centerYAnchor).isActive = true
        //UIApplication.shared.beginIgnoringInteractionEvents();
        return aview
    }
    
    static func stopLoading(){
        activityIndicator.stopAnimating();
        aview.removeFromSuperview()
        //UIApplication.shared.endIgnoringInteractionEvents();
    }
}


