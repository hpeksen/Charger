//
//  LoginModel.swift
//  Charger
//
//  Created by Hakan Pekşen on 6.07.2022.
//

import Foundation
import UIKit
class LoginModel{
    
    func loginPostRequest(email: String, completion: @escaping (Result<Int, Error>) -> Void){
        
        
        // declare the parameter as a dictionary that contains string as key and value combination. considering inputs are valid
        let parameters: [String: Any] = ["email": email, "deviceUDID": "\(String(describing: UIDevice.current.identifierForVendor))"]
        
        // create the url with URL
        let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/auth/login")!
        
        // create the session object
        let session = URLSession.shared
        
        // now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        // add headers for the request
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // change as per server requirements
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
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
                let user = try JSONDecoder().decode(User.self, from: responseData)
                completion(.success(httpResponse.statusCode))
                print("\(String(describing: user.email))")
                print("\(String(describing: user.token))")
                print("\(String(describing: user.userId))")
                //ProjectRepository.user = user
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        // perform the task
        task.resume()
    }
}
