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


func CLEAR_PAGE_LOADING_AND_TOASTS(viewcontroller:UIViewController) {
    viewcontroller.view.hideAllToasts()
}
