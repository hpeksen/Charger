//
//  AppointmentDetailViewController.swift
//  Charger
//
//  Created by Hakan Pekşen on 17.07.2022.
//

import UIKit

class AppointmentDetailViewController: UIViewController {
    var models: AppointmentData.Appointment?
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func confirmApointment(_ sender: Any) {
        getCityRequest() {  code in
            switch code{
            case .success(let code):
                if(code == 200){
                    DispatchQueue.main.async {
                        
                    }
                }
            case .failure(let err):
                print(err)
            }
        }
        
    }
    
    func getCityRequest( completion: @escaping (Result<Int, Error>) -> Void){
        var userId:Int
        userId = UserDefaults.standard.object(forKey: "userID") as! Int
        var token:String!
        token = UserDefaults.standard.object(forKey: "token") as? String
        
        // declare the parameter as a dictionary that contains string as key and value combination. considering inputs are valid
        let parameters: [String: Any] = ["stationID": 7,"socketID": 14,"timeSlot": "19:00","appointmentDate": "2022-06-20"]
        
        let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/appointments/make?userID=\(String(describing: userId))&date=2022-11-30&userLatitude=39.925058&userLongitude=32.836860")!
        // create the session object
        let session = URLSession.shared
        // now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        // add headers for the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(token!, forHTTPHeaderField: "token")
       
        
        do {
            // convert parameters to Data and assign dictionary to httpBody of request
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        // create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                return
            }
            // ensure there is valid response code returned from this HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                print("Invalid Response received from the server")
                return
            }
            // ensure there is data returned
            guard let responseData = data else {
                print("nil Data received from the server")
                return
            }
            do {
                // create json object from data or use JSONDecoder to convert to Model stuct
                let socketData = try JSONDecoder().decode(AppointmentData.Appointment.self, from: responseData)
                completion(.success(httpResponse.statusCode))
                self.models = socketData
            
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        // perform the task
        task.resume()
    }
}
