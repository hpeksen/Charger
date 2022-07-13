//
//  ViewController.swift
//  Charger
//
//  Created by Hakan Pekşen on 3.07.2022.
//

import UIKit
import CoreLocation

class LoginViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    private var viewModel = LoginViewModel()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if(manager.authorizationStatus == .denied){
            let alertController = self.viewModel.showAlert(title: "Lokasyon İzni", message: "Lokasyon izni gerekmektedir", cancelButtonTitle: "Vazgeç", defaultButtonTitle: "Ayarları aç") { action in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            present(alertController, animated: true)
        }
    }
    @IBAction func btnSignIn(_ sender: Any) {
        viewModel.pressLoginButton(txtEmail.text!,self.navigationController!)
        
    }
   
}

