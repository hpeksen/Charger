//
//  ViewController.swift
//  Charger
//
//  Created by Hakan Pekşen on 3.07.2022.
//

import UIKit
import CoreLocation

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    private var viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSignIn(_ sender: Any) {
        viewModel.pressLoginButton(txtEmail.text!,self.navigationController!)
        
    }
   
}

