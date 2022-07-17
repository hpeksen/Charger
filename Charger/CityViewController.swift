//
//  CityViewController.swift
//  Charger
//
//  Created by Hakan Pekşen on 6.07.2022.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet weak var tableViewCity: UITableView!
    @IBOutlet weak var txtSearchCity: UISearchBar!
    var selectedCity: String = ""
    var searchCities : [String] = []
    var models: [String] = []
    var allStationModels : [AllStation] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCity.delegate = self
        tableViewCity.dataSource = self
        searchCities = models
        
        
        getCityRequest() {  code in
            switch code{
            case .success(let code):
                if(code == 200){
                    DispatchQueue.main.async {
                        self.searchCities = self.models
                        self.tableViewCity.reloadData()
                    }
                }
            case .failure(let err):
                print(err)
            }
        }
        
        
        getAllStations() {  code in
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
    func goDetail(city: String) {
        selectedCity = city
        performSegue(withIdentifier: "stationSelection", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "stationSelection" {
               let detailVC = segue.destination as! StationViewController
               detailVC.selectedCity = selectedCity
           }
       }
    
    func getAllStations( completion: @escaping (Result<Int, Error>) -> Void){
        var userId:Int
        userId = UserDefaults.standard.object(forKey: "userID") as! Int
        var token:String!
        token = UserDefaults.standard.object(forKey: "token") as? String
        
        let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/stations?userID=\(String(describing: userId))")!
        // create the session object
        let session = URLSession.shared
        
        // now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as GET

        request.addValue(token!, forHTTPHeaderField: "token")
       
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
                let allStation = try JSONDecoder().decode(AllStation.self, from: responseData)
                completion(.success(httpResponse.statusCode))
                //self.allStation = allStation.station
                print("\(allStation)")
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        // perform the task
        task.resume()
    
    }
    
    func getCityRequest( completion: @escaping (Result<Int, Error>) -> Void){
        var userId:Int
        userId = UserDefaults.standard.object(forKey: "userID") as! Int
        var token:String!
        token = UserDefaults.standard.object(forKey: "token") as? String
        let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/provinces?userID=\(String(describing: userId))")!
       
        // create the session object
        let session = URLSession.shared
        
        // now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as GET

        request.addValue(token!, forHTTPHeaderField: "token")
       
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
                let city = try JSONDecoder().decode(CityArray.self, from: responseData)
                completion(.success(httpResponse.statusCode))
                self.models = city.city
               // print("\(city)")
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        // perform the task
        task.resume()
    }
}
extension CityViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCities = models.filter({$0.lowercased().contains(searchText.lowercased())})
        self.tableViewCity.reloadData()
    }
}
extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        goDetail(city: models[indexPath.row])
    }
}

extension CityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchCities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
        cell.textLabel?.text = searchCities[indexPath.row]
            return cell
        }
}



struct CityData: Decodable, Equatable {
    
    let city : City
    
    
    struct City: Decodable, Equatable {
        let city : String
    }
}

extension CityArray: Decodable {
    init(from decoder: Decoder) throws {
        self.city = try decoder.singleValueContainer().decode([String].self)
    }
}

struct CityArray {
    let city: [String]
}


struct AllStationData: Decodable, Equatable {
    
    let station : AllStation
    
    
    struct AllStation: Decodable, Equatable {
        let id : Int
        let stationCode: String
        let sockets: [Sockets]
        let socketCount: Int
        let occupiedSocketCount: Int
        let distanceInKM: Double
        let geoLocation: GeoLocation
        let services: Services
        let stationName: String
        
    }
    struct Sockets : Decodable, Equatable {
        let socketID: Int
        let socketType: String
        let chargeType: String
        let power: Int
        let powerUnit: String
        let socketNumber: Int
    }
    struct GeoLocation : Decodable, Equatable {
        let longitude: Float
        let latitude: Float
        let province: String
        let address: String
    }
    struct Services : Decodable, Equatable {
        let services: [String]
    }
}

extension AllStation: Decodable {
    init(from decoder: Decoder) throws {
        self.station = try decoder.singleValueContainer().decode([AllStation].self)
    }
}

struct AllStation {
    let station: [AllStation]
}
