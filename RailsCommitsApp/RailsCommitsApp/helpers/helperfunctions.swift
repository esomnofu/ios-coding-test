import UIKit
import Alamofire
import Toast_Swift


func regularGetRequest(apiUrl:String, completion: @escaping (Any) -> (), errorCompletion: @escaping (Any) -> () ){
    Alamofire.request(apiUrl, method: .get).responseJSON  { response in
        if let result = response.result.value {
            completion(result)
        }else{
            errorCompletion(response)
        }
    }
}



func handlePoorNetworkConnection(message:String=GENERIC_ERROR_MESSAGE_WITH_RETRY, completion: @escaping () -> (), selfView:UIViewController ) {
    
    selfView.view.makeToast(message, duration: NETWORK_ERROR_TIME, position: .bottom, style: style){ didTap in
        if didTap {
            completion()
        } else {
            print("completion without tap")
        }
    }
}



func ADD_PAGE_LOADING(viewcontroller:UIViewController, completion: @escaping () -> () ) {
    viewcontroller.view.hideAllToasts()
    let resultingView = UIActivityIndicatorView.startLoading()
    resultingView.center = viewcontroller.self.view.center;
    viewcontroller.view.addSubview(resultingView)
    completion()
}


func CLEAR_PAGE_LOADING_AND_TOASTS(viewcontroller:UIViewController) {
    viewcontroller.view.hideAllToasts()
    UIActivityIndicatorView.stopLoading()
}


func START_PAGE_LOADING(viewcontroller: UIViewController){
    viewcontroller.view.hideAllToasts()
    let resultingView = UIActivityIndicatorView.startLoading()
    resultingView.center = viewcontroller.self.view.center;
    viewcontroller.view.addSubview(resultingView)
}

func STOP_PAGE_LOADING(){
    UIActivityIndicatorView.stopLoading()
}
extension UIAlertController {
    
    static func alert(title:String, message:String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
}


extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop : CGFloat, paddingLeft : CGFloat, paddingBottom : CGFloat, paddingRight: CGFloat, height : CGFloat, width : CGFloat) {
        
        //self.translatesAutoresizingMaskIntoConstraints = false
        //self is optional
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant : paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        
    }
    
    
}
