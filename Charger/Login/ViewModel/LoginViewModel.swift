//
//  LoginViewModel.swift
//  Charger
//
//  Created by Hakan Pekşen on 3.07.2022.
//

import Foundation
import UIKit
private var model = LoginModel()
class LoginViewModel:UIViewController {
    func pressLoginButton(_ eMail: String, _ navigationController: UINavigationController){
     getData(eMail, navigationController)
}
    private func getData (_ email: String, _ navigationController: UINavigationController){
        model.loginPostRequest(email: email) {  code in
            switch code{
            case .success(let code):
                if(code == 200){
                    DispatchQueue.main.async {
                        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
                            navigationController.pushViewController(vc, animated: true)
                        }
                    }
                }
            case .failure(let err):
                print("ERROR: \(err.localizedDescription)")
                // create the alert
                let alert = UIAlertController(title: "UIAlertController", message: err.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
                       
                
             }
        }
    }
    
    func showAlert(title: String, message: String?, preferredStyle: UIAlertController.Style = .alert,
                   cancelButtonTitle:String?, defaultButtonTitle: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController{
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if defaultButtonTitle != nil {
            let defaultButton = UIAlertAction(title: defaultButtonTitle, style: .default, handler: handler)
            alertController.addAction(defaultButton)
        }
        
        if cancelButtonTitle != nil {
            let cancelButton = UIAlertAction(title: cancelButtonTitle, style: .cancel)
            alertController.addAction(cancelButton)
        }
        
        return alertController
    }
}
