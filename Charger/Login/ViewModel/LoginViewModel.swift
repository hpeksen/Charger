//
//  LoginViewModel.swift
//  Charger
//
//  Created by Hakan Pekşen on 3.07.2022.
//

import Foundation
import UIKit
private var model = LoginModel()
class LoginViewModel {
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
                print(err)
            }
        }
    }
}
